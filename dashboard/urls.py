from dashboard import views
from django.urls import path
app_name = 'dashboard'


urlpatterns = [
    path('', views.DashboardView.as_view(), name='dashboard'),
    path('upload-paper', views.UploadPaperView.as_view(), name='upload-paper'),
]
