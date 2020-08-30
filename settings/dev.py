import os
from settings.base import *  # NOQA

STATICFILES_DIRS = os.path.join(BASE_DIR, 'static/'),  # NOQA

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'xpapers_dev',
        'USER': 'postgres',
        'PASSWORD': 'postgres',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
