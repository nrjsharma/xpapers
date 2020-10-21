from dashboard import views
from django.urls import path
app_name = 'dashboard'


urlpatterns = [
    path('upload-paper', views.UploadPaperView.as_view(), name='upload-paper'),
    path('s', views.SearchDataView.as_view(), name='show'),
    path('', views.DashboardView.as_view(), name='dashboard'),
]
