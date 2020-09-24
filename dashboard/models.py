from django.db import models, transaction
from django.conf import settings
from django.utils.text import slugify
from django.db.models.signals import pre_save
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
    slug = models.SlugField(max_length=500)

    class Meta:
        verbose_name_plural = "Universities"

    def save(self, *args, **kwargs):
        self.name = self.name.upper()
        if self.acronym:
            self.acronym = self.acronym.upper()
        super(University, self).save(*args, **kwargs)

    def __str__(self):
        return "%s" % (self.id,)

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

    class Meta:
        verbose_name_plural = "Colleagues"

    def save(self, *args, **kwargs):
        self.name = self.name.upper()
        if self.acronym:
            self.acronym = self.acronym.upper()
        super(Collage, self).save(*args, **kwargs)

    def __str__(self):
        return "%s" % (self.id,)


class Course(models.Model):
    name = models.CharField(max_length=500, unique=True)
    acronym = models.CharField(max_length=50, null=True, blank=True)
    created = models.DateTimeField(auto_now_add=True)
    slug = models.SlugField(max_length=500)
    universities = models.ManyToManyField(
        University, related_name="courses")

    class Meta:
        verbose_name_plural = "Courses"

    def save(self, *args, **kwargs):
        self.name = self.name.upper()
        if self.acronym:
            self.acronym = self.acronym.upper()
        super(Course, self).save(*args, **kwargs)

    def __str__(self):
        return "%s" % (self.id,)


class Branch(models.Model):
    name = models.CharField(max_length=500, unique=True)
    acronym = models.CharField(max_length=50, null=True, blank=True)
    created = models.DateTimeField(auto_now_add=True)
    slug = models.SlugField(max_length=500)
    universities = models.ManyToManyField(
        University, related_name="branches")
    courses = models.ManyToManyField(
        Course, related_name="branches")

    class Meta:
        verbose_name_plural = "Branches"

    def save(self, *args, **kwargs):
        self.name = self.name.upper()
        if self.acronym:
            self.acronym = self.acronym.upper()
        super(Branch, self).save(*args, **kwargs)

    def __str__(self):
        return "%s" % (self.id,)


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

    class Meta:
        verbose_name_plural = "Subjects"

    def save(self, *args, **kwargs):
        self.name = self.name.upper()
        if self.acronym:
            self.acronym = self.acronym.upper()
        super(Subject, self).save(*args, **kwargs)

    def __str__(self):
        return "%s" % (self.id,)


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
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                             related_name="posts", null=True, blank=True,
                             on_delete=models.CASCADE)  # NOQA

    def __str__(self):
        return "%s" % (self.id,)


class PostFiles(models.Model):
    post = models.ForeignKey(Post,
                             related_name="postfiles", on_delete=models.CASCADE)  # NOQA
    file = models.FileField(upload_to=get_upload_path_post_file)

    class Meta:
        verbose_name_plural = "PostFiles"

    def __str__(self):
        return "%s" % (self.id,)


@receiver(pre_save, sender=University)
@receiver(pre_save, sender=Collage)
@receiver(pre_save, sender=Course)
@receiver(pre_save, sender=Branch)
@receiver(pre_save, sender=Subject)
def pre_save_level(sender, instance=None, *args, **kwargs):
    slug = slugify(instance.name)
    instance.slug = slug