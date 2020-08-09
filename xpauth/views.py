from django.shortcuts import render
from django.views import View
from django.shortcuts import get_object_or_404
from xpauth.models import XpapersUser


class LoginView(View):
    template_name = 'auth/login.html'

    def get(self, request, path=None):
        return render(request, self.template_name)


class SignUpView(View):
    template_name = 'auth/signup.html'

    def get(self, request, path=None):
        return render(request, self.template_name)