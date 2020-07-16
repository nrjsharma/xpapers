import io
import os
from celery import shared_task
from PyPDF2 import PdfFileWriter, PdfFileReader
from os.path import basename
from django.core.files import File
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from django.conf import settings
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from xpapers.utils import utils_get_random_string
from dashboard.models import Post, PostFiles


@shared_task
def celery_pdf_watermark(*args, **kwargs):
    print('####~~celery-PDF-watermark~~####')
    post_id = args[0]['post_id']
    filepath = args[0]['filepath']
    user = args[0]['user']
    post = Post.objects.get(id=post_id)
    packet = io.BytesIO()
    file_name = "%s %s" % (post.subject.name, post.year)
    # create a new PDF with Reportlab
    can = canvas.Canvas(packet, pagesize=letter)
    can.setFont('Helvetica', 12)
    can.drawString(20, 23, "for more visit:- xpapers.in")
    if user:
        can.drawString(20, 10, "@%s" % user)
        file_name += " Xpapers %s" % user.upper()
    else:
        file_name += " Xpapers"
    file_name += " (%s).pdf" % utils_get_random_string()
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
    path = default_storage.save('tmp/%s' % file_name, ContentFile(b""))
    tmp_file = os.path.join(settings.MEDIA_ROOT, path)
    outputStream = open(tmp_file, "wb")
    output.write(outputStream)
    outputStream.close()
    obj = PostFiles()  # NOQA
    obj.post = post
    obj.file.save(basename(outputStream.name), content=File(open(outputStream.name, 'rb')))
    default_storage.delete(filepath)
    default_storage.delete(tmp_file)