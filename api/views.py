# Django Imports
import os
import tempfile
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from django.conf import settings

from django.contrib.auth import login, logout
from django.shortcuts import get_object_or_404

# REST Framework Imports
from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAuthenticated, AllowAny  # NOQA
from rest_framework.authtoken.models import Token
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response

# API Imports
from api.serializer import (GenericUniversitySerializer, GenericCollageSerializer, GenericCourseSerializer,
                            GenericBranchSerializer, GenericSubjectSerializer, UniversitySelect2Serializer,
                            CollageSelect2Serializer, CourseSelect2Serializer, SubjectSelect2Serializer,
                            BranchSelect2Serializer, ShowCollageSerializer, ShowCourseSerializer,
                            ShowBranchSerializer, ShowSubjectSerializer)


# Models Imports
from dashboard.models import (University, Collage,
                              Course, Subject, Branch,
                              Post, PostFiles)
# OTHER IMPORT
from xpapers.tasks import celery_pdf_watermark
from xpapers.utils import utils_long_hash
import img2pdf


class UniversitySelect2ViewSet(ModelViewSet):
    serializer_class = UniversitySelect2Serializer
    permission_classes = (AllowAny,)
    http_method_names = ['get', ]

    def get_queryset(self, *args, **kwargs):
        self.queryset = University.objects.all()
        search_query = self.request.GET.get('term', None)
        if search_query:
            return self.queryset.filter(name__icontains=search_query)
        return self.queryset


class CollageSelect2ViewSet(ModelViewSet):
    serializer_class = CollageSelect2Serializer
    permission_classes = (AllowAny,)
    http_method_names = ['get', ]

    def get_queryset(self, *args, **kwargs):
        self.queryset = Collage.objects.all()
        search_query = self.request.GET.get('term', None)
        if search_query:
            return self.queryset.filter(name__icontains=search_query)
        return self.queryset


class CourseSelect2ViewSet(ModelViewSet):
    serializer_class = CourseSelect2Serializer
    permission_classes = (AllowAny,)
    http_method_names = ['get', ]

    def get_queryset(self, *args, **kwargs):
        self.queryset = Course.objects.all()
        search_query = self.request.GET.get('term', None)
        if search_query:
            return self.queryset.filter(name__icontains=search_query)
        return self.queryset


class SubjectSelect2ViewSet(ModelViewSet):
    serializer_class = SubjectSelect2Serializer
    permission_classes = (AllowAny,)
    http_method_names = ['get', ]

    def get_queryset(self, *args, **kwargs):
        self.queryset = Subject.objects.all()
        search_query = self.request.GET.get('term', None)
        if search_query:
            return self.queryset.filter(name__icontains=search_query)
        return self.queryset


class BranchSelect2ViewSet(ModelViewSet):
    serializer_class = BranchSelect2Serializer
    permission_classes = (AllowAny,)
    http_method_names = ['get', ]

    def get_queryset(self, *args, **kwargs):
        self.queryset = Branch.objects.all()
        search_query = self.request.GET.get('term', None)
        if search_query:
            return self.queryset.filter(name__icontains=search_query)
        return self.queryset


class UploadPaperView(APIView):
    """
    This API will upload files from dashboard page
    """
    permission_classes = (AllowAny,)
    http_method_names = ['post', ]

    def pdf_watermark(self, post, user, file, create_pdf=True):
        if create_pdf:
            file_name = "%s.pdf" % utils_long_hash()
            path = default_storage.save('tmp/%s' % file_name, ContentFile(file.read()))
            tmp_file = os.path.join(settings.MEDIA_ROOT, path)
        else:
            tmp_file = file
        celery_data = {
            'user': user,
            'post_id': post.id,
            'filepath': tmp_file
        }
        celery_pdf_watermark.delay(celery_data)

    def post(self, request):
        university = request.data.get('university', None)
        year = request.data.get('year', None)
        collage = request.data.get('collage', None)
        course = request.data.get('course', None)
        branch = request.data.get('branch', None)
        subject = request.data.get('subject', None)

        if not university or \
                not year or \
                not collage or \
                not course or \
                not branch or \
                not subject:
            return Response({'data': 'some data is missing'}, status=status.HTTP_400_BAD_REQUEST)

        if '#Ea^T|@I^p<0>-' in university:
            university_id = university.split('-')[1]
            university = get_object_or_404(University, id=university_id)
        else:
            university = University.objects.create(name=university)

        if '#Ea^T|@I^p<0>-' in collage:
            collage_id = collage.split('-')[1]
            collage = get_object_or_404(Collage, id=collage_id)
        else:
            collage = Collage.objects.create(name=collage)

        if '#Ea^T|@I^p<0>-' in course:
            course_id = course.split('-')[1]
            course = get_object_or_404(Course, id=course_id)
        else:
            course = Course.objects.create(name=course)

        if '#Ea^T|@I^p<0>-' in branch:
            branch_id = branch.split('-')[1]
            branch = get_object_or_404(Branch, id=branch_id)
        else:
            branch = Branch.objects.create(name=branch)

        if '#Ea^T|@I^p<0>-' in subject:
            subject_id = subject.split('-')[1]
            subject = get_object_or_404(Subject, id=subject_id)
        else:
            subject = Subject.objects.create(name=subject)

        if request.FILES.get('file', False):
            image_list = list()
            user = request.user.username if (request.user.is_authenticated and not request.user.id == 1) else None
            files = request.FILES.getlist('file')
            post = Post()
            post.year = year
            post.university = university
            post.collage = collage
            post.course = course
            post.branch = branch
            post.subject = subject
            if request.user.is_authenticated:
                post.user = request.user
            post.save()
            pdf_path = "file.pdf"
            for file in files:
                # self.pdf_watermark(post=post, user=user, file=file, create_pdf=True)
                file_name = "%s.jpg" % utils_long_hash()
                path = default_storage.save('tmp/%s' % file_name, ContentFile(file.read()))
                tmp_file = os.path.join(settings.MEDIA_ROOT, path)
                image_list.append(tmp_file)
            with open(pdf_path, "wb") as f:
                f.write(img2pdf.convert([img for img in image_list]))
                self.pdf_watermark(post=post, user=user, file=f.name, create_pdf=False)
            return Response({'data': post.id}, status=status.HTTP_201_CREATED)
        else:
            return Response({'data': '404'}, status=status.HTTP_404_NOT_FOUND)


class SearchViewSet(ModelViewSet):
    serializer_class = ShowCollageSerializer
    permission_classes = (AllowAny,)
    http_method_names = ['get', ]

    def get_queryset(self, *args, **kwargs):
        query_university = self.request.query_params.get('uni', None)
        query_collage = self.request.query_params.get('col', None)
        query_course = self.request.query_params.get('cou', None)
        query_branch = self.request.query_params.get('bra', None)
        query_subject = self.request.query_params.get('sub', None)

        if query_university and \
                not query_collage and \
                not query_course and \
                not query_branch and \
                not query_subject:
            self.queryset = Collage.objects.all()
        elif query_university and \
                query_collage and \
                not query_course and \
                not query_branch and \
                not query_subject:
            self.serializer_class = ShowCourseSerializer
            self.queryset = Course.objects.all()
        elif query_university and \
                query_collage and \
                query_course and \
                not query_branch and \
                not query_subject:
            self.serializer_class = ShowBranchSerializer
            self.queryset = Branch.objects.all()
        elif query_university and \
                query_collage and \
                query_course and \
                query_branch and \
                not query_subject:
            self.serializer_class = ShowSubjectSerializer
            self.queryset = Subject.objects.all()
        else:
            print('400')

        return self.queryset