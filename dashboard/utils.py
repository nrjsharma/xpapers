def get_upload_path_uni(instance, filename):
    return 'university/%s/thumbnail/%s' % (instance.name, filename)


def get_upload_path_collage(instance, filename):
    return 'collage/%s/thumbnail/%s' % (instance.name, filename)


def get_upload_path_post_file(instance, filename):
    return 'post_files/%s/%s' % (instance.post.id, filename)
