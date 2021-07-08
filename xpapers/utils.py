import os
import codecs
import random
import string
from django.utils.crypto import get_random_string


def set_env():
    return "settings.{}".format(
        os.getenv('env') if os.getenv('env') else "dev"
    )


def utils_get_random_string():
    return get_random_string(10, string.ascii_letters)


def utils_get_random_number(stringify=False):
    if stringify:
        return str(random.randint(0, 99))
    return random.randint(0, 99)


def utils_short_hash():
    return codecs.encode(os.urandom(5), 'hex').decode()


def utils_long_hash():
    return codecs.encode(os.urandom(10), 'hex').decode()


def utils_commaSeperatedString(lists, addmessage=None, capslock="lower"):
    """
    This function is used to create keyword and
    description of page
    """
    return_string = ""
    for obj in lists:
        if return_string:
            if addmessage:
                return_string += ", %s %s" % (obj, addmessage)
            else:
                return_string += ", " + obj
        else:
            if addmessage:
                return_string = "%s %s" % (obj, addmessage)
            else:
                return_string = obj.title()

    if capslock == "title":
        return_string = return_string.title()
    elif capslock == "upper":
        return_string = return_string.upper()
    else:
        return_string = return_string.lower()

    return return_string if return_string else ""