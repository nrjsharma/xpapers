# Generated by Django 2.2.4 on 2020-10-20 21:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0003_university_description'),
    ]

    operations = [
        migrations.AddField(
            model_name='university',
            name='url',
            field=models.URLField(blank=True, max_length=1000, null=True),
        ),
    ]