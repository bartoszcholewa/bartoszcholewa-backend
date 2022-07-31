from django import template
from django.conf import settings

register = template.Library()


@register.simple_tag
def git_commit():
    return settings.GIT_COMMIT


@register.simple_tag
def run_number():
    return settings.RUN_NUMBER
