from django.shortcuts import render, redirect
from .models import Question,Choice

def index(request):
    questions = Question.objects.all()
    context = {
        'questions': questions
    }
    return render(request, 'boards/index.html', context)

def new(request):
    # REST 하게 바꿨을때 폼이 새로 생성되는 부분.
    if request.method == "POST":
        question = Question(question=request.POST.get('question'))
        question.save()
        return redirect('boards:index')
    else:
    # 폼 html 을 불러오는 부분.
        return render(request, 'boards/new.html')

def detail(request,question_id):
    question = Question.objects.get(id=question_id)
    choice = question.choice_set.all()
    context = {
        'question':question,
        'choice':choice
    }
    return render(request, 'boards/detail.html', context)

def delete(request,question_id):
    question = Question.objects.get(id=question_id)
    if request.method =="POST":
        question.delete()
        return redirect('boards:index')
    else:
        return redirect('boards:detail',question_id)

def choice(request,question_id):
    question = Question.objects.get(id=question_id)
    survey = request.POST.get('survey')

    choice = Choice()
    choice.survey = survey
    choice.question = question
    choice.save()

    return redirect('boards:detail', question_id)

def choice_edit(request,question_id,choice_id):
    choice = Choice.objects.get(id=choice_id)
    if request.method == "POST":
        survey = request.POST.get('survey')
        choice.survey = survey
        choice.save()
        return redirect('boards:detail',question_id)
    else:
        context = {
            'choice':choice
        }
        return render(request, 'boards/choice_edit.html', context)

def choice_vote(request,question_id,choice_id):
    choice = Choice.objects.get(id=choice_id)
    
    if request.method =="POST":
        choice.votes += 1
        choice.save()
        return redirect('boards:detail',question_id)
    else:
      return redirect('boards:detail',question_id)  


    
        