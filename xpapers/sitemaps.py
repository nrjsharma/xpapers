from django.contrib.sitemaps import Sitemap
from dashboard.models import (University, SiteMapURL)
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
        return ['dashboard:dashboard',
                'dashboard:about',
                'dashboard:contact',
                'dashboard:privacy-policy',
                'dashboard:disclaimer',
                ]

    def location(self, obj):
        return reverse(obj)


class ManualSitemapUrls(Sitemap):
    changefreq = "monthly"
    priority = 0.5
    protocol = "https"
    
    def items(self):
        return SiteMapURL.objects.filter(is_active=True)
