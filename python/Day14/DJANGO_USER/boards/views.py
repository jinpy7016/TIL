from django.shortcuts import render, redirect, get_object_or_404
from .forms import BoardForm
from .models import Board
from django.contrib.auth.decorators import login_required

def index(request):
    boards = Board.objects.all()
    context={
        'boards':boards
    }
    return render(request,'boards/index.html',context)

@login_required #로그인 확인.2
def new(request):

    #login 확인.1
    # if request.user.is_authenticated:
    #     return redirect('boards:index')
    if request.method == "POST":
        form = BoardForm(request.POST) #data가 들어있는 form
        if form.is_valid(): #form 유효성 검사
            board = form.save(commit=False)
            board.user = request.user
            board.save()
            return redirect('boards:index')

    else:
        form = BoardForm()
        context = {
            'form':form
        }
        return render(request, 'boards/new.html', context)

def detail(request,b_id):
    board = get_object_or_404(Board, id=b_id) #있으면 가져오고 없으면 404에러 띄움
    context = {
        'board':board
    }
    return render(request, 'boards/detail.html', context)

def edit(request,b_id):
    board = get_object_or_404(Board, id=b_id)

    if request.user != board.user:
        return redirect('boards:index')

    if request.user == board.user:
        if request.method == "POST":
            form = BoardForm(request.POST, instance=board)
            if form.is_valid():
                board = form.save()
                return redirect('boards:detail', board.id)
        else:
            form = BoardForm(instance=board)
        context= {
            'form': form
        }
        return render(request, 'boards/edit.html', context)
        
def delete(request,b_id):
    board = get_object_or_404(Board, id=b_id)
    
    if request.user != board.user:
        return redirect('boards:index')

    if(request.method=="POST"):
        board.delete()
        return redirect('boards:index')
    else:
        return redirect('boards:detail',board.id)