190905

## R

데이터 분석을 위한 통계 및 그래픽스를 지원하는 객체지향 프로그래밍 언어

- 객체지향 프로그래밍 언어 - 데이터, 함수, 차트 등 모든 데이터를 객체 형태로 관리
- 통계 분석과 data의 시각화 소프트웨어 환경
- 데이터 분석에 필요한 최신 알고리즘, 방법론등의 패키지 집합
- data의 시각화를 위한 다양한 그래픽 도구를 제공
- 모든 객체는 메모리로 로딩되어 고속으로 처리되고 재사용 가능

http://www.r-project.org/ 다운로드



```
#R session은 사용자가 R 프로그램을 시작한 후 R콘솔 시작 ~ 종료까지의 수행된 정보

x <- c(1,2,3,4,5)
y<-c(10,20,30,40, 50)
x+y

#R패키지 개수 확인
dim(available.packages())

available.packages()

#R session은 사용자가 R 프로그램을 시작한 후 R콘솔 시작 ~ 종료까지의 수행된 정보
sessioninfo()
#R프로그램 버전, 운영체제 정보, 다국어 지원현황, 기본 설치된 R패키지 정보 출력함

#설치된 R패키지 목록 확인
installed.packages()

#R패키지 설치
install.packages("stringr")
//update.packages("stringr")
remove.packages("stringr")

#설치된 패키지를 사용하기 위해서 메모리에 로드
library(stringr) 또는 require(stringr)

search( )

#기본 데이터 셋 보기
data()

#빈도수 히스토그램
hist(Nile)
#밀도 기준 히스토그램
hist(Nile, freq=F)
# 분포곡선 그리기
lines(density(Nile))
#Plots영역에 표시할 그래프 개수 설정
par(mfrow=c(1,1))
# 파일 출력 경로
pdf("c:/workspceR/sample.pdf")
#정규분포를 따르는 난수 20개 생성해서 히스토그램 생성
hist(rnorm(20))   
#출력 파일 닫기
dev.off()

# 변수선언
첫문자는 영문자로 시작
두번째 문자부터는 숫자, _, . 사용 가능
대소문자 구분
예약어 사용 불가
변수에 저장된 값은 불변
x<-3
tracemem(x)
x<-'a'
tracemem(x)

R은 변수를 선언할 때 자료형(Type)을 선언하지 않습니다


# 데이터 타입 (Data Type) - numeric, character, logical,
Scalar 변수 - 단일 값(하나의 값)을 저장하는 변수
age <- 30
#age변수는 하나의 값을 저장하고 있는 벡터 타입
벡터(Vector)는 하나 이상의 여러 개의 자료를 저장할 수 있는 1차원의 선형 자료 구조
class(age) 
age <- "29"
class(age)
age <- TRUE   #상수객체(TRUE, FALSE)
class(age)
#T변수에 TRUE 저장, F변수에 FALSE 저장
age <-F
class(age)

age <- NA  #결측치 (Not Available)
class(age+10)
age <- null 
class(age+10)

sum(10, 20, 30)
sum(10, 20, 30, NA)
sum(10, 20, 30, NA, na.rm=T)

#R Seesion에서 생성한 변수 목록 확인
ls()

#자료형 확인
is.numeric(변수)
is.logical(변수)
is.character(변수)
is.na(변수)
is.list(객체)
is.data.frame(객체)
is.array(객체)
is.matrix(객체)

#자료형 형변환
as.numeric(변수)
as.logical(변수)
as.character(변수)
as.list(객체)
as.data.frame(객체)
as.array(객체)
as.matrix(객체)
as.integer(변수)
as.double(변수)
as.complex(변수)  # 복소수
as.factor(객체)
as.Date(객체)

x<-c("1", "2", "3")
result <- x * 3
#print(result)
result <- as.numeric(x) * 3
#print(result)
result <- as.integer(x) * 3
#print(result)

z<-5.3-3i   #복소수 자료형 생성
class(z)   
Re(z)    #실수부만  반환
Im(z)    #허수부만  반환
is.complex(z)
as.complex(5.3)

#class(변수)는 자료구조의 Type을 반환
#mode(변수)는 자료의 Type을 반환

age <- 29.5
mode(age) 
age <- "29"
mode(age)
age <- TRUE    
mode(age) 
age <-F
mode(age)

getwd()
setwd("c:/workspace")
getwd()

as.Date("2019-Sep-05", format="%y-%b-%d")

#Sys.setlocale(category="LC_ALL", locale="언어_국가")
#현재 로케일 정보 전체 확인
Sys.setlocale(category="LC_ALL", locale="Korean_Korea")
Sys.getlocale()

#R에서 제공하는 기본 함수 사용 예제 보기
example(seq)

#R에서 제공하는 함수의 파라미터 형식 보기
args(max)
help(mean)
?sum
??mean

factor - 동일한 값의 목록을 category로 갖는 벡터 자료
변수가 가질 수 있는 값의 범위로서 
예) 성별 변수의 범주는 남, 여
factor는 명목형(Norminal)과 순서형(Ordinal) 유형으로 분류

gender <- c("man","woman", "woman", "man", "man")
plot(gender)  #차트는 수치 데이터만 가능하므로 오류
class(gender)
mode(gender)

ngender <- as.factor(gender) #범주의 순서가 알파벳 순서로 정렬됨
class(ngender)
mode(ngender)
table(ngender) #빈도수 반환
plot(ngender)
is.factor(ngender)
ngender    #Levels속성에서 범주를 확인 (알파벳 순서?)

args(factor)  #factor()함수의 매개변수 확인
ogender <- factor(gender, levels=c("woman", "man"), ordered=T)
ogender    #범주의 순서 확인

par(mfrow=c(1, 2))
plot(ngender)
plot(ogender)









# 연산자

```

