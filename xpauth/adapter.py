from xpauth.models import XpapersUser
from allauth.socialaccount.adapter import DefaultSocialAccountAdapter
from allauth.exceptions import ImmediateHttpResponse
from django.shortcuts import redirect
from django.contrib import messages


class SocialAccountAdapter(DefaultSocialAccountAdapter):

    def pre_social_login(self, request, sociallogin):

        # 1. social account already exists
        if sociallogin.is_existing:
            return

        # 2. social account has no email or email is unknown, return
        if 'email' not in sociallogin.account.extra_data:
            messages.error(request, 'email is not provided', extra_tags='custom')
            raise ImmediateHttpResponse(redirect('/auth/login/'))

        # 3. link auth user account to social account
        try:
            email = sociallogin.account.extra_data['email']
            user = XpapersUser.objects.get(email__iexact=email)
            if request.user.is_authenticated:
                if request.user.email == email:
                    sociallogin.connect(request, user)  # linking account
                    return
                messages.error(request, 'Gmail didn\'t match the user email', extra_tags='custom')
                profile_path = "/user/{username}/"
                raise ImmediateHttpResponse(redirect(profile_path.format(username=request.user.username)))

            messages.error(request, 'Google account isn\'t associated with Xpapers account', extra_tags='custom')
            raise ImmediateHttpResponse(redirect('/auth/login/'))
        except XpapersUser.DoesNotExist:
            if request.user.is_authenticated:
                messages.error(request, 'Gmail didn\'t match the user email', extra_tags='custom')
                profile_path = "/user/{username}/"
                raise ImmediateHttpResponse(redirect(profile_path.format(username=request.user.username)))
            return
                                
