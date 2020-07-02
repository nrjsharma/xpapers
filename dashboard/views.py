from django.shortcuts import render
from django.views import View
from django.shortcuts import get_object_or_404
from dashboard.models import (University, Collage,
                              Course, Branch)


class DashboardView(View):
    template_name = 'dashboard/dashboard.html'

    def get(self, request, path=None):
        context = {
            'universities': University.objects.all()
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