190909 r_day3

# 헤더를 제외한 레코드 2개 skip(제외)하고, 2개의 record만 읽어옴
fruits  <- read.table("./data/fruits.txt", header=T, skip=2, nrows=2)
print(fruits )
str(fruits)
class(fruits)


#R객체를 바이너리 파일로 저장 save(), load()
str(fruits)
save(fruits, file="./output/fruits.RData")
rm(list=ls())
f = load("./output/fruits.RData")
print(f)


#########################################
# XML 구조의 파일을 Read/Write
#########################################
#XML 또는 HTML 문서를 가져오기 위해서 httr과 XML 패키지를 설치합니다.

<RECORDS>
   <EMPLOYEE>
      <ID>1</ID>
      <NAME>Rick</NAME>
      <SALARY>623.3</SALARY>
      <STARTDATE>1/1/2012</STARTDATE>
      <DEPT>IT</DEPT>
   </EMPLOYEE>
	
   <EMPLOYEE>
      <ID>2</ID>
      <NAME>Dan</NAME>
      <SALARY>515.2</SALARY>
      <STARTDATE>9/23/2013</STARTDATE>
      <DEPT>Operations</DEPT>
   </EMPLOYEE>

   <EMPLOYEE>
      <ID>3</ID>
      <NAME>Michelle</NAME>
      <SALARY>611</SALARY>
      <STARTDATE>11/15/2014</STARTDATE>
      <DEPT>IT</DEPT>
   </EMPLOYEE>

   <EMPLOYEE>
      <ID>4</ID>
      <NAME>Ryan</NAME>
      <SALARY>729</SALARY>
      <STARTDATE>5/11/2014</STARTDATE>
      <DEPT>HR</DEPT>
   </EMPLOYEE>

   <EMPLOYEE>
      <ID>5</ID>
      <NAME>Gary</NAME>
      <SALARY>843.25</SALARY>
      <STARTDATE>3/27/2015</STARTDATE>
      <DEPT>Finance</DEPT>
   </EMPLOYEE>

   <EMPLOYEE>
      <ID>6</ID>
      <NAME>Nina</NAME>
      <SALARY>578</SALARY>
      <STARTDATE>5/21/2013</STARTDATE>
      <DEPT>IT</DEPT>
   </EMPLOYEE>

   <EMPLOYEE>
      <ID>7</ID>
      <NAME>Simon</NAME>
      <SALARY>632.8</SALARY>
      <STARTDATE>7/30/2013</STARTDATE>
      <DEPT>Operations</DEPT>
   </EMPLOYEE>

   <EMPLOYEE>
      <ID>8</ID>
      <NAME>Guru</NAME>
      <SALARY>722.5</SALARY>
      <STARTDATE>6/17/2014</STARTDATE>
      <DEPT>Finance</DEPT>
   </EMPLOYEE>
	
</RECORDS>

install.packages("XML")
library(XML)
data2 <- xmlParse(file="./data/emp.xml")
print(data2)
str(data2)

#ROOT NODE만 추출
rootnode <- xmlRoot(data2)
print(rootnode)
class(rootnode)
str(rootnode)

#rootnode의 자식 노드 갯수 
rootsize <- xmlSize(rootnode)
print(rootsize)

#rootnode의 첫번째 자식 노드 출력
print(rootnode[1])

#rootnode의 첫번째 자식 노드의 이름과 부서와 급여 출력
print(rootnode[[1]][[2]]);
print(rootnode[[1]][[3]]);
print(rootnode[[1]][[5]]);

#XML을 R의 지원형식인 data.frame으로 로딩
xmldataframe <- xmlToDataFrame("./datas/emp.xml")
print(xmldataframe)
str(xmldataframe)
class(xmldataframe)



