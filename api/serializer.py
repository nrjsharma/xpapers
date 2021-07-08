# Django Imports
from django.contrib.auth import authenticate


# REST Framework Imports
from rest_framework import serializers, exceptions
from rest_framework.serializers import (ModelSerializer, Serializer,
                                        SerializerMethodField)

# Models Imports
from xpauth.models import XpapersUser
from dashboard.models import (University, Collage,
                              Course, Subject, Branch,
                              Post, PostFiles)

from xpapers.utils import utils_get_random_number


# Generic Serializer
class GenericUniversitySerializer(ModelSerializer):
    class Meta:
        model = University
        fields = "__all__"


class GenericCollageSerializer(ModelSerializer):
    class Meta:
        model = Collage
        fields = "__all__"


class GenericCourseSerializer(ModelSerializer):
    class Meta:
        model = Course
        fields = "__all__"


class GenericSubjectSerializer(ModelSerializer):
    class Meta:
        model = Subject
        fields = "__all__"


class GenericBranchSerializer(ModelSerializer):
    class Meta:
        model = Branch
        fields = "__all__"


class GenericUserSerializer(ModelSerializer):
    class Meta:
        model = XpapersUser
        fields = ('username', )

# Generic Serializer END <<


class SignupSerializer(ModelSerializer):

    def get_username(self, email=None):
        counter = 0
        if not email:
            return None
        username = email.split("@")[0]
        while counter <= 5:
            counter += 1
            if XpapersUser.objects.filter(username=username).exists():
                username = username + utils_get_random_number(True)
            else:
                break
        return username

    def validate(self, validated_data):
        email = validated_data.get('email', None)
        validated_data['username'] = self.get_username(email)
        return validated_data

    def create(self, validated_data):
        user = XpapersUser.objects.create(
            username=validated_data['username'],
            email=validated_data['email'],
        )
        user.set_password(validated_data['password'])
        user.save()
        user = authenticate(email=validated_data['email'],
                            password=validated_data['password'])  # NOQA
        return user

    class Meta:
        model = XpapersUser
        write_only_fields = ('password',)
        fields = ('email', 'password')


class LoginSerializer(Serializer):
    email = serializers.CharField()
    password = serializers.CharField()

    def validate(self, validated_data):
        email = validated_data.get('email', None)
        password = validated_data.get('password', None)
        if email and password:
            user = authenticate(email=email, password=password)  # NOQA
            if user:
                if user.is_active:
                    validated_data['user'] = user
                else:
                    raise exceptions.ValidationError(detail='user is deactivated')  # NOQA
            else:
                raise exceptions.NotFound(detail='user not found')
        else:
            raise exceptions.ValidationError(detail='email or password is not provided')  # NOQA
        return validated_data


class UniversitySelect2Serializer(ModelSerializer):
    class Meta:
        model = University
        fields = ('id', 'name')


class CollageSelect2Serializer(ModelSerializer):
    class Meta:
        model = Collage
        fields = ('id', 'name')


class CourseSelect2Serializer(ModelSerializer):
    class Meta:
        model = Course
        fields = ('id', 'name')


class SubjectSelect2Serializer(ModelSerializer):
    class Meta:
        model = Subject
        fields = ('id', 'name')


class BranchSelect2Serializer(ModelSerializer):
    class Meta:
        model = Branch
        fields = ('id', 'name')


class ShowCollageSerializer(ModelSerializer):
    obj_type = SerializerMethodField()

    def get_obj_type(self, instance):
        return "collage"

    class Meta:
        model = Collage
        fields = ('id', 'name', 'obj_type', 'slug')


class ShowCourseSerializer(ModelSerializer):
    obj_type = SerializerMethodField()

    def get_obj_type(self, instance):
        return "course"

    class Meta:
        model = Course
        fields = ('id', 'name', 'obj_type', 'slug')


class ShowBranchSerializer(ModelSerializer):
    obj_type = SerializerMethodField()

    def get_obj_type(self, instance):
        return "branch"

    class Meta:
        model = Branch
        fields = ('id', 'name', 'obj_type', 'slug')


class ShowSubjectSerializer(ModelSerializer):
    obj_type = SerializerMethodField()

    def get_obj_type(self, instance):
        return "subject"

    class Meta:
        model = Subject
        fields = ('id', 'name', 'obj_type', 'slug')


class ShowPostSerializer(ModelSerializer):
    class PostFileSerializer(ModelSerializer):
        class Meta:
            model = PostFiles
            fields = ('file', 'id')

    type = SerializerMethodField()
    collage = SerializerMethodField()
    subject = SerializerMethodField()
    user = SerializerMethodField()
    postfiles = PostFileSerializer(many=True)

    def get_type(self, instance):
        return instance.get_type_display()

    def get_collage(self, instance):
        return instance.collage.name if instance.collage else "-"

    def get_subject(self, instance):
        return instance.subject.name
    
    def get_user(self, instance):
        if instance.user and instance.user.id == 1:
            return "admin"
        elif instance.user:
            return instance.user.username
        else:
            return 'anon'

    class Meta:
        model = Post
        fields = ('id', 'subject', 'type', 'year', 'collage',
                  'user', 'postfiles')
