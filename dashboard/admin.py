from django.contrib import admin
from dashboard.models import (University, Collage,
                              Course, Subject, Branch,
                              Post, PostFiles, SiteMapURL)


class UniversityAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'acronym')
    search_fields = ('id', 'name')


class CollageAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'acronym')
    search_fields = ('id', 'name', 'acronym')


class CourseAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'acronym')
    raw_id_fields = ('universities',)
    search_fields = ('id', 'name', 'acronym')


class BranchAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'acronym')
    raw_id_fields = ('universities', 'courses')
    search_fields = ('id', 'name', 'acronym')


class SubjectAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'acronym')
    raw_id_fields = ('universities', 'courses', 'branches')
    search_fields = ('id', 'name', 'acronym')


class PostAdmin(admin.ModelAdmin):
    def save_model(self, request, obj, form, change):
        if request.user.is_authenticated:
            obj.user = request.user
        super().save_model(request, obj, form, change)

    list_display = ('id', 'created')
    search_fields = ('id',)


class PostFilesAdmin(admin.ModelAdmin):
    list_display = ('id', 'post')


class SiteMapURLAdmin(admin.ModelAdmin):
        list_display = ('id', 'url', 'is_active')


admin.site.register(University, UniversityAdmin)
admin.site.register(Collage, CollageAdmin)
admin.site.register(Course, CourseAdmin)
admin.site.register(Branch, BranchAdmin)
admin.site.register(Subject, SubjectAdmin)
admin.site.register(Post, PostAdmin)
admin.site.register(PostFiles, PostFilesAdmin)
admin.site.register(SiteMapURL, SiteMapURLAdmin)
