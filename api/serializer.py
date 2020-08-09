# REST Framework Imports
from rest_framework import serializers, exceptions
from rest_framework.serializers import (ModelSerializer, Serializer,
                                        SerializerMethodField)

# Models Imports
from xpauth.models import XpapersUser
from dashboard.models import (University, Collage,
                              Course, Subject, Branch,
                              Post, PostFiles)


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


# Generic Serializer END <<

class SignupSerializer(ModelSerializer):
    class Meta:
        model = XpapersUser
        fields = ('username', 'email', 'password')

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
    class SubjectSerializer(ModelSerializer):
        class Meta:
            model = Subject
            fields = ('name', )

    class PostFileSerializer(ModelSerializer):
        class Meta:
            model = PostFiles
            fields = ('file', 'id')

    obj_type = SerializerMethodField()
    subject = SubjectSerializer()
    postfiles = PostFileSerializer(many=True)

    def get_obj_type(self, instance):
        return "post"

    class Meta:
        model = Post
        fields = ('id', 'subject', 'year', 'user', 'postfiles',  'obj_type')
