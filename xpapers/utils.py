import os
import codecs
import string
from django.utils.crypto import get_random_string


def set_env():
    return "settings.{}".format(
        os.getenv('env') if os.getenv('env') else "dev"
    )


def utils_get_random_string():
    return get_random_string(10, string.ascii_letters)


def utils_short_hash():
    return codecs.encode(os.urandom(5), 'hex').decode()


def utils_long_hash():
    return codecs.encode(os.urandom(10), 'hex').decode()
