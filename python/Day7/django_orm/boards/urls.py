from django.contrib import admin
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index ),
    path('admin/', admin.site.urls),
    path('subway/',views.subway),
    path('subway_result/', views.subway_result),
    path('subway_result/<int:key>/', views.subway_result_key),
]