#########################################
#JSON 데이터 Read/Write
#########################################
# datas디렉토리에 emp.json 파일로 저장
{ 
   "ID": ["1","2","3","4","5","6","7","8" ],
   "Name":["Rick","Dan","Michelle","Ryan","Gary","Nina","Simon","Guru" ],
   "Salary":["623.3","515.2","611","729","843.25","578","632.8","722.5" ],

   "StartDate":[ "1/1/2012","9/23/2013","11/15/2014","5/11/2014","3/27/2015","5/21/2013",
      "7/30/2013","6/17/2014"],
   "Dept":[ "IT","Operations","IT","HR","Finance","IT","Operations","Finance"]
}

install.packages("rjson")
library("rjson")
rm(list=ls())
data1 <- fromJSON(file="./data/emp.json")  # list 객체로 읽어옴
print(data1)
str(data1)

emp.dataframe <- as.data.frame(data1)
print(emp.dataframe)
str(emp.dataframe)

fruits1 <- read.table("./data/fruits.txt", header=T, stringsAsFactor=FALSE)
print(fruits1)
str(fruits1)
class(fruits1)

result <- toJSON(fruits1)
print(result)
str(result)
write(result, "./output/fruits.json")
list.files("./output/")




##########################################################
# HTML
##########################################################
# httr 패키지는 지정한 url의 HTML소스를 가져오는 GET() 함수를 제공하고
# <table> 태그의 내용을 읽어올 수 있는 readHTMLTable()함수를 제공합니다.
# readHTMLTable()에 사용되는 속성 
- get_url$content  : GET(url)함수에 의해서 가져온 HTML소스의 내용
- rawToChar() : 바이너리(binary) 소스를 HTML 태그로 변환
- stringsAsFactors = F : 문자열을 요인으로 처리하지 않고 순수한 문자열로 가져오기

https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015
###################################################################

install.packages("httr")
library(httr)
url <- "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"
get_url <- GET(url)
html_cont <- readHTMLTable(rawToChar(get_url$content), stringsAsFactors = F)
str(html_cont)
class(html_cont)
html_cont <- as.data.frame(html_cont)
head(html_cont)
str(html_cont)
class(html_cont)
names(html_cont) <- c("State", "y2010", "y2011","y2012", "y2013", "y2014", "y2015")
tail(html_cont)


##########################################################
sink() - 작업한 모든 내용이 파일에 저장
########################################################
sink("./output/R_processing.txt")
url <- "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"
get_url <- GET(url)
html_cont <- readHTMLTable(rawToChar(get_url$content), stringsAsFactors = F)
str(html_cont)
class(html_cont)
html_cont <- as.data.frame(html_cont)
head(html_cont)
str(html_cont)
class(html_cont)
names(html_cont) <- c("State", "y2010", "y2011","y2012", "y2013", "y2014", "y2015")
tail(html_cont)
sink()             #오픈된 파일 close

###############################################################
write.table() - R 스크립트에서 처리된 결과를 테이블 형식으로 저장할 수 있는 함수
- row.names :  행번호를 제거하는 속성
- quote :  따옴표 제거
###############################################################
library(xlsx)
studentx <-read.xlsx(file.choose(), sheetIndex=1, encoding="UTF-8")
print(studentx)
str(studentx)
class(studentx)
write.table(studentx, "./output/std.txt")   #행번호, 따옴표 출력?

write.table(studentx, "./output/std2.txt", row.names=FALSE, quote=FALSE) 


###############################################################
산술 연산자 : +, _, *, /, %%, ^, **
관계 연산자 : ==, !=, >, >=, <, <=
논리 연산자  : &, |, !, xor()
###############################################################
x <- TRUE; y <- FALSE
xor(x, y)


###############################################################################
조건문 : if(조건식) {참인 경우 처리문 } else { 거짓인 경우 처리문}
ifelse(조건식, 참인 경우 처리문, 거짓인 경우 처리문)
switch (비교문, 실행문1, 실행문2, 실행문3) : 비교 문장의 내용에 따라서 여러 개의 실행 문장 중 하나를 선택
which(조건)  : 벡터 객체를 대상으로 특정 데이터를 검색하는데 사용되는 함수
which() 함수의 인수로 사용되는 조건식에 만족하는 경우 벡터 원소의 위치(인덱스)가 출력되며, 조건식이 거짓이면 0이 출력된다.
for(변수 in 자료구조변수) {실행문} : 지정한 횟수만큼 실행문을 반복 수행
while(조건) { 실행문 }  : while블럭안에 증감식 포함
###############################################################################
x<-3
y<-5
if(x*y >= 30) {
  cat("x*y의 결과는 30이상입니다.\n")
}else {
  cat("x*y의 결과는 30미만입니다.\n")
}


