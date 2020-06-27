from django.shortcuts import render
from django.views import View


class DashboardView(View):
    def get(self, request, path=None):
        return render(request, 'dashboard/dashboard.html')


class UploadPaperView(View):
    def get(self, request, path=None):
        return render(request, 'dashboard/upload-paper.html')