from django.db import models
from allauth.socialaccount.models import SocialAccount
from django.contrib.auth.base_user import AbstractBaseUser, BaseUserManager
from django.core.exceptions import ValidationError
from xpauth.utils import get_upload_path_user


class XpapersUserManager(BaseUserManager):
    """
    custom user manager for Xpaper user
    this user manager is responsible for all
    CRUD operation over custom user modals
    """

    def create_user(self, username=None, email=None, password=None):
        if not username or username is None:
            raise ValidationError("User must have username")
        if not email or email is None:
            raise ValidationError("User must have email address")
        user = self.model(
            username=username,
            email=self.normalize_email(email),
        )
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, email, password):
        user = self.create_user(username=username,
                                email=email,
                                password=password)
        user.is_admin = True
        user.is_staff = True
        user.save(using=self._db)
        return user


class XpapersUser(AbstractBaseUser):
    """
    parent class for all users in xpapers application
    """
    email = models.EmailField(max_length=255, unique=True, db_index=True)
    username = models.CharField(max_length=255, unique=True, db_index=True)
    # Personal Information
    first_name = models.CharField(max_length=255, null=True, blank=True)
    last_name = models.CharField(max_length=255, null=True, blank=True)
    profile_image = models.FileField(upload_to=get_upload_path_user, null=True, blank=True)  # NOQA
    # Permissions
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)
    # Verification
    is_email_varified = models.BooleanField(default=False)
    # Other
    created = models.DateTimeField(auto_now_add=True)  # Automatically set the field to now when the object is first created.  # NOQA
    updated = models.DateTimeField(auto_now=True)  # Automatically set the field to now every time the object is saved.  # NOQA
    objects = XpapersUserManager()
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    def clean(self):
        if ' ' in self.username:
            raise ValidationError({'username': ('space is not allowed in username')})  # NOQA
        else:
            pass

    def get_short_name(self):
        if self.first_name:
            return self.first_name
        else:
            return self.email

    def get_full_name(self):
        if self.first_name and self.last_name:
            return "%s %s" % (self.first_name, self.last_name)
        else:
            return self.email

    def has_perm(self, perm, obj=None):
        return True

    def has_module_perms(self, app_label):
        return True

    @property
    def display_name(self):
        if self.first_name:
            return self.first_name
        else:
            return self.email

    @property
    def is_social(self):
        try:
            SocialAccount.objects.get(user=self)
            return True
        except SocialAccount.DoesNotExist:
            return False
