#! /usr/bin/python3
# -*- coding: utf-8 -*-

from settings.base import *  # NOQA
from settings.storages.aws import *  # NOQA
from settings.sentry import *  # NOQA

STATIC_ROOT = os.path.join(BASE_DIR, 'static')  # NOQA

WSGI_APPLICATION = 'xpapers.wsgi.application'

DEBUG = False

DATABASES = {
    'default': {
        'ENGINE': os.getenv('db_engine'),  # NOQA
        'NAME': os.getenv('db_name'),  # NOQA
        'USER': os.getenv('db_user'),  # NOQA
        'PASSWORD': os.getenv('db_password'),  # NOQA
        'HOST': os.getenv('db_host'),  # NOQA
        'PORT': os.getenv('db_port'),  # NOQA
    }
}