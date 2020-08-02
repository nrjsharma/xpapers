import os

AWS_ACCESS_KEY_ID = os.getenv('aws_access_key')
AWS_SECRET_ACCESS_KEY = os.getenv('aws_secret_key')
AWS_STORAGE_BUCKET_NAME = os.getenv('aws_bucket_name')
AWS_S3_FILE_OVERWRITE = False
AWS_DEFAULT_ACL = None
AWS_S3_REGION_NAME = 'ap-south-1'
AWS_S3_SIGNATURE_VERSION = 's3v4'

DEFAULT_FILE_STORAGE = 'storages.backends.s3boto3.S3Boto3Storage'
# STATICFILES_STORAGE = 'storages.backends.s3boto3.S3Boto3Storage'
