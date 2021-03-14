from django.shortcuts import render
from django.views import View
from django.shortcuts import get_object_or_404
from dashboard.models import (University, Collage,
                              Course, Branch)
from xpapers.utils import utils_commaSeperatedString


class DashboardView(View):
    template_name = 'dashboard/dashboard.html'

    def get(self, request, path=None):
        universities_name = University.objects.all().values_list('name', flat=True)
        description = "Get previous year question papers of %s" % utils_commaSeperatedString(universities_name)
        keywords = "%s" % utils_commaSeperatedString(universities_name, "previous year question papers")
        context = {
            "keywords": keywords,
            "description": description
        }
        return render(request, self.template_name, context)


class UploadPaperView(View):
    template_name = 'dashboard/upload-paper.html'

    def get(self, request, path=None):
        return render(request, self.template_name)


class SearchDataView(View):
    template_name = 'dashboard/show.html'

    def get_collage(self):
        return Collage.objects.all()

    def get_course(self):
        return Course.objects.all()

    def get_branch(self):
        return Branch.objects.all()

    def get(self, request, path=None):
        query_university = request.GET.get('uni', None)
        query_collage = request.GET.get('col', None)
        query_course = request.GET.get('cou', None)
        query_branch = request.GET.get('bra', None)
        university = get_object_or_404(University, slug=query_university)
        context = {
            'university': university,
        }

        if query_university and not query_collage:
            context['data'] = self.get_collage()
        elif query_university and query_collage and not query_course:
            context['data'] = self.get_course()
        elif query_university and query_collage and query_course and not query_branch:
            context['data'] = self.get_branch()

        return render(request, self.template_name)


class AboutView(View):
    template_name = 'dashboard/about-us.html'

    def get(self, request, path=None):
        return render(request, self.template_name)


class ContactView(View):
    template_name = 'dashboard/contact-us.html'

    def get(self, request, path=None):
        return render(request, self.template_name)


class PrivacyPolicyView(View):
    template_name = 'dashboard/privacy-policy.html'

    def get(self, request, path=None):
        return render(request, self.template_name)


class DisclaimerView(View):
    template_name = 'dashboard/disclaimer.html'

    def get(self, request, path=None):
        return render(request, self.template_name)
