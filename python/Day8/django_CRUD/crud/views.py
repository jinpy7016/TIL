from django.shortcuts import render,redirect
from .models import Article

# Create your views here.
def index(request):
    # 1번째 파이썬에서 정렬
    #articles = Article.objects.all()[::-1]

    # 2번째 불러올때 정렬시키는 방법 order_by 쿼리셋으로 불러올때만 get일때는 안됨
    articles = Article.objects.order_by('-id')

    context = {
        "articles" : articles
    }
    return render(request,'crud/index.html', context)

def new(request):
    return render(request, 'crud/new.html')

#Form에서 데이터를 받아 DB에 저장하고 글 작성 성공 메세지를 보여줌
def create(request):
    title = request.POST.get('title')
    content = request.POST.get('content')

    #DB에 저장.
    article = Article()
    article.title = title
    article.content = content
    article.save()
    
    return render(request, 'crud/created.html')

def detail(request, pk):
    article = Article.objects.get(pk=pk) # pk=pk < id__exact=pk
    
    context = {
        "article" : article
    }
    return render(request, 'crud/detail.html', context)

def update(request,pk):
    article = Article.objects.get(pk=pk)

    context = {
        'article' : article
    }
    return render(request, 'crud/update.html', context)

def revise(request,pk):
    article = Article.objects.get(pk=pk)
    
    title = request.POST.get('title')
    content = request.POST.get('content')

    article.title = title
    article.content = content
    
    article.save()
    
    return redirect(f'/crud/{article.id}/article/')

def delete(request,pk):
    article = Article.objects.get(pk=pk)

    article.delete()
    return redirect('/crud/')
