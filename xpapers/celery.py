from __future__ import absolute_import, unicode_literals
import os
from celery import Celery
from xpapers.utils import set_env

# set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', set_env())

app = Celery('xpapers')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()


@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))