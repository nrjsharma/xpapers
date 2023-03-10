# Django Imports
from django.contrib.auth import login, logout
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from django.conf import settings
from allauth.socialaccount.models import SocialAccount
from django.shortcuts import get_object_or_404

# REST Framework Imports
from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import (IsAuthenticated, AllowAny,
                                        IsAuthenticatedOrReadOnly)  # NOQA
from rest_framework.authtoken.models import Token
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response

# API Imports
from api.serializer import (UniversitySelect2Serializer, CollageSelect2Serializer,
                            CourseSelect2Serializer, SubjectSelect2Serializer,
                            BranchSelect2Serializer, ShowUniversitySerializer, ShowCollageSerializer,
                            ShowCourseSerializer, ShowBranchSerializer, ShowSubjectSerializer,
                            ShowPostSerializer, GenericUniversitySerializer, SignupSerializer,
                            LoginSerializer, UpdateUserProfileSerializer, GetUserProfileSerializer,
                            SetUserNameSerializer)


# Models Imports
from dashboard.models import (University, Collage,
                              Course, Subject, Branch,
                              Post)
from xpauth.models import XpapersUser
# OTHER IMPORT
import os
from tempfile import NamedTemporaryFile
from xpapers.tasks import celery_pdf_watermark, celery_images_to_pdf
from xpapers.utils import utils_long_hash, utils_commaSeperatedString


