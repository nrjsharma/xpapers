from django.shortcuts import render, redirect
from django.views import View
from django.shortcuts import get_object_or_404
from xpauth.models import XpapersUser


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
        profile_user = get_object_or_404(XpapersUser, username=kwargs['username'])
        editable = True if kwargs['username'] == request.user.username else False
        return render(request, self.template_name, {'profile_user': profile_user, 'editable': editable})


class UserPapersView(View):
    template_name = 'auth/user-papers.html'

    def get(self, request, *args, **kwargs):
        profile_user = get_object_or_404(XpapersUser, username=kwargs['username'])
        return render(request, self.template_name, {'profile_user': profile_user})
