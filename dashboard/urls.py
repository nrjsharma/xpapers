from dashboard import views
from django.urls import path
app_name = 'dashboard'


urlpatterns = [
    path('upload-paper', views.UploadPaperView.as_view(), name='upload-paper'),
    path('s', views.SearchDataView.as_view(), name='show'),
    path('', views.DashboardView.as_view(), name='dashboard'),
    path('about-us/', views.AboutView.as_view(), name='about'),
    path('contact-us/', views.ContactView.as_view(), name='contact'),
    path('privacy-policy/', views.PrivacyPolicyView.as_view(), name='privacy-policy'),
    path('disclaimer/', views.DisclaimerView.as_view(), name='disclaimer'),
]
