from django.db import models, transaction
from django.conf import settings
from django.utils.text import slugify
from django.db.models.signals import pre_save
from django.core.exceptions import ValidationError
from django.dispatch import receiver
from dashboard.utils import (get_upload_path_collage,
                             get_upload_path_uni,
                             get_upload_path_post_file)


class University(models.Model):
    name = models.CharField(max_length=500, unique=True)
    acronym = models.CharField(max_length=50, null=True, blank=True)
    created = models.DateTimeField(auto_now_add=True)
    thumbnail = models.FileField(upload_to=get_upload_path_uni,
                                 null=True, blank=True)  # NOQA
    description = models.TextField(null=True, blank=True)
    about = models.TextField(null=True, blank=True)
    url = models.URLField(max_length=1000, null=True, blank=True)
    slug = models.SlugField(max_length=500)
    is_verified = models.BooleanField(default=False)
    created_by = models.ForeignKey(settings.AUTH_USER_MODEL,
                                   related_name="universities", null=True, blank=True,
                                   on_delete=models.SET_NULL)  # NOQA
    created = models.DateTimeField(auto_now_add=True, null=True, blank=True)

    class Meta:
        verbose_name_plural = "Universities"

    def save(self, *args, **kwargs):
        self.name = self.name.upper()
        if self.acronym:
            self.acronym = self.acronym.upper()
        if self.created_by and self.created_by.is_admin:
            self.is_verified = True
        super(University, self).save(*args, **kwargs)

    def __str__(self):
        return "(%s) %s" % (self.id, self.name)

    def get_absolute_url(self):
        return "/s?uni=%s" % self.slug


class Collage(models.Model):
    name = models.CharField(max_length=500, unique=True)
    acronym = models.CharField(max_length=50, null=True, blank=True)
    created = models.DateTimeField(auto_now_add=True)
    thumbnail = models.FileField(upload_to=get_upload_path_collage,
                                 null=True, blank=True)  # NOQA
    university = models.ForeignKey(University,
                                   related_name="colleagues", on_delete=models.CASCADE)  # NOQA
    slug = models.SlugField(max_length=500)
    is_verified = models.BooleanField(default=False)
    created_by = models.ForeignKey(settings.AUTH_USER_MODEL,
                                   related_name="colleagues", null=True, blank=True,
                                   on_delete=models.SET_NULL)  # NOQA
    created = models.DateTimeField(auto_now_add=True, null=True, blank=True)

    class Meta:
        verbose_name_plural = "Colleagues"

    def save(self, *args, **kwargs):
        self.name = self.name.upper()
        if self.acronym:
            self.acronym = self.acronym.upper()
        if self.created_by and self.created_by.is_admin:
            self.is_verified = True
        super(Collage, self).save(*args, **kwargs)

    def __str__(self):
        return "(%s) %s" % (self.id, self.name)


class Course(models.Model):
    name = models.CharField(max_length=500, unique=True)
    acronym = models.CharField(max_length=50, null=True, blank=True)
    created = models.DateTimeField(auto_now_add=True)
    slug = models.SlugField(max_length=500)
    universities = models.ManyToManyField(
        University, related_name="courses")
    is_verified = models.BooleanField(default=False)
    created_by = models.ForeignKey(settings.AUTH_USER_MODEL,
                                   related_name="courses", null=True, blank=True,
                                   on_delete=models.SET_NULL)  # NOQA
    created = models.DateTimeField(auto_now_add=True, null=True, blank=True)

    class Meta:
        verbose_name_plural = "Courses"

    def save(self, *args, **kwargs):
        self.name = self.name.upper()
        if self.acronym:
            self.acronym = self.acronym.upper()
        if self.created_by and self.created_by.is_admin:
            self.is_verified = True
        super(Course, self).save(*args, **kwargs)

    def __str__(self):
        return "(%s) %s" % (self.id, self.name)


