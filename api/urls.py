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
router.register(r'search-object', views.SearchObjectTypeViewSet, base_name="search-object")  # NOQA
router.register(r'search', views.SearchViewSet, base_name="search")  # NOQA
router.register(r'show-user-papers', views.ShowUserPapersViewSet, base_name="show-user-papers")  # NOQA
router.register(r'university', views.UniversityViewSet, base_name="university")  # NOQA
router.register(r'user-profile', views.UserProfileViewSet, base_name="user-profile")  # NOQA
router.register(r'set-username', views.SetUserNameViewSet, base_name="set-username")  # NOQA

urlpatterns = [
    url(r'^upload-paper/', views.UploadPaperView.as_view(), name="upload-paper"),
    url(r'^login/', views.LoginView.as_view(), name="login"),
    url(r'^signup/', views.SignupViewSet.as_view(), name="signup"),
    url(r'^logout/', views.LogoutView.as_view(), name="logout"),
    url(r'^disconnect-social/', views.DisconnectSocialView.as_view(), name="disconnect-social"),
]

urlpatterns += router.urls