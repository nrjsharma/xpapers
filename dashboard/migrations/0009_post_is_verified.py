# Generated by Django 2.2.4 on 2021-07-06 20:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0008_auto_20210706_1133'),
    ]

    operations = [
        migrations.AddField(
            model_name='post',
            name='is_verified',
            field=models.BooleanField(default=False),
        ),
    ]