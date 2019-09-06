190906 R_day2

```R
.libPaths()  # 패키지가 다운로드되는 경로 확인

#벡터 요소에 access하는 방법
t <- c("Sun","Mon","Tue","Wed","Thurs","Fri","Sat")
print(t[1])   #"Sun"
print(t[7])   #"Sat"
u <- t[c(2,3,6)]   #"Mon","Tue", "Fri"
print(u)

v <- t[c(TRUE,FALSE,FALSE,FALSE,FALSE,TRUE,FALSE)]
print(v)    # "Sun", "Fri"

x <- t[c(-2,-5)] #인덱스 요소를 제외하고 출력
print(x)    #"Sun", "Tue","Wed", "Fri","Sat"

y <- t[c(0,0,0,0,0,0,1)]  #index에 해당하는 요소 출력
print(y)    


#벡터 연산 : 요소간의 연산을 수행
v1 <- c(3,8,4,5,0,11)
v2 <- c(4,11,2)
add.result <- v1+v2      # v1-v2 , v1*v2, v1/v2
print(add.result)


v1 <- c(3,8,4,5,0,11)
v2 <- c(4,11)        #(4, 11, 4, 11, 4, 11)
add.result <- v1+v2  #연산 대상 벡터요소개수가 가장 긴쪽에 맞춰서 요소가 recycling
print(add.result)  

nums <- c(3/2, 3%/%2, 5%%3,2^10,2**10)
print(nums)
print(( 0 %in% nums))
print(( 1024 %in% nums))

#문> nums 벡터 요소중 10보다 큰 요소만 출력 (>, >=,==, !=, <, <= )
print(nums[nums>10])
 
#문> nums 벡터 요소중 짝수인 요소만 출력
print(nums[nums%%2==0]) 


loc <- c("02", "031","062", "052")
str(loc)
names(loc)<-c("서울", "경기", "광주", "부산")
print(loc["경기"])  #이름으로 벡터 요소 접근 가능
str(loc)  

v <- c(3,8,4,5,0,11, -9, 304)
sort.result <- sort(v)
print(sort.result)

revsort.result <- sort(v, decreasing = TRUE)
print(revsort.result)

v <- c("Red","Blue","yellow","violet")
sort.result <- sort(v)
print(sort.result)

#집합연산함수(교집합, 합집합, 차집합, 부분집합, ..)
#identical( 객체1, 객체2) 두객체의 데이터 갯수, 순서도 일치
#union( 객체1, 객체2)
#intersect(객체1, 객체2)
#setdiff(객체1, 객체2)
#setequal(객체1, 객체2)

vec1 <- c(1, 2, 3, 4, 5)
vec2 <- c(10, 9, 8, 4, 5)
vec3 <- c(1, 2, 3, 4, 5)
print(identical(vec1,vec3))
print(identical(vec1,vec2))
vec4 <- c(5,3,4,1,2)
print(setequal(vec1,vec4))  #순서는 일치하지 않아도 요소들만 일치하면 true리턴
print(setequal(vec1,vec3))


print(union(vec1,vec2))
print(intersect(vec1,vec2))
print(setdiff(vec1,vec2))

nums <- c(1, 2, 3, 4, 5)
tracemem(nums)
str(nums)
nums[6]<-10   #벡터에 새로운 data 추가
str(nums)
tracemem(nums)

newValue <-append(nums, 99, after=3)   #data가 추가된 벡터를 리턴함
print(nums)
print(newValue)

##########################################################
#Matrix (기본적으로 열기준으로 2차원 데이터 저장)
#matrix(data, nrow=1, ncol=1, byrow=FALSE, dimnames=NULL)
##########################################################
# Matrix 생성 실습
M <- matrix(c(3:14)) # 열 기준 2차원 데이터 구조
print(M)
str(M)

M1 <- matrix(c(3:14) nrow=3) # 열 기준 2차원 데이터 구조
print(M1)
str(M1)

M2 <- matrix(c(3:14), nrow = 4, byrow = TRUE) #행기준 2차원 데이터 구조
print(M2)
str(M2)

x1 <- c(5, 40, 50:52)
x2 <-c(30, 5, 6:8)
M3 <- rbind(x1, x2)
print(M3)
class(M3)
str(M3)

M4 <- cbind(x1, x2)
print(M4)
str(M4)
class(M3)

M <- matrix(10:19, 2)  #2행?
print(M)
str(M)

#행과 열의 수가 일치하지 않으면 오류가 발생하며, 모자라는 데이터는 첫 번째 데이터부터 재사용하여 채운다
#행렬 객체 생성시 주어진 데이터의 길이는 행과 열의 행렬 수에 정확히 일치되어야 한다. (경고 발생)
M <- matrix(10:20, 2)   

rownames <- c("row1", "row2", "row3", "row4")
colnames <- c("col1", "col2", "col3")

M5 <- matrix(c(3:14), nrow = 4, byrow = TRUE, dimnames = list(rownames, colnames))
print(M5)
str(M5)


P1 <-cbind(M5, c(13,14,15,16)) #cbind()는  컬럼을 추가
print(P1)  #4행 4열

P2 <-rbind(M5, c(13,14,15))  #rbind() 는 행을 추가
print(P2) #5행 3열

print(M5+P1)  # 열 개수가 다름 error 발생
print(M5+P2)  # 행 개수가 다름 error 발생


# Matrix 요소에 접근 - 변수[첨자, 첨자]
# 특정 행이나 특정 열만 접근하는 경우 변수명[행첨자, ], 변수명[, 열첨자] 형식으로 지정
print(M5[1,3])
print(M5[2,])  #2행 전체 요소에 접근
print(M5[,3])   #3열 전체 요소에 접근
print(M5["row1",])  #1행 전체 요소에 접근
print(M5[,"col3"])   #3열 전체 요소에 접근



# Matrix 연산
matrix1 <- matrix(c(3, 9, -1, 4, 2, 6), nrow = 2)
matrix2 <- matrix(c(5, 2, 0, 9, 3, 4), nrow = 2)
result <- matrix1 + matrix2
cat("Result of addition","\n")
print(result)

result <- matrix1 + 10
print(result)
print(length(result))  #전체 원소 개수 반환
print(nrow(result))  #행 수 반환
print(ncol(result))  #열 수 반환


#base패키지의 apply함수 apply(행렬객체, margin(1:행, 2:열), function)
f <- function(x) {  #사용자 정의 함수 
   x*c(1,2,3)
}
result <- apply(matrix1, 1, f)
print(result)

result <- apply(matrix(1:9, ncol=3), 2, f)
print(result)


print(dim(M5))   #matrix의 차원을 리턴


m1 <- matrix(c(1:9), ncol=3, byrow=TRUE)
print(m1)
print(t(m1))  #전치행렬 리턴 함수

m2 <- matrix(rep(1:3, times=3), nrow=3)
print(m2)
print(m1 %*% m2)   ##행렬의 곱 연산


#문> P2 matrix객체에서 2행과 4행을 제외하고 출력
 print(P2[-c(2, 4), ])

#문> P2 matrix객체에서 1열과 3열을 제외하고 출력
print(P2[, -c(1, 3)])

print(m1)
m3<-m1[, -c(1, 3)]   #matrix에서 하나의 열을 남겨놓고, 모든 열을 제거하고, 벡터가 됨
print(m3)
str(m3)

m3<-m1[, -c(1, 3), drop=FALSE]    #벡터로 변환되지 않도록 matrix의 구조 유지하도록 drop옵션
print(m3)
str(m3)

rownames(M5) 
colnames(M5) 
#문> 행이름과 열이름을 제거
rownames(M5) <- NULL
colnames(M5) <- NULL
print(M5)
str(M5)



m4 <- matrix(c(1,2,3,4,5,4,3,2,1), ncol=3)
result <- solve(m4)  #역행렬 결과 리턴
print(result)

print(m4 %*% result)

#######################################################
Array - 동일한 자료형을 갖는 다차원 배열 구조
array() - 행, 열, 면의 3차원 배열 형태의 객체를 생성
첨자로 접근
다른 자료구조에 비해 상대적으로 활용도가 낮음
#######################################################

#Array 생성
vector1 <- c(5,9,3)
vector2 <- c(10,11,12,13,14,15)

result <- array(c(vector1,vector2),dim = c(3,3,2))  #row, col, layer
print(result)
str(result)

column.names <- c("COL1","COL2","COL3")
row.names <- c("ROW1","ROW2","ROW3")
matrix.names <- c("Matrix1","Matrix2")

result <- array(c(vector1,vector2),dim = c(3,3,2), dimnames = list(row.names,column.names,
   matrix.names))
print(result)

#Array 요소 접근
# 2layer의 3행의 모든 데이터 접근   []  3   12   15 
print(result[3, ,2])
# 1layer의 1행의 3열 데이터 접근   13
print(result[1, 3,1])
# 2 layer의 모든 데이터 접근    5 10 13
#                           9 11 14
#                           3 12 15
print(result[ , ,2]) 

vector3 <- c(9,1,0)
vector4 <- c(6,0,11,3,14,1,2,6,9)
array2 <- array(c(vector3,vector4),dim = c(3,3,2))
print(array2)

matrix1 <- result[, , 2]
matrix2 <- array2[, , 2]
print(matrix1 + matrix2)

# apply(data객체, margin,  function)
rs1 <- apply(array2, c(1), sum)
print(result)

##########################################################################
List - 서로 다른 자료구조(벡터, 행렬, 리스트, 데이터프레임 등)을 객체로 구성
키(key)와 값(value)의 한쌍으로 저장
c언어의 구조체, python의 dict 자료구조, java의 map컬렉션 구조와 유사
key를 통해 value 접근
value에 저장되는 자료구조는 벡터, 행렬, 리스트, 데이터프레임 등 대부분의 R객체 저장 가능
함수 내에서 여러 값을 하나의 키로 묶어서 반환하는 경우 유용
list(key1=value1, key2=value2, ...)
##################################################################

#key가 생략된 부분은 [[n]]형식으로 출력되고 , 
#해당 key에 저장된 value는 [n]형식으로 출력되며, 
#한 개의 값이 Vector 형식으로 저장
list1 <- list("lee", "이순신", 95)
print(list1)
str(list1)


emp1 <- list(name='kim', address='seoul', age=30, hiredate=as.Date('2017/01/02'))
print(emp1)
str(emp1)
 
list_data <- list("Red", "Green", c(21,32,11), TRUE, 51.23, 119.1)
print(list_data)
str(list_data)

#list의 요소 접근
print(emp1[1:2])  #색인으로 데이터 값 access
print(emp1$age)  #key로 데이터 값 access

#문] 아래 list_data리스트의 요소중에서 k3에 저장된 세번째 요소만 출력
list_data <- list(k1="Red", k2="Green", k3=c(21,32,11), 
                  k4=TRUE, k5=51.23, k6=119.1)
print(list_data$k3[3])

tracemem(emp1)
emp1$deptno <- 10 #리스트 객체에 새로운 data 추가
str(emp1)
tracemem(emp1)

emp1$age <- NULL      #리스트의 요소를 제거
str(emp1)


# 리스트내에 값의 타입을 리스트 저장 가능 
lst2 <- list(cost=list(val=c(100, 150, 200)) , 
             price=list(val=c(200,250,300)))
str(lst2)
print(lst2)


#cost 키의 두번째 요소를 출력
print(lst2$cost$val[2]) 
#price 키의 세번째 요소를 출력
print(lst2$price$val[3])

lst <- list()
str(lst)
lst[[1]]<-0.5    #list에 키없이 첫번째 data저장
lst[[2]]<-c("a","c", "f")   #list에 키없이 두번째 data저장
str(lst)
lst[["price"]] <- c(100,200,300)
str(lst)


#unlist 함수 : 기본적인 통계 함수들은 벡터에서는 동작하지만 리스트에는 동작하지 않는 경우,
 리스트 구조를 제거하고, 벡터로 만들어주는 함수

vec_emp1<-unlist(emp1)  #서로 다른 데이터 타입의 값들이 chracter로 변환되어 named 벡터로 생성됨
str(vec_emp1)


문> exam1<- list(1,0, 2,0, -3, 4, -5, 6, 7, -8, 9, 10)
#exam1로부터 음수를 제거한 리스트 출력
tracemem(exam1)
exam1[exam1<0]<-NULL
print(exam1)
tracemem(exam1)
#exam1로부터 0를 제거한 리스트 출력
tracemem(exam1)
exam1[exam1==0]<-NULL
print(exam1)
tracemem(exam1)


#lapply 함수는 데이터 객체에 함수를 적용한 결과를 list형태로 반환
a<- list(c(1:5))
b<- list(6:10)
result <-lapply(c(a, b), max) 
print(result)
str(result)


#sapply 함수는 데이터 객체에 함수를 적용한 결과를 벡터 형식로 반환
result <- sapply(c(a, b), max)
print(result)
str(result)


#다차원(중첩) 리스트 - 리스트 자료구조에 다른 리스트가 중첩된 자료구조
multi_list <- list(c1 = list(1, 2, 3),
                   c2 = list(10, 20, 30),
                   c3 = list(100, 200, 300)
print(multi_list)

#다차원 리스트를 열단위로 바인딩
do.call(cbind, multi_list)


###########################################################
DataFrame - 데이터베이스의 테이블 구조와 유사
R에서 가장 많이 사용하는 자료구조
컬럼 단위로 서로 다른 데이터 유형(type)을 저장 가능
리스트와 벡터의 혼합형으로 컬럼은 리스트, 컬럼 내의 데이터는 벡터 자료구조를 갖는다
DataFrame 생성함수 - data.frame(), read.table(), read.csv()
txt, excel, csv 파일로부터 DataFrame 생성
data.frame(컬럼1=자료, 컬럼2=자료, ...컬럼n=자료)
########################################################### 
#여러 개의 벡터 객체를 이용하여 데이터프레임을 생성할 수 있다. 
#이때 모든 컬럼은 길이가 같아야 한다. 컬럼의 길이가 서로 다르면 오류가 발생한다.


d1<- data.frame(no=c(1,2,3,4,5), 
                name=c('kim', 'park', 'lee', 'song', 'hong'),
                gender=c('F', 'W', 'M', 'W', 'M') )
str(d1)
print(d1)

no<-c(1,2,3)
name<-c("hong", "lee", "kim")
pay <-c(150, 250, 300)
vemp <- data.frame(NO=no, Name=name, Pay=pay)  #컬럼명 지정
str(vemp)
print(vemp)


sales1 <- matrix(c(1, 'Apple', 500, 5, 
                   2, 'Peach', 200, 2, 
                   3, 'Banana', 100, 4, 
                   4, 'Grape', 50, 7) , nrow=4, byrow=T)
str(sales1)
df1 <- data.frame(sales1)
str(df1)  #각 컬럼의 데이터 타입은?  컬럼이름은?


df1 <- data.frame(sales1, stringsAsFactors=FALSE)
str(df1)
names(df1) <- c('No', 'Fruit', 'Price', 'Qty')
str(df1) 

#as.numeric()함수는 numeric변환
df1$Qty <- as.numeric(df1$Qty)
df1$Price <- as.numeric(df1$Price)
str(df1) 


#data.frame 객체의 요소에 접근 : 변수명$컬럼명 형식으로 요소 접근, 결과는 벡터로 반환
print(d1$name) #컬럼이름으로 data.frame 의 특정 컬럼 데이터 모두 access

#데이터프레임에 새로운 열 추가
d1$age <- c(30,31,32,33,34)  
str(d1)


#조건에 맞는 데이터만 추출 subset(데이터프레임 객체, 조건) : 조건에 만족하는 행을 추출하여 독립된 객체를 생성
# df1 데이터 프레임에서 수량이 5보다 큰 추출 출력
subset.df1 <- subset(df1, Qty>5)) 
print(subset.df1)
str(subset.df1)

# 문)df1 데이터 프레임에서 가격이 150보다 작은 데이터들 출력
result <- subset(df1, Price<150)
print(result)
str(result)

# 문)df1 데이터 프레임에서 과일명이 바나나인것만  data.frame 구조로  출력
print(subset(df1, Fruit=='Banana')) 

df2<-data.frame(x=c(1:5), 
                y=seq(2, 10, 2), 
                z=c('a', 'b', 'c', 'd', 'e'))
#문) df2 데이터프레임객체의 x컬럼의 값이 2이상이고  y컬럼은 6이하인 데이터들로 구성된 데이터프레임 부분집합 생성
xand <- subset(df2, x>=2 & y<=6)


#문> df2 데이터프레임객체의 x컬럼의 값이 2이상 또는  y컬럼은 6이하인 데이터들로 구성된 데이터프레임 부분집합 생성
xor <- subset(df2, x>=2 | y<=6)


#데이터 프레임에서 특정 컬럼만 추출해서 새로운 형태의 데이터프레임 생성
df5 <- subset(df1, select=c( Fruit, Price, Qty))
str(df5)
print(df5)

df6 <- subset(df1, select=-No)
str(df6)
print(df6) 



emp.data <- data.frame(
   emp_id = c (1:5), 
   emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
   salary = c(623.3,515.2,611.0,729.0,843.25), 
   
   start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11",
      "2015-03-27")),
   stringsAsFactors = FALSE
)
print(emp.data) 
str(emp.data)
#문> emp.data객체에서  3행, 5행의 2열과 4열의 데이터만 추출해서 출력
result <- emp.data[c(3,5),c(2,4)]
print(result)


#summary()는 데이터프레임 객체의 데이터를 대상으로 최소값, 최대값, 중위수, 평균, 사분위수 값을 요약하여 반환
summary(df2)

apply(df2[, c(1,2)], 2, sum) 


df4 <- data.frame(name=c('apple', 'banana', 'cherry'), 
                  price=c(300, 200, 100))
df5 <- data.frame(name=c('apple', 'cherry', 'berry'), 
                  qty=c(10, 20, 30))

#두 데이터프레임 객체의 요소를 병합  
result1<- merge(df4, df5) 
#첫번째 열 데이터 기준으로 일치하는 데이터의 열 결합
print(result1) 
str(result1)

result2<- merge(df4, df5, all=T) 
##첫번째 열 데이터 기준으로 모든 데이터의 열 결합,  Data가 없으면 NA로 채움
print(result2)
str(result2)


str(mtcars)
head(mtcars) # 1~6행만 출력해줌
head(mtcars, 20)
tail(mtcars) #last-5 ~ last행까지 출력해줌
data(mtcars)
View(mtcars)
summary(mtcars) #컬럼단위로 최소값, 1/4분위값, 중앙값, 평균, 3/4분위값, 최대값등 기초 통계값을 리턴
summary(emp.data)

#####################################
#문자열 처리와 관련된 패키지 stringr
#####################################
텍스트 자료나 SNS에서 가공 처리된 빅데이터를 처리하기 위해서는 
필요한 문자열을 적절하게 자르고 , 교체하고 추출하는 작업을 수행할 수 있어야 합니다.
 
install.packages("stringr")
library(stringr)
#str_length()
#str_c() , str_join()
#str_sub(), str_split()
#str_replace()
#str_extract() 정규표현식을 사용하여 문자열 추출
#str_extract_all() 정규표현식을 사용하여 문자열 추
#str_locate() 특정 문자열 패턴의 첫번째 위치 찾기
#str_locatet_all()
.....

fruits <- c('apple', 'banana', 'pineapple', 'berry', 'APPLE')
#패턴을 포함한 요소에서 패턴 출현 회수 리턴
print(str_count(fruits, "a"))  

#문자열 결합 기본 R 함수
rs1<-paste('hello', '~R') 
print(rs1)

print(str_c('hello', '~R'))
print(str_c(fruits, " name is ", fruits))
print(str_c(fruits,  collapse=" "))
print(str_c(fruits,  collapse="-"))

#dataset객체의 요소별로 'A'포함여부를 추적, 
print(str_detect(fruits, 'A')) 
#정규표현식의 형식문자^는 시작을 의미합니다.
print(str_detect(fruits, '^a')) 
#정규표현식의 형식문자$는 끝을 의미합니다.
print(str_detect(fruits, 'a$'))
print(str_detect(fruits, '^[aA]'))    
print(str_detect(fruits, '[^a]'))  #not의 의미

print(str_sub(fruits, start=1, end=3))  #부분 추출
print(str_sub(fruits, start=6, end=9))
print(str_sub(fruits, start=-5))

str_length("  apple   banana  ")  
str_length(str_trim("  apple   banana  "))  #앞뒤 공백 제거 trim() 함수

# dataset객체의 요소 문자열을 길이를 벡터로 리턴
print(str_length(fruits)) 
print(str_dup(fruits, 3))

print(str_replace(fruits, 'p', '**'))
print(str_replace_all(fruits, 'p', '**'))

fruits2 <- str_c(fruits, collapse="/")
print(fruits2)
str(fruits2)

result2<- str_split(fruits2, "/")
print(result2)
str(result2)

str_extract("홍길동35이순신45유관순25", "[1-9]{2}")
str_extract_all("홍길동35이순신45유관순25", "[1-9]{2}")
str_extract_all("honggil305koreaseoul1004you25jeju-hanlasan2005", "[a-z]{3, }")
str_extract_all("honggil305koreaseoul1004you25jeju-hanlasan2005", "[a-z]{3, 5}")

str1 <- "korea123456-1234567seoul"
#문) str1객체에 저장된 문자열로부터 주민번호만 추출
str_extract_all(str1, "[0-9]{6}-[1234][0-9]{6}")

str2 <- "홍길동1357,이순신,유관순1012"
#문) str2객체에 저장된 문자열로부터 7글자 이상의 단어만 추출
str_extract_all(str2, "\\w{7, }")

#str_to_upper()
#str_to_lower()


####################################
데이터 입출력
####################################
#scan() - 키보드로부터 데이터 입력 받기 위해 사용
          입력할 데이터가 없으면 엔터키만 누르면 종료됨
          문자열로 입력받으려면 what=character() 옵션 사용


#키보드로 숫자 입력하기 
num <- scan()
num 

# 합계 구하기
sum(num) 

#키보드로 문자 입력하기
name <- scan(what=character())
name  

#edit() - 데이터 입력을 돕기 위해 표 형식의 데이터 편집기 제공
df = data.frame() #빈 데이터프레임 생성
df = edit(df) # 데이터 편집기
학번 이름 국어 영어 수학
1 홍길동 80 80 80
2 이순신 95 90 95
3 강감찬 95 95 100
4 유관순 85 85 85
5 김유신 95 90 95

print(df)

input1 <- scan(what="")  #korea seoul chongro-gu 입력해보세요
print(input1)
str(input1)   #공백으로 분리해서..단어별로  item으로 저장합니다.

#한 라인의 입력 data를 문자열로 입력 받음 (korea seoul chongro-gu 입력해보세요)
address <- readline()  
print(address)
str(address)

address <- readline("Input Your Address=>") 
print(address)
str(address)



#파일 유형(text,  csv, xml, html, json, db, excel, bigdata저장소(hdfs, nosql) 읽어오기
getwd()
#setwd("c:/workspaceR")  
print(list.files());

#c:/workspaceR 디렉토리 아래 data디렉토리 생성 후 샘플 파일 
다운로드 받아서 압축 풀어 파일들을 저장해주세요
print(list.files(recursive=T));
print(list.files(all.files=T));


################################################################
read.csv(file="경로/파일명" [,sep=","][,header=TRUE])
################################################################

#csv 형식의 data가 저장된 파일로부터 data를 읽어서 R실행환경으로 로딩
data1 <- read.csv("./data/emp.csv")
# data1 <- read.csv("c:/workspaceR/data/emp.csv")
print(data1)
str(data1)   #data.frame객체로 리턴


#사원 데이터에서 최대 급여를 출력
max_sal <- max(data1$pay)
print(sal)


#최대 급여를 받는 레코드(행)만 추출
person1<-subset(data1, pay==max(pay))
print(person1)
 
#문) emp3.csv파일의 데이터를 data.frame객체에 저장한 후에
IT부서에서 급여가 600이상인 사원 추출
data1 <- read.csv("./data/emp3.csv")
info <- subset(data1, salary > 600 & dept == "IT")
print(info) 

##문) emp3.csv파일의 데이터를 data.frame객체에 저장한 후에
입사날자가 2014년 7월 01일 이후인 사원추출
person2 <- subset(data1, as.Date(start_date) > as.Date("2014-07-01"))
print(person2)

#IT부서 사원만 추출해서 csv파일에 저장
itperson <- subset(data1, dept=="IT")
print(itperson)
write.csv(itperson,  "./output/itperson.csv", row.names=FALSE)
list.files("./output/")
newdata <- read.csv("./output/itperson.csv")
print(newdata) 


################################################################
read.xlsx() 엑셀 파일로부터 데이터 읽기
xlsx 패키지가 필요하면 의존하고 있는 rJava패키지를 먼저 로드해야 합니다.
sheetIndex=1은 선택한 엑셀 파일에서 첫 번째 시트 탭을 지정
################################################################
 
install.packages("rJava")   # rJava 패키지 설치 
install.packages("xlsx")   # xlsx 패키지 설치
#Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_151')

library(rJava) # 로딩
library(xlsx) # 로딩

studentex <- read.xlsx(file.choose(), 
                       sheetIndex=1, encoding="UTF-8")
studentex

itperson <- subset(data1, dept=="IT")
print(itperson)
write.xlsx(itperson,  "./output/itperson.xlsx", sheetName="IT", 
           col.names=FALSE, row.names=FALSE)
list.files("./output/")
newdata <- read.xlsx("./output/itperson.xlsx", sheetIndex=1)
print(newdata)


################################################
텍스트파일 읽기 readLines(), read.table()
################################################
#아래 내용을 메모장에 작성해서 작업디렉토리의 data디렉토리 아래 fruits.txt로 저장하세요
no  name  price   qty  
1   apple   500     5  
2   banana  200     2  
3   peach   200     7  
4   berry    50     9  

# 텍스트 파일 읽기, 라인 단위를 문자열로 로딩, 라인단위로 저장되는 벡터 객체로 생성함
file1 <- readLines("./data/fruits.txt")  
print(file1)
str(file1)

#텍스트 파일의 내용을 읽어서 data.frame객체로 생성함
fruits1 <- read.table("./data/fruits.txt" ) 
print(fruits1)
str(fruits1)

fruits1 <- read.table("./data/fruits.txt", header=T)
print(fruits1)
str(fruits1) 

fruits1 <- read.table("./data/fruits.txt", header=T, stringsAsFactor=FALSE)
print(fruits1)
str(fruits1)

# 헤더를 제외한 레코드 2개 skip(제외)하고, 2개의 record만 읽어옴
fruits2 <- read.table("./datas/fruits.txt", header=T, skip=2, nrows=2)
print(fruits2)

#벡터의 데이터를 텍스트 파일로 저장
cat("My Sales", file1,  file="./output/mySales.txt", sep="n", append=TRUE);
list.files("./output/")

```