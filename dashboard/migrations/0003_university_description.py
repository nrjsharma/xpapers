# Generated by Django 2.2.4 on 2020-10-20 02:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0002_auto_20200924_2354'),
    ]

    operations = [
        migrations.AddField(
            model_name='university',
            name='description',
            field=models.TextField(blank=True, null=True),
        ),
    ]