class SignupViewSet(APIView):
    serializer_class = SignupSerializer
    permission_classes = (AllowAny,)
    http_method_names = ['post', ]

    def post(self, request):
        data = {
            "email": request.POST.get('email', None).lower(),
            "password": request.POST.get('password', None),
        }
        serializer = self.serializer_class(data=data)
        if serializer.is_valid():
            user = serializer.save()
            login(request, user)
            Token.objects.create(user=user)
            token = Token.objects.get(user=user).key
            return Response({'token': token, 'username': user.username},
                            status=status.HTTP_201_CREATED)  # NOQA
        else:
            return Response(data=serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class SetUserNameViewSet(ModelViewSet):
    queryset = XpapersUser.objects.all()
    serializer_class = SetUserNameSerializer
    permission_classes = (IsAuthenticated,)
    http_method_names = ['patch', ]

    def update(self, request, pk=None, *args, **kwargs):
        user = request.user
        data = {
            "username": request.POST.get('username', None).lower(),
        }
        serializer = self.serializer_class(instance=user,
                                           data=data,
                                           partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(data=serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(data=serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class LoginView(APIView):
    serializer_class = LoginSerializer
    permission_classes = (AllowAny,)
    http_method_names = ['post', ]

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data["user"]
        login(request, user)
        if not Token.objects.filter(user=user).exists():
            Token.objects.create(user=user)
            token = Token.objects.get(user=user).key
        token = Token.objects.get(user=user).key
        return Response({'token': token, 'username': user.username}, status=status.HTTP_200_OK)  # NOQA


class LogoutView(APIView):
    permission_classes = (IsAuthenticated,)
    http_method_names = ['post', ]

    def post(self, request):
        if Token.objects.filter(user=request.user).exists():
            Token.objects.get(user=request.user).delete()
        logout(request)
        return Response(status=status.HTTP_200_OK)


class DisconnectSocialView(APIView):
    permission_classes = (IsAuthenticated,)
    http_method_names = ['post', ]

    def post(self, request):
        user_social_account = get_object_or_404(SocialAccount, user=request.user)
        user_social_account.delete()
        return Response(status=status.HTTP_200_OK)


class UserProfileViewSet(ModelViewSet):
    queryset = XpapersUser.objects.none()
    permission_classes = (IsAuthenticatedOrReadOnly,)
    http_method_names = ['get', 'patch']

    def get_serializer_class(self):
        if self.action == "partial_update":
            return UpdateUserProfileSerializer
        return GetUserProfileSerializer

    def get_serializer_context(self, pk=None):
        context = super(UserProfileViewSet, self).get_serializer_context()
        context.update({"user": self.request.user})
        return context

    def list(self, request):
        if request.user.is_authenticated:
            return Response(self.get_serializer(request.user).data,
                            status=status.HTTP_200_OK)
        return Response(status=status.HTTP_401_UNAUTHORIZED)

    def retrieve(self, request, pk=None):
        instance = get_object_or_404(XpapersUser, username=pk)
        return Response(self.get_serializer(instance).data,
                        status=status.HTTP_200_OK)

    def update(self, request, pk=None, *args, **kwargs):
        if pk != request.user.username:
            return Response(data='USER UNAUTHORIZED', status=status.HTTP_401_UNAUTHORIZED)
        instance = request.user
        university = request.data.get('university', None)
        collage = request.data.get('collage', None)
        course = request.data.get('course', None)
        branch = request.data.get('branch', None)

        data = {
            "profile_image": request.FILES.get('profile_image', None),
            }

        if university:
            if '#Ea^T|@I^p<0>-' in university:
                university = university.split('-')[1]
            else:
                university = University.objects.create(name=university,
                                                       created_by=request.user)
                university = university.id
            data['university'] = university

        if university and collage:
            if '#Ea^T|@I^p<0>-' in collage:
                collage = collage.split('-')[1]
            else:
                university = get_object_or_404(University, id=university)
                collage = Collage.objects.create(name=collage,
                                                 university=university,
                                                 created_by=request.user)
                collage = collage.id
            data['collage'] = collage

        if course:
            if '#Ea^T|@I^p<0>-' in course:
                course = course.split('-')[1]
            else:
                course = Course.objects.create(name=course,
                                               created_by=request.user)
                course = course.id
            data['course'] = course

        if branch:
            if '#Ea^T|@I^p<0>-' in branch:
                branch = branch.split('-')[1]
            else:
                branch = Branch.objects.create(name=branch,
                                               created_by=request.user)
                branch = branch.id
            data['branch'] = branch

        serializer = self.get_serializer(instance=instance,
                                         data=data,
                                         partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(data=serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(data=serializer.errors, status=status.HTTP_400_BAD_REQUEST)


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
        uni_id = self.request.GET.get('uni', None)
        if uni_id == "null":
            self.queryset = Collage.objects.all()
        else:
            self.queryset = Collage.objects.filter(university__id=uni_id)
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


class UniversityViewSet(ModelViewSet):
    queryset = University.objects.all()
    serializer_class = GenericUniversitySerializer
    permission_classes = (AllowAny,)
    http_method_names = ['get', ]


class SearchObjectTypeViewSet(ModelViewSet):
    queryset = Post.objects.none()
    permission_classes = (AllowAny,)
    http_method_names = ['get', ]

    def list(self, request, *args, **kwargs):
        query_university = request.query_params.get('uni', None)
        query_course = request.query_params.get('cou', None)
        query_branch = request.query_params.get('bra', None)
        query_subject = request.query_params.get('sub', None)
        if query_university and \
                query_course and \
                query_branch and \
                query_subject:
            return Response({
                "data": "post",
            }, status=status.HTTP_200_OK)  # NOQA
        else:
            return Response({
                "data": "not_post",
            }, status=status.HTTP_200_OK)  # NOQA


class UploadPaperView(APIView):
    """
    This API will upload files from dashboard page
    """
    permission_classes = (AllowAny,)
    http_method_names = ['post', ]

    def save_file_temp(self, file, extension=None):
        if extension and file:
            temp_file = NamedTemporaryFile(delete=False, suffix=extension)
            with open(temp_file.name, 'wb') as f:
                 f.write(file.read())
            return temp_file.name
        return "400"

    def pdf_watermark(self, post_id, user, pdf_path):
        celery_data = {
            'user': user,
            'post_id': post_id,
            'filepath': pdf_path,
        }
        celery_pdf_watermark.delay(celery_data)

    def image_to_pdf_watermark(self, post_id, user, image_list):
        celery_data = {
            'user': user,
            'post_id': post_id,
            'image_list': image_list,
        }
        celery_images_to_pdf.delay(celery_data)

    def post(self, request):
        valid_image_extenstions = ['.jpeg', '.jpg']
        university = request.data.get('university', None)
        year = request.data.get('year', None)
        type = request.data.get('type', "F")
        collage = request.data.get('collage', None)
        course = request.data.get('course', None)
        branch = request.data.get('branch', None)
        subject = request.data.get('subject', None)
        if not university or \
                not year or \
                not course or \
                not branch or \
                not subject:
            return Response({'data': 'some data is missing'}, status=status.HTTP_400_BAD_REQUEST)

        if '#Ea^T|@I^p<0>-' in university:
            university_id = university.split('-')[1]
            university = get_object_or_404(University, id=university_id)
        else:
            university = University.objects.create(name=university)
            if request.user.is_authenticated:
                university.created_by = request.user
                university.save()

        if collage:
            if '#Ea^T|@I^p<0>-' in collage:
                collage_id = collage.split('-')[1]
                collage = get_object_or_404(Collage, id=collage_id)
            else:
                collage = Collage.objects.create(name=collage, university=university)
                if request.user.is_authenticated:
                    collage.created_by = request.user
                    collage.save()

        if '#Ea^T|@I^p<0>-' in course:
            course_id = course.split('-')[1]
            course = get_object_or_404(Course, id=course_id)
        else:
            course = Course.objects.create(name=course)
            if request.user.is_authenticated:
                course.created_by = request.user
                course.save()

        if '#Ea^T|@I^p<0>-' in branch:
            branch_id = branch.split('-')[1]
            branch = get_object_or_404(Branch, id=branch_id)
        else:
            branch = Branch.objects.create(name=branch)
            if request.user.is_authenticated:
                branch.created_by = request.user
                branch.save()

        if '#Ea^T|@I^p<0>-' in subject:
            subject_id = subject.split('-')[1]
            subject = get_object_or_404(Subject, id=subject_id)
        else:
            subject = Subject.objects.create(name=subject)
            if request.user.is_authenticated:
                subject.created_by = request.user
                subject.save()

        # Adding M2M keys in course model
        if not course.universities.filter(id=university.id).exists():
            course.universities.add(university)

        # Adding M2M keys in branch model
        if not branch.universities.filter(id=university.id).exists():
            branch.universities.add(university)
        if not branch.courses.filter(id=course.id).exists():
            branch.courses.add(course)

        # Adding M2M keys in subjects model
        if not subject.universities.filter(id=university.id).exists():
            subject.universities.add(university)
        if not subject.courses.filter(id=course.id).exists():
            subject.courses.add(course)
        if not subject.branches.filter(id=branch.id).exists():
            subject.branches.add(branch)

        if request.FILES.get('file', False):
            image_list = list()
            user = request.user.username if (request.user.is_authenticated and not request.user.id == 1) else None
            files = request.FILES.getlist('file')
            post = Post()
            post.year = year
            post.type = type
            post.university = university
            if collage:
                post.collage = collage
            post.course = course
            post.branch = branch
            post.subject = subject
            if request.user.is_authenticated:
                post.user = request.user
            post.save()
            for file in files:
                extension = os.path.splitext(file.name)[1]
                if extension == ".pdf":
                    if len(files) == 1:
                        pdf_path = self.save_file_temp(file, extension='.pdf')
                        if not pdf_path == "400":
                            self.pdf_watermark(post_id=post.id,
                                               user=user,
                                               pdf_path=pdf_path)
                            return Response({'data': post.id}, status=status.HTTP_201_CREATED)
                        return Response({'error': 'PDF Is Not Saved'},
                                        status=status.HTTP_400_BAD_REQUEST)  # NOQA
                    return Response({'error': 'Multiple PDF Not Allowed'}, status=status.HTTP_400_BAD_REQUEST)  # NOQA
                else:
                    if extension.lower() in valid_image_extenstions:
                        image_path = self.save_file_temp(file, extension='.jpg')
                        if not image_path == "400":
                            image_list.append(image_path)
                        else:
                            return Response({'error': 'Images Is Not Saved'},
                                            status=status.HTTP_400_BAD_REQUEST)  # NOQA
                    else:
                        return Response({'error': 'Invalid Extension'},
                                        status=status.HTTP_400_BAD_REQUEST)  # NOQA
            self.image_to_pdf_watermark(post_id=post.id, user=user, image_list=image_list)
            return Response({'data': post.id}, status=status.HTTP_201_CREATED)
        else:
            return Response({'data': '404'}, status=status.HTTP_404_NOT_FOUND)


class SearchViewSet(ModelViewSet):
    serializer_class = ShowCollageSerializer
    permission_classes = (AllowAny,)
    http_method_names = ['get', ]

    def get_queryset(self, *args, **kwargs):
        query_university = self.request.query_params.get('uni', None)
        query_course = self.request.query_params.get('cou', None)
        query_branch = self.request.query_params.get('bra', None)
        query_subject = self.request.query_params.get('sub', None)
        university = get_object_or_404(University, slug=query_university)
        if query_university and \
                not query_course and \
                not query_branch and \
                not query_subject:
            self.serializer_class = ShowCourseSerializer
            self.queryset = Course.objects.filter(universities=university)
        elif query_university and \
                query_course and \
                not query_branch and \
                not query_subject:
            course = get_object_or_404(Course, slug=query_course)
            self.serializer_class = ShowBranchSerializer
            self.queryset = Branch.objects.filter(universities=university, courses=course)
        elif query_university and \
                query_course and \
                query_branch and \
                not query_subject:
            course = get_object_or_404(Course, slug=query_course)
            branch = get_object_or_404(Branch, slug=query_branch)
            self.serializer_class = ShowSubjectSerializer
            self.queryset = Subject.objects.filter(universities=university,
                                                   courses=course,
                                                   branches=branch)
        elif query_university and \
                query_course and \
                query_branch and \
                query_subject:
            course = get_object_or_404(Course, slug=query_course)
            branch = get_object_or_404(Branch, slug=query_branch)
            subject = get_object_or_404(Subject, slug=query_subject)
            self.serializer_class = ShowPostSerializer
            self.queryset = Post.objects.filter(university=university,
                                                course=course,
                                                branch=branch,
                                                subject=subject).order_by('-year', '-id')
        else:
            self.queryset = Collage.objects.none()
        return self.queryset


class ShowUserPapersViewSet(ModelViewSet):
    queryset = Post.objects.none()
    permission_classes = (AllowAny,)
    http_method_names = ['get', ]

    def get_queryset(self, *args, **kwargs):
        user_instance = get_object_or_404(XpapersUser,
                                          username=self.request.GET.get('username', None))
        user_posts = Post.objects.filter(user=user_instance)
        query_university = self.request.query_params.get('uni', None)
        query_course = self.request.query_params.get('cou', None)
        query_branch = self.request.query_params.get('bra', None)
        query_subject = self.request.query_params.get('sub', None)
        university = None

        if query_university:
            university = get_object_or_404(University, slug=query_university)

        if not query_university and \
                not query_course and \
                not query_branch and \
                not query_subject:
            self.serializer_class = ShowUniversitySerializer
            self.queryset = University.objects.filter(
                id__in=user_posts.values_list('university').distinct()
            )
        elif query_university and \
                not query_course and \
                not query_branch and \
                not query_subject:
            self.serializer_class = ShowCourseSerializer
            self.queryset = Course.objects.filter(id__in=user_posts.values_list('course').distinct(),
                                                  universities=university,
                                                  )
        elif query_university and \
                query_course and \
                not query_branch and \
                not query_subject:
            course = get_object_or_404(Course, slug=query_course)
            user_posts = user_posts.filter(course=course)
            self.serializer_class = ShowBranchSerializer
            self.queryset = Branch.objects.filter(id__in=user_posts.values_list('branch').distinct(),
                                                  universities=university,
                                                  courses=course,
                                                  )
        elif query_university and \
                query_course and \
                query_branch and \
                not query_subject:
            course = get_object_or_404(Course, slug=query_course)
            branch = get_object_or_404(Branch, slug=query_branch)
            user_posts = user_posts.filter(branch=branch)
            self.serializer_class = ShowSubjectSerializer
            self.queryset = Subject.objects.filter(id__in=user_posts.values_list('subject').distinct(),
                                                   universities=university,
                                                   courses=course,
                                                   branches=branch
                                                   )
        elif query_university and \
                query_course and \
                query_branch and \
                query_subject:
            subject = get_object_or_404(Subject, slug=query_subject)
            self.serializer_class = ShowPostSerializer
            self.queryset = user_posts.filter(subject=subject)
        else:
            self.queryset = Post.objects.none()
        return self.queryset
