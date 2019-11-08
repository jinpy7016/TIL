from flask import Flask,render_template,request
import random
import requests
from pprint import pprint

app = Flask(__name__)

@app.route('/')
def hello():
    name = "World!!"
    return f'Hello {name}!'


#  @app.route('/mulcam')
#  def mulcam():
#     return 'Hello mulcamp'

@app.route('/greeting/<string:name>')
def greeting(name):
    return f'{name}님 안녕하세요'

@app.route('/lunch/<int:num>')
def lunch(num):
    menu = ["짜장면", "짬뽕", "라면", "스파게티", "스테이크", "삼겹살"]
    order = random.sample(menu, num)
    return render_template('menu.html', menu=order)

@app.route('/fake_naver')
def fake_naver():
    return render_template('fake_naver.html')

@app.route('/fake_google')
def fake_google():
    return render_template('fake_google.html')

@app.route('/send')
def send():
    return render_template('send.html')

@app.route('/recieve')
def recieve():
    name = request.args.get('name')
    message = request.args.get('message')
    return render_template('recieve.html', name=name, msg=message)

########################## 인디언 이름짖기 ########################### 
@app.route('/indian_send')
def indian_send():
    return render_template('indian_send.html')   

@app.route('/indian_recieve')
def indian_recieve():
    date = request.args.get('date')
    year = date[3:4]
    month = date[5:7]
    day = date[8:10]
    name = ""
    year_arr = ['시끄러운, 말 많은', '푸른', '어두운', '조용한', '웅크린', '백색', '지혜로운', '용감한', '날카로운', '욕심 많은']
    month_arr = ['늑대','태양','양','매','황소','불꽃','나무','달빛','말','돼지','하늘','바람']
    day_arr  = ["의 환생","의 죽음","아래에서","를(을) 보라","이(가) 노래하다","그림자","의 일격","에게 쫒기는 남자","의 행진 ","의 왕","의 유령","을 죽인자","는(은) 맨날 잠잔다","처럼","의 고향","의 전사","은(는) 나의친구","의 노래","의 정령","의 파수꾼","의 악마","와(과) 같은 사나이","를(을) 쓰러트린자","의 혼 ","은(는) 말이 없다"]
    name = year_arr[int(year)-1] + month_arr[int(month)-1] + day_arr[int(day)-1]
   
    return render_template('indian_recieve.html', date=date,year=year,month=month,day=day,name=name)
#####################################################################

#########lotto##########
@app.route('/lotto_get')
def lotto_get():
    return render_template('lotto_get.html')

@app.route('/lotto_num')
def lotto_num():
    num = request.args.get("num")
    url = f"https://dhlottery.co.kr/common.do?method=getLottoNumber&drwNo={num}"
    res = requests.get(url).json()

    # List comprehension
    # [ 받는변수 for 받는변수 in 범위로된data]
    wnum = [ res[f'drwtNo{i}'] for i in range(1,7)]
    lotto = random.sample(range(1,47),6)
    match = list(set(wnum) & set(lotto))

    count = len(match)
    result=""
    count2 = 0
    while count<6 :
        lotto = random.sample(range(1,47),6)
        match = list(set(wnum) & set(lotto))
        count = len(match)
        count2 += 1

    if count == 0 : 
        result='꽝'
    elif count == 1 :
        result='한개'
    elif count == 2 :
        result='5등!!!'
    elif count == 3 : 
        result='4등!!!'
    elif count == 4 :
        result='3등!!!!'
    elif count == 5 :
        result='2등!!!'
    elif count == 6 : 
        result='1등!!!!!'
    
    lotto.sort()

    return render_template('lotto_result.html',num=num,wnum=wnum,lotto=lotto,result=result,count2=count2)
#########lotto##########

if __name__=="__main__":
    app.run(debug=True, port=8000)