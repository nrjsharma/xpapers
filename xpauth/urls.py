from xpauth import views
from django.urls import path
app_name = 'auth'


urlpatterns = [
    path('login', views.LoginView.as_view(), name='login'),
    path('signup', views.SignUpView.as_view(), name='signup')
]
