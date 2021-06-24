"""xpapers URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.contrib.sitemaps.views import sitemap
from django.conf import settings
from django.conf.urls import include
from django.conf.urls.static import static
from django.urls import path
from xpapers.sitemaps import (UniversitySitemap, StaticHomeSitemap,
                              ManualSitemapUrls)


sitemaps = {
    'static': StaticHomeSitemap,
    'university': UniversitySitemap,
    'manual': ManualSitemapUrls
}

handler404 = 'dashboard.views.handler404'
handler500 = 'dashboard.views.handler500'

urlpatterns = [
    path('superadmin/', admin.site.urls),
    path('api/v1/', include('api.urls'), name="api"),
    path('auth/', include('xpauth.urls'), name="auth"),
    path('accounts/', include('allauth.urls')),
    path('sitemap.xml', sitemap, {'sitemaps': sitemaps},
         name="django.contrib.sitemaps.views.sitemap"),  # NOQA
    path('sitemap.xml/', sitemap, {'sitemaps': sitemaps},
         name="django.contrib.sitemaps.views.sitemap"),  # NOQA
    path('', include('dashboard.urls'), name='dashboard'),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
