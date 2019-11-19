from django.urls import path
from . import views

app_name = "boards"
urlpatterns = [
    path('', views.index, name="index"),
    path('new/', views.new, name="new"),
    path('<int:question_id>/', views.detail, name="detail"),
    path('<int:question_id>/delete/', views.delete, name="delete"),
    path('<int:question_id>/choice/', views.choice, name="choice" ),
    path('<int:question_id>/choice/<int:choice_id>/edit/', views.choice_edit, name="choice_edit"),
    path('<int:question_id>/vote/<int:choice_id>/', views.choice_vote, name="choice_vote"),
]