# Generated by Django 2.2.7 on 2019-11-27 07:09

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('manytomany', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Sales',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('판매시간', models.DateTimeField()),
                ('alcohol', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='manytomany.Alcohol')),
                ('person', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='manytomany.Person')),
            ],
        ),
    ]
