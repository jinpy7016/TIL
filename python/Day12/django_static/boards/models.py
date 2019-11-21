from django.db import models
from imagekit.models import ProcessedImageField,ImageSpecField
from imagekit.processors import ResizeToFill,Thumbnail

#https://github.com/matthewwithanm/django-imagekit

# 저장 경로 동적 저장 객체 저장 전에 pk를 불러오기 때문에 pk 불러오지 못함
def board_img_path(instance,filename):
    return f'boards/{instance.pk}번글/{filename}'

#     #ResizeToFill ver.1
# class Board(models.Model):
#     title = models.CharField(max_length=20)
#     content = models.TextField()
#     updated = models.DateTimeField(auto_now=True)
#     created = models.DateTimeField(auto_now_add=True)
#     image = ProcessedImageField(
#         upload_to = "boards/images_rtf",#"저장경로"
#         processors = [ResizeToFill(600,500)],#[프로세서]
#         format = "JPEG",#"저장되는이미지포맷"
#         options = {
#             "quality" : 85 #퀄리티값
#         }
#     )

# #썸네일 ver.1 썸네일만 저장    
# class Board(models.Model):
#     title = models.CharField(max_length=20)
#     content = models.TextField()
#     updated = models.DateTimeField(auto_now=True)
#     created = models.DateTimeField(auto_now_add=True)
#     image = ImageSpecField( 
#         source = 'boards/thumbnail',
#         processors = [Thumbnail(100,100)],
#         format = "JPEG",
#         options = {
#             'quality':90
#         }
#     )


# 썸네일 ver.2 원본 저장, 썸네일은 캐쉬형태로 저장


class Board(models.Model):
    title = models.CharField(max_length=20)
    content = models.TextField()
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)
    image = models.ImageField(blank=True, upload_to=board_img_path) #원본
    image_thumb = ImageSpecField( 
        source='image', #원본의 컬럼명
        processors = [Thumbnail(250,350)],
        format = "JPEG",
        options = {
            'quality':90
        }
    )




    # def __str__(self):
    #     return self.title