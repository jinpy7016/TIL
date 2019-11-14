from django.shortcuts import render
from boards.models import Subway

def index(request):
    return render(request,"boards/index.html")

def subway(request):
    return render(request, "boards/subway.html")

def subway_result(request):
    name = request.POST.get("name")
    date = request.POST.get("date")
    sandwitch = request.POST.get("sandwitch")
    size = request.POST.get("size")
    bread = request.POST.get("bread")
    # 여러 체크리스트를 받아올땐 getlist
    source = request.POST.getlist("source") 

    mymenu = Subway.objects.create(name=name, date=date, sandwitch=sandwitch, size=size, bread=bread, source=source)

    menu_list = Subway.objects.all()

    context = {
        'menu_list' : menu_list
    }
    return render(request, 'boards/subway_result.html', context)

def subway_result_key(request,key):

    menu_list = Subway.objects.filter(id=key)
    print(type(menu_list))
    context = {
        'menu_list' : menu_list
    }
    return render(request, 'boards/subway_result.html', context)