from django.contrib import admin
from dashboard.models import (University, Collage,
                              Course, Subject, Branch,
                              Post, PostFiles)


class UniversityAdmin(admin.ModelAdmin):
    list_display = ('id', 'name')


class CollageAdmin(admin.ModelAdmin):
    list_display = ('id', 'name')


class CourseAdmin(admin.ModelAdmin):
    list_display = ('id', 'name')
    raw_id_fields = ('universities',)


class BranchAdmin(admin.ModelAdmin):
    list_display = ('id', 'name')
    raw_id_fields = ('universities', 'courses')


class SubjectAdmin(admin.ModelAdmin):
    list_display = ('id', 'name')
    raw_id_fields = ('universities', 'courses', 'branches')


class PostAdmin(admin.ModelAdmin):
    def save_model(self, request, obj, form, change):
        if request.user.is_authenticated:
            obj.user = request.user
        super().save_model(request, obj, form, change)

    list_display = ('id', 'created')


class PostFilesAdmin(admin.ModelAdmin):
    list_display = ('id', 'post')


admin.site.register(University, UniversityAdmin)
admin.site.register(Collage, CollageAdmin)
admin.site.register(Course, CourseAdmin)
admin.site.register(Branch, BranchAdmin)
admin.site.register(Subject, SubjectAdmin)
admin.site.register(Post, PostAdmin)
admin.site.register(PostFiles, PostFilesAdmin)