#문> 사용자로부터 표준입력으로 점수를 입력받아서 학점을 출력하시오
#if(조건) { 실행문 } else if(조건) { 실행문장 }....else{실행문장}
score <- scan()
#점수 입력
#엔터
if(score>=90){
  result ="A학점"
}else if(score>=80){
  result ="B학점"
}else if(score>=70){
  result ="C학점"
}else if(score>=60){
  result ="D학점"
}else {
  result ="F학점"
}
cat("점수 ",score,"의 학점은 ", result)


# ifelse(조건식, 참인 경우 처리문, 거짓인 경우 처리문)
문) 사용자로부터 표준입력으로 정수를 입력받아서 짝수 또는 홀수 평가 
결과를 출력하시오
num <- scan()
#정수 입력
#엔터
ifelse(num%%2==0, "짝수", "홀수")

#switch (비교문, 실행문1, 실행문2, 실행문3,...)
#비교문의 변수의 값이 실행문에 있는 변수와 일치할때 , 해당 변수에 할당된 값이 출력됩니다.
switch("name", id="hong", pwd="1234", age=25, name="홍길동")

#사원이름을 입력 받아서 해당 사원의 급여 출력
ename <- scan(what="")

print(ename)
switch(ename, hong=250, lee=300, park=350, kim=200)

names <- c("kim", "lee", "choi", "park")
which(names == "choi")

no<-c(1:5)
name <- c("홍길동", "이순신", "강감찬", "유관순", "김유신")
score <-c(85,90,78,74,80)
exam <- data.frame(학번=no, 이름=name, 성적=score)
문> which함수를 사용해서 유관순의 학번, 이름, 성적을 출력
print(exam[which(exam$이름=="유관순"), ])

i<-c(1:10)
#짝수만 출력
for( n in i) 
  if(n%%2==0) print(n)


for( n in i) {
  if(n%%2==1) {
     next
   }else{
     print(n) 
  }
}


#데이터 프레임에서 컬럼명 추출, 출력
name <- c(names(exam))
for (n in name) 
   print(n)

#while문으로 짝수 출력
i <-0
while(i<10) {
   i<- i+1
   if(n%%2==0) print(n)
}


# repeat { 반복 수행문장 ; 반복문 탈출할 조건문; 증감식 }
# repeat문으로 짝수 출력

i <-0
repeat {
   if(i>10) break 
   i<- i+1   
   if(i%%2==0) print(i)
}


###############################################################################
함수 : 코드의 집합
함수명 <- function(매개변수) { 실행문 }
###############################################################################
#매개변수 없는 함수
f1 <- function(){
   cat("매개변수 없는 함수")
}
f1()    #함수 호출


#매개변수가 있는 함수
f2 <- function(x){
    if(x%%2==0) print("짝수")
}

f2(10)    #함수 호출

#결과 반환 함수
f3 <- function(a, b){
    add <- a+b
    return(add)
}

result <- f3(11, 4)    #함수 호출
print(result)

문1> 함수 정의하시오 (매개변수는 정수1개, 매개변수가 0이면 0을 반환
0이 아니면 매개변수의 2배의 값 반환)

f4 <- function(n) {
    ifelse(n==0, 0, n*2)
}

print(f4(0))
print(f4(3))
print(f4(-3))

문> 함수를 정의하시오 (첫번째 매개변수는 벡터객체, 
두번째 매개변수는 함수타입 - mean, sum, median을 문자열로 입력받아서
mean인경우 벡터의 평균을 반환, sum은 벡터 요소의 합계 반환
median은 벡터 요소의 중앙값 반환)

