"""
Django settings for xpapers project.

Generated by 'django-admin startproject' using Django 2.2.4.

For more information on this file, see
https://docs.djangoproject.com/en/2.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/2.2/ref/settings/
"""

import os
from dotenv import load_dotenv

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# Setting up environment variables.
dotenv_path = os.path.join(BASE_DIR, '.env')
load_dotenv(dotenv_path)

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.getenv('key')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

BASE_URL = 'https://xpapers.in'

BASE_ENV = os.getenv('env') if os.getenv('env') else "dev"

ALLOWED_HOSTS = ['127.0.0.1', 'localhost',
                 '10.0.0.10', 'xpapers.in',
                 '3.20.174.87', '10.0.0.6']


# Application definition

DJANGO_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
    'django.contrib.sitemaps',
    'django_extensions'
]

REST_APPS = [
    'rest_framework',
    'rest_framework.authtoken',
]

XPAPERS_APPS = [
    'xpapers',
    'dashboard',
    'api',
    'xpauth'
]

OTHER_APPS = [
    'storages',
    'allauth',
    'allauth.account',
    'allauth.socialaccount',
    'allauth.socialaccount.providers.google',
]

INSTALLED_APPS = DJANGO_APPS + REST_APPS + XPAPERS_APPS + OTHER_APPS

SITE_ID = 1

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'xpapers.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'xpapers.wsgi.application'


AUTHENTICATION_BACKENDS = [
    'django.contrib.auth.backends.ModelBackend',
    'allauth.account.auth_backends.AuthenticationBackend',
]

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',  # NOQA
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',  # NOQA
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',  # NOQA
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',  # NOQA
    },
]

###########################
# AUTH
###########################

# auth user model override
AUTH_USER_MODEL = 'xpauth.XpapersUser'


###########################
# SOCIAL ACCOUNT
###########################

SOCIALACCOUNT_PROVIDERS = {
    'google': {
        'SCOPE': [
            'profile',
            'email',
        ],
        'APP': {
            'client_id': os.getenv('gcp_client_id'),
            'secret': os.getenv('gcp_secret_id'),
            'key': ''
        }
    }
}

SOCIALACCOUNT_ADAPTER = 'xpauth.adapter.SocialAccountAdapter'

ACCOUNT_USER_MODEL_USERNAME_FIELD = "username"
ACCOUNT_EMAIL_REQUIRED = True
ACCOUNT_USERNAME_REQUIRED = True
ACCOUNT_AUTHENTICATION_METHOD = 'email'
LOGIN_REDIRECT_URL = '/'

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/2.2/howto/static-files/

STATIC_URL = '/static/'

# For file uploading
MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')


# celery
CELERY_BROKER_URL = 'redis://localhost:6379'
CELERY_RESULT_BACKEND = 'redis://localhost:6379'
CELERY_ACCEPT_CONTENT = ['application/json']
CELERY_RESULT_SERIALIZER = 'json'
CELERY_TASK_SERIALIZER = 'json'
