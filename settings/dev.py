import os
from settings.base import *  # NOQA
from settings.storages.aws import *  # NOQA

STATICFILES_DIRS = os.path.join(BASE_DIR, 'static/'),  # NOQA

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'xpapers_dev_neeraj',
        'USER': 'neeraj',
        'PASSWORD': 'postgres',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
