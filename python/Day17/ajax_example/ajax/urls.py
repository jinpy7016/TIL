from django.urls import path
from . import views

app_name='ajax'

urlpatterns =[
    path('', views.index, name="index"),
    path('search_wiki/', views.ajax, name="ajax"),

]