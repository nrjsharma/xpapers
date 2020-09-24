from django.contrib.sitemaps import Sitemap
from dashboard.models import University
from django.shortcuts import reverse


class UniversitySitemap(Sitemap):
    changefreq = "monthly"
    priority = 0.5
    protocol = "https"

    def items(self):
        return University.objects.all()


class StaticHomeSitemap(Sitemap):
    changefreq = "monthly"
    priority = 0.5
    protocol = "https"

    def items(self):
        return ['dashboard:dashboard']

    def location(self, obj):
        return reverse(obj)