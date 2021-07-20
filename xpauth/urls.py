from xpauth import views
from django.urls import path
app_name = 'auth'


urlpatterns = [
    path('login/', views.LoginView.as_view(), name='login'),
    path('signup/', views.SignUpView.as_view(), name='signupview'),
    path('set-username/', views.SetUsernameView.as_view(), name='set-username'),
    path('<str:username>/', views.ProfileView.as_view()),
    path('<str:username>/papers/', views.UserPapersView.as_view()),
]
