from django.db import models

# Create your models here.
class Board(models.Model):
    title = models.CharField(max_length=10)
    content = models.TextField() #db에서 글자수 제한이 안된다.
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.id} : {self.title}'

class Subway(models.Model):
    name = models.CharField(max_length=30)
    date = models.DateTimeField()
    sandwitch =  models.CharField(max_length=30)
    size = models.IntegerField()
    bread = models.CharField(max_length=30)
    source = models.CharField(max_length=30)
    
    def __str__(self):
        return f'{self.id} : {self.name}'
    # def __str__(self):
    #     return f'{self.id} : {self.title}'