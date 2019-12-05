## 0. 배포전 준비 사항

  - 프로젝트를 TIL 에서 진행하지 않고 독립적인 폴더에 구축!
  - git init 으로 해당 폴더를 git이 독립적으로 관리하는 폴더로 만들어 줘야 한다.

  #### 1. github 레퍼지토리 생성
  - __.gitignore에 해당 코드 추가__
  ```
  .sqlite3
  .env
  .bak
  ```
  - __원격 저장소에 업로드__
    - Heroku는 git형상 관리 시스템과 밀접하게 통합되어 있음.
    - git을 이용하여 활성화된 시스템에 수정 사항의 업로드 및 동기화를 수행
    - 준비된 소스 github에 업로드
    ```
    git init
    git add .
    git commit -m "...."
    git remote add origin .....
    git push origin master
    ```
  #### 2. 환경 변수 관리
  - SECRET 키는 외부에 노출되면 안된다.
  - DEBUG 역시 True로 되어 있게 되면 내부코드가 에러메시지와 함께 드러나기 때문에 보안에 문제가 발생.
  - decouple 라이브러리 활용
  ```
  pip install python-decouple
  ```
  - __.env 파일 생성__
    - KEY=VALUE 형태로 작성
    - 주의사항 !!!!!!!!!!!
      - KEY=VALUE (O) 
      - KEY = VALUE (X) = 옆에 공백 안됨
  * __settings.py 수정__
  ```
  from decouple import config   # <---- import 필수!!

  # 기존에 있던 시크릿 Key는 잘래내서 .env에 붙여 넣는다.
  SECRET_KEY = config('SECRET_KEY') 
  DEBUG = config('DEBUG')
  ```

  #### 3. django-heroku 
  - Heroku에서 만든 라이브러리. Django를 Heroku에 배포하기 위해 사용
  - Django 앱이 heroku 에 동작할 수 있도록 자동으로 환경을 설정해주는 라이브러리.
  ```
  pip install django-heroku
  ```
  * __settings.py 수정__
  ```
  # 최하단에 추가

  # Configure Django App for Heroku.
  import django_heroku
  django_heroku.settings(locals())
  ```
## 1. 배포를 위한 설정
  #### 1. Procfile 생성
  - Procfile은 app의 startup에 필요한 command를 기록하는 파일
  - Process 실행과 관련된 다양한 설정값을 주로 전달
  - 확장자 입력하지 않음!!
  - 파일이름 정확히 기재 확인!!
  - 파일 생성 위치 ( 프로젝트 폴더/Procfile) : manage.py랑 같은 위치
  * __Procfile 생성 후 파일 안에 해당 내용 작성__
  ```
  web: gunicorn [폴더_이름].wsgi --log-file -
  # wsgi.py 파일이 위치한 폴더 이름
  # 우리 수업을 들었으면 config에 해당 파일이 위치해 있을것임.
  ```
    - gunicorn 을 실행시키는 설정 값이 들어감.
  #### 2. Gunicorn 설치
  - Heroku에서 추천되는 HTTP server이다. 
  - 하나의 다이노에서 여러개의 Python 동시 프로세스를 실행할 수 있는 WSGI 어플리케이션을 위한 순수 Python으로 작성된 HTTP server
  ```
  pip install gunicorn
  ```
  #### 3. runtime.txt 작성
  - 현재 프로젝트가 사용중인 python 버전을 입력
  - 생성 위치 (프로젝트폴더/runtime.txt) : manage.py랑 같은 위치
  - python -v 를 cmd 창에 쳐서 버전을 확인할 수 있다.
  ```
  python-3.7.5
  ```

  #### 4. requirements.txt
  - 파이썬 관련 라이브러리 의존성
  - Heroku는 requirements.txt에 패키지들을 자동적으로 설치
  ```
  pip freeze > requirements.txt
  ```
## 2. 배포
  #### 1. Heroku 회원 가입
  - 회원 가입
  - Heroku cli 설치 (설치가 완료되면 vscode 다시 시작!!)
  - cmd 에 heroku 명령어 쳐서 잘 되는지 확인
  ```
  $ heroku
  ```
  - __안된다면__
    - 안되면 vscode 다시 시작했는지 확인!!
    - 그래도 안되면 명령어로 설치 후 재시도
    ```
    $ npm install -g heroku 
    ```
  - __heroku 동작이 잘 되면__
    ```
    $ heroku login
    ```
    - q 키를 제외하고 아무키나 누르면 브라우저에서 로그인 할 수 있다.
  #### 2. Heroku에서 Django App 배포
  - __Heroku App 생성__
  ```
  $ heroku create [만들고픈 app_name]
  ```
    - app_name을 입력하지 않으면 자동 생성.(중복 불가이므로 없는걸로 생성)
    - git remote -v 해보면 heroku가 등록된것을 확인!
  - __Heroku에 환경변수 등록__
    - 환경변수를 Heroku 환경에 따로 등록하여 관리한다.
    ```
    $ heroku config:set SECRET_KEY='...'  #.env 에서 복붙
    $ heroku config:set DEBUG=True # 배포후 False로 변경 필요!
    ```
      - 잘 동작하지 않아도 걱정하지 말길..
      - 브라우저에서 Heroku 사이트 접속!
        - Dashboard 에서 생성된 App을 선택!
        - 안에서 settings 탭 선택!
        - Reveal config Vars 클릭!! 
        - 해당 부분에 키와 벨류를 등록하면 됨.
  - __Heroku에 프로젝트 Push__
    - commit 
    ```
      git add .
      git commit -m "deploy heroku"
      git push heroku master
      heroku config
    ```
      - 에러 발생시
        - 에러가 발생하는 모듈을 requirements.txt에서 삭제하고 다시 진행.
        - git add . > git commit > git push heroku .. 로 다시 업로드
        - 만약 `heroku does not appear to be a git repository` 에러가 발생하면 현재 프로젝트가 github에 없기 때문.
  #### 3. 배포한 Django App Initializing
  - __Migrate__
  ```
  heroku run python manage.py makemigrations
  heroku run python manage.py migrate
  ```
  - ETIMEOUT 에러
  - 5000 port 가 막혀있어서 발생
  - 웹 콘솔에서 직접 작업할 수 있다!!!
    > 우측 상단 More 라는 버튼을 찾아서 run console
    > 그리고 bash를 눌러주면 콘솔창 뜸
    > python manage.py migrate 로 바로 실행가능.
  - __Admin__
  ```
  heroku run python manage.py createsuperuser
  ```
  - __배포 완료__
  ```
  heroku open
  ```
  #### 4. Social Login
  - 기존 처럼 secret key admin에 등록
  - 카카오/ 네이버에 URL 등록