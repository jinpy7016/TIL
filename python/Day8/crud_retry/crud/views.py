from django.shortcuts import render, redirect
from .models import Article

# Create your views here.
def index(request):
    articles = Article.objects.all()
    context = {
        "articles" : articles
    }
    return render(request,'crud/index.html', context)

def new(request):
    return render(request,'crud/new.html')

def create(request):
    title = request.POST.get('title')
    content = request.POST.get('content')

    article = Article()
    article.title = title
    article.content = content
    article.save()

    return redirect('/crud/')

def detail(request,pk):
    article = Article.objects.get(pk=pk)
    context = {
        'article' : article
    }
    return render(request, 'crud/detail.html', context)

def modify(request,pk):
    article = Article.objects.get(pk=pk)
    context = {
        'article' : article
    }
    return render(request, 'crud/modify.html', context)

def update(request,pk):
    article = Article.objects.get(pk=pk)
    
    title = request.POST.get('title')
    content = request.POST.get('content')

    article.title = title
    article.content = content

    article.save()
    
    return redirect('/crud/')

def delete(request,pk):
    article = Article.objects.get(pk=pk)
    article.delete()

    return redirect('/crud/')
