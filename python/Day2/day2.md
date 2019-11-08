191107 day2

python 3.7.5 설치

flask 설치

# python

만약 f-string을 formatting

```python
f'tuple: {tuple}'
# "tuple: ('Hi, I am', 'song', 123)"
```

 https://wikidocs.net/book/1 

```python
city = {
    '서울': [-6, -10, 5],
    '대전': [-3, -5, 2],
    '광주': [0, -2, 10],
    '부산': [2, -2, 9]
}

#도시별 최근 3일의 온도 평균은?


for name, temp in city.items():
    avg_temp = sum(temp)/len(temp)
    print(f'{name} : 평균기온은 {avg_temp} 입니다.')
```



```python
$ python a.py
서울 : 평균기온은 -3.6666666666666665 입니다.
대전 : 평균기온은 -2.0 입니다.
광주 : 평균기온은 2.6666666666666665 입니다.
부산 : 평균기온은 3.0 입니다.
```



```python
#3-2위에서 서울은 영상 2도였던 적이 있나요??
# A if 조건문 else B : 조건문이 참이면 A 거짓이면 B
print("있어요") if 2 in city["서울"] else print("없어요") 



$ python a.py
없어요
```



## flask 플라스크

독립적인 환경 구축 버전충돌 방지

$ pip install virtualenv

$ virtualenv venv 가상환경 구축

$ source venv/Scripts/activate 가상환경 진입
(venv) 

$ env Flask_APP=hello.py flask run



app.py

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    name = "World!!"
    return f'Hello {name}!'


if _name_="_main_":
    app.run(debug=True, port=8000)
    

python app.py

```





```
$ env Flask_APP=hello.py flask run
 * Serving Flask app "hello.py"
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
127.0.0.1 - - [07/Nov/2019 13:14:59] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [07/Nov/2019 13:14:59] "GET /favicon.ico HTTP/1.1" 404 -
```

http://127.0.0.1:5000/   접속





```python
from flask import Flask
import random

app = Flask(__name__)

@app.route('/')
def hello():
    name = "World!!"
    return f'Hello {name}!'




@app.route('/greeting/<string:name>')
def greeting(name):
    return f'{name}님 안녕하세요'

@app.route('/lunch/<int:num>')
def lunch(num):
    menu = ["짜장면", "짬뽕", "라면", "스파게티", "스테이크", "삼겹살"]
    order = random.sample(menu, num)
    return str(order)

if __name__=="__main__":
    app.run(debug=True, port=8000)

```



 http://127.0.0.1:8000/lunch/3 



### Lotto

```python
from flask import Flask
import random

app = Flask(__name__)

@app.route('/')
def hello():
    name = "World!!"
    return f'Hello {name}!'


# 로또 번호
@app.route('/lotto')
def lotto():
    RandomNum = random.sample(range(1,47),6)
    return str(RandomNum)

if __name__=="__main__":
    app.run(debug=True, port=8000)
```

 http://127.0.0.1:8000/lotto



### 네이버 쿼리 날리기

```python
#naver에 검색쿼리 날리기
@app.route('/fake_naver')
def fake_naver():
  return render_template('fake_naver.html')
```

```html
<form action="https://search.naver.com/search.naver">
    <input type="text" name="query">
    <input type="submit">
</form>
```



### 인디언 이름 짖기

app.py

```python
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
```

```html
<!-- indian_send.html-->
<form action="/indian_recieve" method="GET">
    <input type="date" name="date"> <br>
    <input type="submit" value="보내기">
</form>

<!-- indian_receive.html-->
<h1>{{ date }}</h1>
<h1>{{ year}} </h1>
<h1>{{ month }}</h1>
<h1>{{ day }}</h1>
<h1>{{ name }}</h1>
```









































