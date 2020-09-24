from django import template

register = template.Library()

@register.filter(name='split_by_comma')
def split_by_comma(context):
    data = context.split(',')
    return data