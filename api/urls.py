# Django Imports
from django.conf.urls import url

# REST Framework Imports
from rest_framework import routers

# API View Imports
from api import views

app_name = 'api'

router = routers.DefaultRouter()
router.register(r'university-select2', views.UniversitySelect2ViewSet, base_name="university-select2")  # NOQA
router.register(r'collage-select2', views.CollageSelect2ViewSet, base_name="collage-select2")  # NOQA
router.register(r'course-select2', views.CourseSelect2ViewSet, base_name="course-select2")  # NOQA
router.register(r'subject-select2', views.SubjectSelect2ViewSet, base_name="subject-select2")  # NOQA
router.register(r'branch-select2', views.BranchSelect2ViewSet, base_name="branch-select2")  # NOQA
router.register(r'search', views.SearchViewSet, base_name="search")  # NOQA

urlpatterns = [
    url(r'^upload-paper/', views.UploadPaperView.as_view(), name="upload-paper"),
]

urlpatterns += router.urls