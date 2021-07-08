from django.shortcuts import render, redirect
from django.views import View


class LoginView(View):
    template_name = 'auth/login.html'

    def get(self, request, path=None):
        if request.user.is_authenticated:
            path = "/auth/profile/{username}/"
            return redirect(path.format(username=request.user.username))
        return render(request, self.template_name)


class SignUpView(View):
    template_name = 'auth/signup.html'

    def get(self, request, path=None):
        if request.user.is_authenticated:
            path = "/auth/profile/{username}/"
            return redirect(path.format(username=request.user.username))
        return render(request, self.template_name)


class ProfileView(View):
    template_name = 'auth/profile.html'

    def get(self, request, *args, **kwargs):
        return render(request, self.template_name)
