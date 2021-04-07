from django import template
from django.utils.safestring import mark_safe

register = template.Library()


@register.filter(name='split_by_comma')
def split_by_comma(context):
    data = context.split(',')
    return data


@register.filter(name='title_replace_with_space')
def title_replace_with_space(context):
    data = context.replace(">", "")
    return data


@register.filter(name='convert_to_html')
def convert_to_html(context):
    return mark_safe(context)
