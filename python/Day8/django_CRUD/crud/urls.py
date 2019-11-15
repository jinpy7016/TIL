from django.urls import path
from . import views

urlpatterns = [
    # crud/
    path('', views.index), 
    # crud/new/
    path('new/', views.new), 
    # crud/create/ = form 데이터를 받아서 db 저장함.
    path('create/', views.create), 
    # crud/pk/article/ detail page
    path('<int:pk>/article/', views.detail), 
    # crud/pk/update 수정페이지
    path('<int:pk>/update/', views.update),
    # crud/pk/revise/ 최종 업데이트
    path('<int:pk>/revise/', views.revise),
    # crud/pk/delete/ 삭제하기
    path('<int:pk>/delete/', views.delete),
]
