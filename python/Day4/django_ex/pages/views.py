from django.shortcuts import render
from django.http import HttpResponse
import random
from faker import Faker
from datetime import datetime

# Create your views here.
def index(request):
    return render(request, 'index.html')

def age(request, age):
    context = {
        'age' : age
    }
    return render(request, 'age.html', context)

def operator(request, operator, num1, num2):
    if operator == 'plus' :
        result = num1+num2
    elif operator == 'minus' :
        result = num1-num2
    elif operator == 'multi' :
        result = num1*num2
    elif operator == 'div' :
        result = num1/num2
    else :
        result = 'operator miss'
    context = {
        'result' : result
    }
    return render(request, 'operator.html', context)

def profile(request, name, age):
    
    year_list = ['시끄러운, 말 많은', '푸른', '어두운', '조용한', '웅크린', '백색', '지혜로운', '용감한', '날카로운', '욕심 많은']
    month_list = ['늑대','태양','양','매','황소','불꽃','나무','달빛','말','돼지','하늘','바람']
    day_list = ["의 환생","의 죽음","아래에서","를(을) 보라","이(가) 노래하다","그림자","의 일격","에게 쫒기는 남자","의 행진 ","의 왕","의 유령","을 죽인자","는(은) 맨날 잠잔다","처럼","의 고향","의 전사","은(는) 나의친구","의 노래","의 정령","의 파수꾼","의 악마","와(과) 같은 사나이","를(을) 쓰러트린자","의 혼 ","은(는) 말이 없다"]
    indian_name = random.choice(year_list)+ ' ' + random.choice(month_list) + random.choice(day_list)

    RandomNum = sorted(random.sample(range(1,47),6))
    context = {
        'name' : name,
        'age' : age,
        'lottoNum' : RandomNum,
        'indian' : indian_name
    }
    return render(request, 'profile.html', context)

def job(request,name):
    
    fake = Faker('ko_KR')
    job = fake.job()
    address = fake.address()
    context = {
        'name' : name,
        'job' : job,
        'address' : address
    }
    return render(request, 'job.html', context)

def image(request):
    num = random.choice(range(1,100))
    url = f"https://picsum.photos/id/{num}/200/300"
    context = {
        'url' : url
    }
    return render(request, 'image.html', context)

def dtl(request):
    foods = ["짜장면", "탕수육", "짬뽕", "양장피", "군만두", "고추잡채","볶음밥"]
    my_sentence = 'life is short, you need Python'
    messages = ['apple','banana', 'cucumber', 'mango']
    datetimenow = datetime.now() #현재시간
    empty_list = []
    context = {
        'foods' : foods,
        'my_sentence' : my_sentence,
        'messages' : messages,
        'timenow' : datetimenow,
        'empty_list' : empty_list
    }
    return render(request, 'dtl.html', context)

def christmas(request):
    today = datetime.now()
    if today.month == 12 and today.date ==25:
        res = True
    else:
        res = False
    christmas = datetime(2019,12,25)
    d_day = (christmas - today).days
    context = {
        'result' : res,
        'd_day' : d_day
    }
    return render(request,'christmas.html', context)
