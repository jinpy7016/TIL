from django.urls import path
from . import views

app_name='ajax'

urlpatterns =[
    path('', views.index, name="index"),
    path('search/', views.ajax, name="ajax"),

]