# Django Imports
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
from api.serializer import (UniversitySelect2Serializer, CollageSelect2Serializer,
                            CourseSelect2Serializer, SubjectSelect2Serializer,
                            BranchSelect2Serializer)


# Models Imports
from dashboard.models import (University, Collage,
                              Course, Subject, Branch,
                              Post, PostFiles)


class UniversitySelect2ViewSet(ModelViewSet):
    serializer_class = UniversitySelect2Serializer
    permission_classes = (IsAuthenticated,)
    http_method_names = ['get', ]
    permission_classes = (AllowAny,)

    def get_queryset(self, *args, **kwargs):
        self.queryset = University.objects.all()
        search_query = self.request.GET.get('term', None)
        if search_query:
            return self.queryset.filter(name__icontains=search_query)
        return self.queryset


class CollageSelect2ViewSet(ModelViewSet):
    serializer_class = CollageSelect2Serializer
    permission_classes = (IsAuthenticated,)
    http_method_names = ['get', ]
    permission_classes = (AllowAny,)

    def get_queryset(self, *args, **kwargs):
        self.queryset = Collage.objects.all()
        search_query = self.request.GET.get('term', None)
        if search_query:
            return self.queryset.filter(name__icontains=search_query)
        return self.queryset


class CourseSelect2ViewSet(ModelViewSet):
    serializer_class = CourseSelect2Serializer
    permission_classes = (IsAuthenticated,)
    http_method_names = ['get', ]
    permission_classes = (AllowAny,)

    def get_queryset(self, *args, **kwargs):
        self.queryset = Course.objects.all()
        search_query = self.request.GET.get('term', None)
        if search_query:
            return self.queryset.filter(name__icontains=search_query)
        return self.queryset


class SubjectSelect2ViewSet(ModelViewSet):
    serializer_class = SubjectSelect2Serializer
    permission_classes = (IsAuthenticated,)
    http_method_names = ['get', ]
    permission_classes = (AllowAny,)

    def get_queryset(self, *args, **kwargs):
        self.queryset = Subject.objects.all()
        search_query = self.request.GET.get('term', None)
        if search_query:
            return self.queryset.filter(name__icontains=search_query)
        return self.queryset


class BranchSelect2ViewSet(ModelViewSet):
    serializer_class = BranchSelect2Serializer
    permission_classes = (IsAuthenticated,)
    http_method_names = ['get', ]
    permission_classes = (AllowAny,)

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
            for file in files:
                obj = PostFiles(post=post, file=file)  # NOQA
                obj.save()
            return Response({'data': post.id}, status=status.HTTP_201_CREATED)
        else:
            return Response({'data': '404'}, status=status.HTTP_404_NOT_FOUND)
