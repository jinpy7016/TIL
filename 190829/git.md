

# Git

> Git은 분산버전관리시스템(DVCS) 이다.
>
> 소스코드의 이력을 관리한다.

[ https://backlog.com/git-tutorial/kr/ ]



## 1. git 설정

git 커밋을 하기 위해서는 초기에 작성자(author) 설정을 반드시 하여야 한다.



```bash
$git config --global user.name
$git config --global user.email
```



## 2. git 활용 기초

 1. 로컬 git 저장소 설정

    ```bash
    $ git init
    Initialized empty Git repository in C:/Users/student/Desktop/gitlearning/.git/
    (master) $
    ```

    - 해당 디렉토리에 .git/ 폴더가 생성된다.

    - 항상 ` git init` 하기 전에는 해당 폴더가 이미 로컬 저장소인지(master) 여부를

      확인 해야 한다.
    
	  2. add

    ```bash
    $ git add .
    $ git add README.md a.txt
    $ git add folder/
    ```

    - add 명령어를 통해서 `working directory` 에서 INDEX(staging area) 로 특정 

      파일들을 이동시킨다.

    - 커밋을 할 목록에 쌓는 것이다.

	  

    3.
    
    ```bash
    $ git commit -m '커밋메시지'
$ git commit
    ```
    
4.  커밋 히스토리 확인하기(log)

   ```bash
   $ git log
   $ git log -2
   $ git log --online
   ```

5.  현재 git 상태 알아보기(`status`)  중요! 자주 입력해서 

   ```bash
   
   $ git status
   ```



## 3.원격저장소(remote) 활용하기

1. remote 저장소 등록

   ```bash
   $ git remote add origin {github URL}
   ```

   - 원격 저장소를 `origin`이라는 이름으로 `URL` 을 등록한다.

2.  remote 저장소 확인

   ```bash
   $ git remote -v
   ```

3.  remote 저장소 삭제

   ```bash
   $ git push origin master2
   ```



## 2. Push -pull

1. 원격 저장소로 보내기(push)

   ```bash
   $ git push origin master
   ```

2.  원격 저장소로부터 가져오기(`pull`)

   ```bash
   $ git pull origin master
   ```

   

## 3. Push-pull 시나리오

Local A, Local B, Github으로 활용을 하는 경우 원격저장소 이력과 달라져서 충돌이 발생할 수 있다.

따라서, 항상 작업을 시작하기전에  pull 을 받고, 작업을 완료한 이후에 push를 진행하면 충돌 사항이 발생하지 않는다!

 1. auto-merge

    - 동일한 파일을 수정하지 않은 경우 자동으로 merge commit이 발생 한다.

    ``` 
    1. Local A에서 작업 후 Push
    2. Local B에서 작업 시 pull을 받지 않음.
    3. Local B에서 작업 후 commit -> push
    4. 오류 발생 (~~ git pull~~)
    5. Local B에서 git pull
    6. 자동으로 vim commit 발생
    7. 저장하면, merge commit 발생
    8. Local B에서 git push!
    ```

2. merge conflict

   - 다른 이력(커밋)으로 동일한 ~~~

   - 직접 충돌 파일을 해결 해야 한다!

     ```
     1. local a 에서 작업 후 push
     2. local b 에서 작업 시 pull을 받지 않음.
     3. local b 에서동일 파일 작업 후 commit -> push
     4. 오류 발생 (~~ git pull~~)
     5. Local B에서 git pull
     6. 충돌 발생(merge conflict)
     7. 직접 오류 수정 및 add, commit
     8. Local B에서 git push
     ```

   - git status 명령어를 통해 어느파일에서 충돌이 발생하였는지 확인 가능!

   - 실제 파일 예시

     ```
     <<<<<<<<<<< HEAD
     Local B 작업
     =========
     원격 저장소에 기록된 작업
     >>>>>>>>>>> fja9f2ifsfj2dj2djajsd99sjd
     ```

     





