from django.shortcuts import render
from django.views import View
from dashboard.models import University


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