from django.db import models

class Movie(models.Model):
    title = models.CharField(max_length=200)
    title_en = models.CharField(max_length=200)
    audience = models.CharField(max_length=200)
    open_date = models.DateTimeField()
    genre = models.CharField(max_length=200)
    watch_grade = models.CharField(max_length=200)
    score = models.FloatField()
    poster_url = models.TextField()
    description = models.TextField()
    
    def __str__(self):
        return f'{self.id} > {self.title}'
