from django.urls import path, include
from . import views

urlpatterns = [
     path('', views.index),
     path('new/', views.new),
     path('create/', views.create),
     path('detail/<int:pk>/', views.detail),
     path('modify/<int:pk>/', views.modify),
     path('update/<int:pk>/', views.update),
     path('delete/<int:pk>/', views.delete),
]