nums <- 1:10
f5 <- function(v, type) {
    switch(type,  mean=mean(v), sum=sum(v), median=median(v))
}

print(f5(nums, "mean"))
print(f5(nums, "sum"))
print(f5(nums, "median"))


# 함수 내부에 함수를 정의할 수 있습니다.
outer <- function(x, y){
   print(x)
   inner <- function(y) {
       print(y*2)
   }
   inner(y) #내부 함수 호출
}
print(outer(3, 7))
print(inner(7))   #내부 함수는 내부함수를 정의한 함수 내부에서만 호출 가능
str(outer)


callee <- function(x){
   print(x*2)
}
caller <- function(v, call){
   for (i in v) {
      call(i)
   }
}

print(caller(1:5, callee))  #함수의 매개변수로 함수 전달 가능?


g<-"global"    #전역변수 , 글로벌 변수
f6 <- function(){ 
        loc<-"local"    #로컬변수
        print(loc)
        print(g)
      }
f6()
print(g)
print(loc) #로컬변수는 정의된 함수 스코프 외부에서 참조 불가능

#R에서 변수 검색 Scope 순서 :
함수 내부에서 검색 ->전역 메모리에서 검색 -> 에러 발생

g1 <- 1000
f7 <- function(){
         g1 <- 100   #전역변수 참조?(X) 로컬변수 정의?(O)
         print(g1) 
      }
print(f7())
print(g1)   


f7 <- function(){
         g1 <<- 100   #전역변수 참조? 로컬변수 정의?
         print(g1) 
      }
print(f7())
print(g1) 



f8 <- function(num1){
   local <- num1
   return (function(num2) {
             return (local+num2)   #클로저
             })
    }
result.function <- f8(100)  #함수 리턴
str(result.function)
print(result.function(200))  

f9 <- function(a, b, c) {
   result <- max(c(a, b, c))
   print(result)
}

f9(5, 3, 11)  #위치기반으로 파라미터 전달 방식
f9(c=5, a=3, b=11)  #이름기반으로 파라미터 전달 방식


f10 <- function(a=3, b=6){  #기본값 파라미터 
         result <- a*b 
         print(result) 
       }
f10()
f10(9, 5)
f10(5)  #?


##############################################################
결측치가 포함된 데이터를 대상으로 평균구하기 :
1. 결측치를 무조건 제거한 후 평균 구하기  => 데이터 손실 발생
2. 결측치를 0으로 대체하여 평균 구하기
3. 결측치를 전체 변량의 평균으로 대체하여 평균구하기 
################################################################
data <-c(10, 20, 5, 4, 40, 7, NA, 6, 3, NA, 2, NA)
#mean(data, na.rm = T)
print(data)
print(mean(data, na.rm=T))

data1 = ifelse(!is.na(data), data, 0)
print(data1)
print(mean(data1))

data2 = ifelse(!is.na(data), data, round(mean(data, na.rm=T), 2))
print(data2)
print(mean(data2))


##############################################################
몬테카를로 시뮬레이션은 현실적으로 불가능한 문제의 해답을 
얻기 위해서 난수의 확률 분포를 이용하여  모의시험으로 근사적 해를 구하는 기법
* 동전 앞면과 뒷면의 난수 확률분포의 기대확률 모의시험 
- 일정한 시행 횟수 이하이면 기대확률이 나타나지 않지만, 
시행 횟수를 무수히 반복하면 동전 앞면과 뒷면의 기대확률은 0.5에 가까워진다.
#################################################################
coin <- function(n) {
    r <- runif(n, min=0, max=1)
    result <- numeric()
    for(i in 1:n){
      if(r[i] <= 0.5)
         result[i] <- 0 #앞면
      else 
         result[i] <- 1 #뒷면
     }
    return (result)
}

result1 <- coin(10)   #동전 던지기 시행 횟수 10번 
table(result1)
hist(result1)
result2 <- coin(100)   #동전 던지기 시행 횟수 100번 
table(result2)
hist(result2)
result3 <- coin(1000)   #동전 던지기 시행 횟수 1000번 
table(result2)
hist(result3)
result3 <- coin(10000)   #동전 던지기 시행 횟수 10000번 
table(result2)
hist(result3)


