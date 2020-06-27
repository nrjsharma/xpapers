# REST Framework Imports
from rest_framework import serializers, exceptions
from rest_framework.serializers import (ModelSerializer, Serializer,
                                        SerializerMethodField)

# Models Imports
from dashboard.models import (University, Collage,
                              Course, Subject, Branch)


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
