from django.contrib import admin
from xpauth.models import XpapersUser
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

admin.site.site_header = 'Xpapers Admin'


class XpapersUserAdmin(BaseUserAdmin):

    list_display = ('username', 'email', 'created', 'last_login', )
    list_filter = ('is_admin',)
    fieldsets = (
        (None, {'fields': ('username', 'email', 'password')}),
        ('Personal information', {'fields': ('first_name', 'last_name', 'profile_image')}),  # NOQA
        ('Education information', {'fields': ('university', 'collage', 'course', 'branch')}),  # NOQA
        ('Permissions', {'fields': ('is_active', 'is_admin', 'is_staff')}),
        ('Verification', {'fields': ('is_email_varified', 'is_username_varified')}),
        ('Dates', {'fields': ('last_login',)}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'email', 'password1', 'password2')}
         ),
    )
    search_fields = ('username', 'email')
    ordering = ('email',)
    filter_horizontal = ()


admin.site.register(XpapersUser, XpapersUserAdmin)