monteCoin <- function(n){
   cnt <- 0
   for(i in 1:n) {
     cnt <- cnt + coin(1)
   }
   result <- cnt / n   #동전 앞면과 뒷변의 누적 결과를 시행횟수(n)으로 나눔: 기대확률
   return (result)
 }

monteCoin(10)
monteCoin(30)
monteCoin(100)
monteCoin(1000)
monteCoin(10000)


#############################################################################
# 기술 통계량 처리 관련 내장함수
min(vec) 
max(vec)
range(vec) : 대상 벡터 범위값 반환(최소값~최대값)
mean(vec) :평균
median(vec) : 중앙값
sum(vec)
sort(x)
order(x) : 벡터의 정렬된 값의 색인(index)을 보여주는 함수
rank(x)  : 순위
sd(x) : 표준편차
summary(x)
table(x) : 빈도수
sample(x, y) : x 범위에서 y만큼 sample 데이터를 생성하는 함수
#############################################################################
vec <- c(1, 10, 3, 6, 2, 9, 5, 8, 7, 4)
print(range(vec))
print(sd( vec ))
print(sort(vec))
print(sort(vec, decreasing=T))
print(order(vec))
print(vec[order(vec)])
print(sample(vec, 3))
print(table(vec))
print(rank(vec))



#############################################################################
#rnorm() : 정규분포(연속형)의 난수 생성, 평균과 표준편차를 이용
#rnorm(생성할 난수 개수, mean , sd)

#runif() : 균등분포(연속형)의 난수 생성 , 최소값과 최대값을 이용
# runif(생성할 난수 개수, min, max)

#rbinom() : 이산변량(정수형)을 갖는 정규분포의 난수 생성
seed값을 지정하면 동일한 난수를 발생시킬 수 있다
#############################################################################
n <- 1000
result <- rnorm(n, mean=0, sd=1) 
head(result, 20)
hist(result)  #좌우 균등한 종 모양의 이상적인 분포가 그려져야 함


n <- 1000
result <- runif(n, min=0, max=10) 
head(result, 20)
hist(result)

#rbinom은 독립적인 반복 횟수와 변량의 크기, 확률을 적용하여 
이산형(정수형) 난수를 생성
n<-20 
rbinom(n, 1, prob=1/2)  #0, 1의 이산변량을 0.5 확률로 20개 난수 생성

rbinom(n, 2, prob=1/2)  #0, 1, 2의 이산변량을 0.5 확률로 20개 난수 생성

rbinom(n, 10, prob=1/2)  #0~10의 이산변량을 0.5 확률로 20개 난수 생성

n <- 1000
result <- rbinom(n, 5, prob=1/6)
hist(result)

rnorm(5, mean=0, sd=1)
rnorm(5, mean=0, sd=1)
set.seed(123)
rnorm(5, mean=0, sd=1)
set.seed(123)
rnorm(5, mean=0, sd=1)  #종자값이 동일하면 항상 동일한 난수 발생



#############################################################################
수학 관련 내장 함수
abs(x)
sqrt(x)
ceiling(x), floor(x), round()
factorial(x)
which.min(x) / which.max(x) : 벡터 내 최소값과 최대값의 인덱스를 구하는 함수
pmin(x) /pmax(x) : 여러 벡터에서의 원소 단위 최소값과 최대값
prod() : 벡터의 원소들의 곱을 구하는 함수
cumsum() / cumprod() : 벡터의 원소들의 누적합과 누적곱을 구하는 함수
cos(x), sin(x), tan(x)  : 삼각함수
log(x) : 자연로그
log10(x) : 10을 밑으로 하는 일반로그 함수
exp(x) : 지수함수


###############################################################




