import io
import os
import img2pdf
from sentry_sdk import push_scope, capture_exception
from tempfile import NamedTemporaryFile
from celery import shared_task
from PyPDF2 import PdfFileWriter, PdfFileReader
from os.path import basename
from django.core.files import File
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from django.conf import settings
from PIL import Image, ImageDraw, ImageFont
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from dashboard.models import Post, PostFiles
from xpapers.utils import utils_long_hash


@shared_task
def celery_pdf_watermark(*args, **kwargs):
    print('####~~celery-PDF-watermark~~####')
    post_id = args[0]['post_id']
    filepath = args[0]['filepath']
    user = args[0]['user']
    post = Post.objects.get(id=post_id)
    # creating file name
    if post.subject.acronym:
        file_name = post.subject.acronym.replace(".", "").upper()
    else:
        file_name = post.subject.name.replace(" ", "-").upper()
    file_name += " %s %s" % (post.get_type_display().upper(), post.year)
    if user:
        file_name += " %s Xpapers.pdf" % user.upper()
    else:
        file_name += " Xpapers.pdf"
    try:
        packet = io.BytesIO()
        # create a new PDF with Reportlab
        can = canvas.Canvas(packet, pagesize=letter)
        can.setFont('Helvetica', 12)
        can.drawString(20, 23, "for more visit:- xpapers.in")
        if user:
            can.drawString(20, 10, "@%s" % user)
        can.save()
        packet.seek(0)
        new_pdf = PdfFileReader(packet)
        existing_pdf = PdfFileReader(open(filepath, "rb"))
        if existing_pdf.isEncrypted:
            existing_pdf.decrypt('')
        output = PdfFileWriter()
        for i in range(existing_pdf.getNumPages()):
            page = existing_pdf.getPage(i)
            page.mergePage(new_pdf.getPage(0))
            output.addPage(page)
        temp_file = NamedTemporaryFile(delete=False, suffix='.pdf')
        outputStream = open(temp_file.name, "wb")
        output.write(outputStream)
        outputStream.close()
        obj = PostFiles()  # NOQA
        obj.post = post
        obj.file.save(basename(file_name), content=File(open(outputStream.name, 'rb')))
        os.remove(temp_file.name)
    except Exception as e:
        print('$$~~ ERROR ~ PDF~WATER~MARK ~ ERROR ~~$$ POST-ID -%s- Exception %s' % (post_id, e))
        with push_scope() as scope:
            scope.set_tag("Place", "celery-PDF-watermark")
            scope.set_extra("Post ID", post_id)
            scope.set_extra('User', user)
            scope.level = 'error'
            capture_exception(e)
        obj = PostFiles()  # NOQA
        obj.post = post
        obj.file.save(basename(file_name), content=File(open(filepath, 'rb')))
    finally:
        os.remove(filepath)


@shared_task
def celery_images_to_pdf(*args, **kwargs):
    print('####~~celery-images_to_pdf~~####')
    user_login = False
    static_root = os.path.join(settings.BASE_DIR, 'static')
    promotion_image_path = os.path.join(static_root,
                                        'utils/upload_papers_utils/pdf_promotion_image.jpg')
    coval_font_path = os.path.join(static_root,
                                   'utils/upload_papers_utils/Coval-Black.otf')
    image_list = args[0]['image_list']
    user = args[0]['user']
    post_id = args[0]['post_id']
    if user:
        # Adding name of user in pdf promotion image
        try:
            image = Image.open(promotion_image_path)
            draw = ImageDraw.Draw(image)
            font = ImageFont.truetype(coval_font_path, size=45)
            (x, y) = (480, 400)
            name = "@" + user
            color = 'rgb(0, 0, 0)' # white color
            draw.text((x, y), name, fill=color, font=font)
            temp_promotion_file = NamedTemporaryFile(delete=False, suffix='.jpg')
            image.save(temp_promotion_file)
            image_list.append(temp_promotion_file.name)
            user_login = True
        except Exception as e:
            print('$$~~ ERROR ~ PDF~PROMOTION~IMAGE ~ ERROR ~~$$ POST-ID -%s- Exception %s' % (post_id, e))
            with push_scope() as scope:
                scope.set_tag("Place", "celery-PDF-Promotion-Image")
                scope.set_extra("Post ID", post_id)
                scope.set_extra('User', user)
                scope.level = 'error'
                capture_exception(e)
    else:
        image_list.append(promotion_image_path)
    try:
        temp_file = NamedTemporaryFile(delete=False, suffix='.pdf')
        with open(temp_file.name, "wb") as f:
            f.write(img2pdf.convert([img for img in image_list]))
            celery_data = {
                'user': user,
                'post_id': post_id,
                'filepath': f.name,
            }
        celery_pdf_watermark(celery_data)
        for img in image_list:
            if not user_login and img == image_list[-1]:
                # Not to delete static pdf promotion image
                # if user is not loged in
                continue
            os.remove(img)
    except Exception as e:
        print('$$~~ ERROR ~ IMAGE~TO~PDF ~ ERROR ~~$$ POST-ID -%s- Exception %s' % (post_id, e))
        with push_scope() as scope:
            scope.set_tag("Place", "celery-images_to_pdf")
            scope.set_extra("Post ID", post_id)
            scope.set_extra('Image-Path', image_list)
            scope.set_extra('User', user)
            scope.level = 'error'
            capture_exception(e)