class Branch(models.Model):
    name = models.CharField(max_length=500, unique=True)
    acronym = models.CharField(max_length=50, null=True, blank=True)
    created = models.DateTimeField(auto_now_add=True)
    slug = models.SlugField(max_length=500)
    universities = models.ManyToManyField(
        University, related_name="branches")
    courses = models.ManyToManyField(
        Course, related_name="branches")
    is_verified = models.BooleanField(default=False)
    created_by = models.ForeignKey(settings.AUTH_USER_MODEL,
                                   related_name="branches", null=True, blank=True,
                                   on_delete=models.SET_NULL)  # NOQA
    created = models.DateTimeField(auto_now_add=True, null=True, blank=True)

    class Meta:
        verbose_name_plural = "Branches"

    def save(self, *args, **kwargs):
        self.name = self.name.upper()
        if self.acronym:
            self.acronym = self.acronym.upper()
        if self.created_by and self.created_by.is_admin:
            self.is_verified = True
        super(Branch, self).save(*args, **kwargs)

    def __str__(self):
        return "(%s) %s" % (self.id, self.name)


class Subject(models.Model):
    name = models.CharField(max_length=500, unique=True)
    acronym = models.CharField(max_length=50, null=True, blank=True)
    created = models.DateTimeField(auto_now_add=True)
    slug = models.SlugField(max_length=500)
    universities = models.ManyToManyField(
        University, related_name="subjects")
    courses = models.ManyToManyField(
        Course, related_name="subjects")
    branches = models.ManyToManyField(
        Branch, related_name="subjects")
    is_verified = models.BooleanField(default=False)
    created_by = models.ForeignKey(settings.AUTH_USER_MODEL,
                                   related_name="subjects", null=True, blank=True,
                                   on_delete=models.SET_NULL)  # NOQA
    created = models.DateTimeField(auto_now_add=True, null=True, blank=True)

    class Meta:
        verbose_name_plural = "Subjects"

    def save(self, *args, **kwargs):
        self.name = self.name.upper()
        if self.acronym:
            self.acronym = self.acronym.upper()
        if self.created_by and self.created_by.is_admin:
            self.is_verified = True
        super(Subject, self).save(*args, **kwargs)

    def __str__(self):
        return "(%s) %s" % (self.id, self.name)


class Post(models.Model):
    POST_CHOICES = (
        ('M', 'M.S.T'),
        ('F', 'Final'),
    )
    year = models.IntegerField()
    university = models.ForeignKey(University,
                                   related_name="posts", on_delete=models.CASCADE)  # NOQA
    collage = models.ForeignKey(Collage,
                                related_name="posts", null=True, blank=True, on_delete=models.CASCADE)  # NOQA
    course = models.ForeignKey(Course,
                               related_name="posts", on_delete=models.CASCADE)  # NOQA
    branch = models.ForeignKey(Branch,
                               related_name="posts", on_delete=models.CASCADE)  # NOQA
    subject = models.ForeignKey(Subject,
                                related_name="posts", on_delete=models.CASCADE)  # NOQA
    created = models.DateTimeField(auto_now_add=True)
    type = models.CharField(max_length=1, choices=POST_CHOICES, default='F')
    is_verified = models.BooleanField(default=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                             related_name="posts", null=True, blank=True,
                             on_delete=models.SET_NULL)  # NOQA

    def __str__(self):
        return "%s" % (self.id,)

    def save(self, *args, **kwargs):
        if self.user and self.user.is_admin:
            self.is_verified = True
        super(Post, self).save(*args, **kwargs)


class PostFiles(models.Model):
    post = models.ForeignKey(Post,
                             related_name="postfiles", on_delete=models.CASCADE)  # NOQA
    file = models.FileField(upload_to=get_upload_path_post_file)

    class Meta:
        verbose_name_plural = "PostFiles"

    def __str__(self):
        return "%s" % (self.id,)


class SiteMapURL(models.Model):
    url = models.CharField(max_length=1000, unique=True, help_text="URL example \"/s?uni=punjabi-university&cou=btech\"")
    is_active = models.BooleanField(default=True)

    class Meta:
        verbose_name_plural = "SitemapUrl's"

    def clean(self):
        if self.url:
            if "." in self.url:
                raise ValidationError("URL should not include \".\"")
            if not self.url[0] == "/":
                self.url = "%s%s" % ("/", self.url)
    
    def get_absolute_url(self):
        return self.url


@receiver(pre_save, sender=University)
@receiver(pre_save, sender=Collage)
@receiver(pre_save, sender=Course)
@receiver(pre_save, sender=Branch)
@receiver(pre_save, sender=Subject)
def pre_save_level(sender, instance=None, *args, **kwargs):
    slug = slugify(instance.name)
    instance.slug = slug