###############################################################
행렬연산 관련 내장 함수
ncol(x) : x의 열(컬럼) 수를 구하는 함수
nrow(x) : x의 행 수를 구하는 함수
t(x) : x 대상의 전치행렬을 구하는 함수
cbind(...) : 열을 추가할 때 이용되는 함수
rbind(...) : 행을 추가할 때 이용되는 함수
diag(x) : x의 대각행렬을 구하는 함수
det(x) : x의 행렬식을 구하는 함수
apply(x, m, fun) :  행 또는 열에 지정된 함수를 적용하는 함수
solve(x) : x의 역행렬을 구하는 함수
eigen(x) : 정방행렬을 대상으로 고유값을 분해하는 함수
svd(x) : m x n 행렬을 대상으로 특이값을 분해하는 함수
x %*% y : 두 행렬의 곱을 구하는 수식

###############################################################



데이터 분석의 도입부 : 전체적인 데이터의 구조를 분석하거나 분석 방향을 제시
데이터 분석의 중반부 : 잘못된 처리 결과를 확인
데이터 분석의 후반부 : 분석결과를 도식화하여 의사결정에 반영하기 위해서 데이터를 시각화

이산변수로 구성된 데이터 셋을 이용하여 막대, 점, 원형 차트를 그릴 수 있다.
연속변수로 구성된 데이터프레임을 대상으로 히스토그램과 산점도를 그릴 수 있다.

데이터 분석의 도입부에서 전체적인 데이터의 구조를 살펴보기 위해서 시각화 도구를 사용한다.
숫자형 컬럼 1개 시각화 도구 - hist, plot, barplot
범주형 컬럼 1개 시각화 도구 - pie, barplot
숫자형 컬럼 2개 시각화 도구 - plot, abline, boxplot
숫자형 컬럼 3개 시각화 도구 - scatterplot3d(3차원 산점도)
n개의 컬럼 시각화 도구 - pairs(산점도 매트릭스)

이산변수(discrete quantitative data) - 정수 단위로 나누어 측정할 수 있는 변수
barplot() - 기본적은 세로 막대 차트를 제공
ylim(y축 범위), col(막대 색상) , main(제목)

chart_data <- c(305, 450, 320, 460, 330, 480, 380, 520)
names(chart_data) <- c("2014 1분기","2015 1분기"
                      , "2014 2분기", "2015 2분기"
                      , "2014 3분기", "2015 3분기"
                       , "2014 4분기", "2015 4분기"
)
str(chart_data)
print(chart_data)

barplot(chart_data, ylim=c(0, 600),  col=rainbow(8),
        main="2014년도 VS 2015년도 분기별 매출현황 비교",
        ylab="매출액(단위:만원)", xlab="년도별 분기현황")

#가로 막대 차트 : horiz=TRUE
barplot(chart_data, xlim=c(0, 600), horiz=TRUE,  col=rainbow(8),
        main="2014년도 VS 2015년도 분기별 매출현황 비교",
        ylab="매출액(단위:만원)", xlab="년도별 분기현황")

#막대의 굵기와 간격 지정 : space (값이 클수록 막대의 굵기는 작아지고, 간격은 넓어진다)
#축 이름 크기 설정 : cex.names
barplot(chart_data, xlim=c(0, 600), horiz=TRUE, 
       main="2014년도 VS 2015년도 분기별 매출현황 비교",
        ylab="매출액(단위:만원)", xlab="년도별 분기현황"
        , space=2, cex.names=0.8, col=rep(c(2, 4), 4))

#색상 index값 : 검은색(1), 빨간색(2), 초록색(3), 파란색(4), 하늘색(5), 자주색(6), 노란색(7)

barplot(chart_data, xlim=c(0, 600), horiz=TRUE, 
       main="2014년도 VS 2015년도 분기별 매출현황 비교",
        ylab="매출액(단위:만원)", xlab="년도별 분기현황"
        , space=5, cex.names=0.5, col=rep(c(1, 7), 4))


data(VADeaths)
str(VADeaths)    #5행 4열
class(VADeaths)  #matrix
mode(VADeaths)   # numeric
head(VADeaths, 10)
# VADeaths 데이터셋은 1940년 미국 버지니아주의 하위계층 사망비율을 기록한 데이터셋

