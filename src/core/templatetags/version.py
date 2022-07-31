import os
import time

from django import template

register = template.Library()


@register.simple_tag
def version_date():
    return time.strftime('%m/%d/%Y', time.gmtime(os.path.getmtime('../.git')))
