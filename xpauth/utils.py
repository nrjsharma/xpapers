def get_upload_path_user(instance, filename):
    return 'user/%s/profile/%s' % (instance.id, filename)