par(mfrow=c(1, 2)) 
barplot(VADeaths, beside=T, col=rainbow(5), 
        main="미국 버지니아주의 하위계층 사망비율")
#범례 출력
legend(19,71, c("50-54", "55-59", "60-64", "65-69", "70-74")
       , cex=0.8, fil=rainbow(5))

#누적막대 차트
barplot(VADeaths, beside=F, col=rainbow(5) )
title(main="미국 버지니아주의 하위계층 사망비율", font.main=4)
legend(3.8, 200, c("50-54", "55-59", "60-64", "65-69", "70-74")
       , cex=0.8, fil=rainbow(5))

#beside=T/F : X축 값이 측면으로 배열, F이면 하나의 막대에 누적
#font.main : 제목 글꼴 지정
#legend() : 범례 위치, 이름, 글자 크기, 색상 지정
#title() : 차트 제목, 차트 글꼴 지정


###################################################
점차트 - 점의 모양, 색상 설정 가능
labels : 점에 대한 설명문
cex : 점의 확대
pch : 점 모양  원(1), 삼각형(2),....
color : 점 색상 
lcolor : 선 색상


par(mfrow=c(1, 1)) 
dotchart(chart_data, color=c("blue", "red"), lcolor="black", 
        pch=1:2, labels=names(chart_data), xlab="매출액", 
        main="2014년도 VS 2015년도 분기별 매출현황 비교"
        , cex=1.2)


par(mfrow=c(1, 1)) 
pie(chart_data, col=rainbow(8),  
        pch=1:2, labels=names(chart_data),   
        main="2014년도 VS 2015년도 분기별 매출현황 비교"
        , cex=1.2)

#연속변수(Continuous quantitative data)는 시간, 길이 등과 같이 연속성을 가진 변수
#boxplot은 요약 정보를 시각화하는데 효과적
#데이터의 분포 정도와 이상치 발견을 목적으로 하는 경우 유용하게 사용된다.
boxplot(VADeaths, range=0) #컬럼의 최대값과 최속밧을 점선으로 연결

#notch=T : 중위수(허리선) 비교
boxplot(VADeaths, range=0, notch=T )
#abline() : 기준선 추가(선 스타일, 선 색상)
abline(h=37, lty=3, col="red")


# 히스토그램 -  측정값의 범위(구간)를 그래프의 x축으로 놓고, 범위에 속하는 측정값의 출현 빈도수를 y축으로 나타낸 그래프 형태
# 히스토그램의 도수의 값을 선으로 연결하면 분포곡선을 얻을 수 있다
data(iris)
names(iris) 
str(iris)     #data.frame, 
head(iris)
#붓꽃 3종류의 관측 데이터 -Sepal.length, Sepal.Width(꽃받침)
Petal.length, Petal.Width(꽃잎)

summary(iris$Sepal.Length) #꽃받침 길이의 요약 통계

hist(iris$Sepal.Length, xlab="iris$Sepal.Length", 
     col="magenta", main="꽃받침 길이 histogram" , xlim=c(4.3, 7.9))

#빈도수로 히스토그램 그리기
par(mfrow=c(1,2))
hist(iris$Sepal.Width, xlab="iris$Sepal.Width", 
     col="green", main="꽃받침 넓이 histogram" , xlim=c(2.0, 4.5))

#확률 밀도로 히스토그램 그리기
hist(iris$Sepal.Width, xlab="iris$Sepal.Width", 
     col="mistyrose", freq=F,
     main="꽃받침 넓이 histogram" , xlim=c(2.0, 4.5)) 
#밀도를 기준으로 분포 곡선 추가
lines(density(iris$Sepal.Width), col="red") 
#정규분포 추정 곡선 추가
x<-seq(20, 4.5, 0.1)
curve(dnorm(x, mean=mean(iris$Sepal.Width), sd=sd(iris$Sepal.Width)), 
      col="blue", add=T)














