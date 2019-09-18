getwd()
data <- read.csv("./data/descriptive.csv", header=TRUE)
head(data)
str(data)     #8개변수(컬럼), 300개의 관측치
#resident(거주지역)
#gender(성별 - 명목(1,2))
#level(학력수준-서열1,2,3)
#cost(생활비-비율)
#type(학교유형-명목 1, 2)
#survey(만족도 -등간척도 5점)
#pass(합격여부- 명목 1, 2)

dim(data)
length(data) #변수 개수 (컬럼개수)
length(data$survey)   #관측치 개수 (행개수)

fivenum(data)
summary(data)  #컬럼단위로 최소값, 최대값, 평균, 1,3 분위수, 결측치, 중앙값(중위수) 등 제공


#명목척도의 기술 통계량 - 결측치 제거 -> 빈도수 - >비율 ->백분률 
length(data$gender)  #관측치 확인
summary(data$gender)  #명목척도는 최소값, 최대값, 평균등 의미없음

table(data$gender) #각 성별의 빈도수

data <- subset(data, data$gender==1 | data$gender=2)
x <- table(data$gender)  #빈도수에 따른 분할표
barplot(x)  #범주별 데이터 시각화 -> 막대 차트

y <- prop.table(x) #비율 계산
round(y*100, 2)    #백분률로 변환

#########서열 척도 기술 통계량
data <- read.csv("./data/descriptive.csv", header=TRUE)
summary(data$level)  #명목척도는 최소값, 최대값, 평균등 의미없음
table(data$level)  #고졸(1), 대졸(2), 대학원(3)  의 빈도수에 따른 분할표

x1<- table(data$level) 
barplot(x1)

y1 <- prop.table(x1) #비율 계산
round(y1*100, 2)    #백분률로 변환



#########등간 척도 기술 통계량
survey <- data$survey
survey
summary(survey) #등간척도에서 평균 통계량은 어느 정도 의미가 있다고 볼 수 있습니다.

x2 <- table(survey)   #빈도수는 의미 있음
hist(survey)   #등간척도 시각화(히스토그램)
pie(x2)  #빈도수를 이용한 시각화 - 파이 차트

#########비율 척도 기술 통계량
length(data$cost)
summary(data$cost)   #요약 통계 - 의미 있음

plot(data$cost)   # 이상치 발견
data <- subset(data, data$cost >=2 & data$cost <= 10)
x3<-data$cost
mean(x3)
median(x3)  #평균이 극단치에 영향을 받는 경우 중위수로 대체하는 것이 더 효과적입니다.

#A반 성적 = 75,80,80,80,85    평균=80 중위수=80
#B반 성적 = 75,75,75,75,100   평균=80 중위수=75

quantile(x3, 1/4)  # 1사분위수
quantile(x3, 2/4)  #중앙값과 동일
quantile(x3, 3/4)   #
quantile(x3, 4/4)

#최빈수 - 빈도수가 가장 많은 변량  
x3.t <- table(x3)   #빈도수
max(table(x3) )

x3.m <- rbind(x3.t)
x3.m

class(x3.m)
str(x3.m)
x3.df <- as.data.frame(x3.m)
which(x3.df[1,]==18)
x3.df[1, 19]
names(x3.df[19])

##############산포도는 분산과 표준편차를 통계량으로 사용


#########산포도는 분산과 표준편차를 통계량으로 사용




##########비율척도의 빈도 분석 : 비율척도를 범주화 (리코딩)
table(data$cost)
hist(data$cost)
plot(data$cost)

#연속형  변수 범주화
data$cost2[data$cost >= 1 & data$cost<=3] <-1
data$cost2[data$cost >= 4 & data$cost<=6] <-2
data$cost2[data$cost >= 7 ] <-3

table(data$cost2)
barplot(table(data$cost2))
pie(table(data$cost2))


##########정규 분포를 갖는지 확인 - 왜도, 첨도 
install.packages("moments" )   #moments 패키지
library(moments)
cost <- data$cost
result <- cost[!is.na(cost)]
result
skewness(result)  #왜도 반환  0보다 크면  , 0보다 작으면 ....
kurtosis(result)   #첨도 반환 (정규분포의 첨도는 3)
hist(result)
hist(result, freq=F) #히스토그램의 계급을 확률 밀도로 표현
lines(density(result), col='blue')  #cost의 밀도 분포 곡선
x<-seq(0, 8, 0.1)   #0~8범위의 0.1씩 증가하는 데이터 벡터 생성
curve(dnorm(x, mean(result), sd(result)), col='red', add=T)  #정규분포 확률 밀도


#######attach()/detach() 함수 
#리스트객체$key, dataframe객체$컬럼변수
#attach()함수는 dataframe객체$컬럼변수로부터  dataframe객체 데이터셋 이름을 생략하고 컬럼변수만으로 관측치에 사용가능
#detach()함수는  dataframe객체$컬럼변수로 관측치에 접근

data <- read.csv("./data/Part-3/descriptive.csv", header=TRUE)
data$survey
data$cost
attach(data)   # '데이터셋$' 생략할 수 있도록 설정
length(cost)   # na.rm옵션
summary(cost)
mean(cost, na.rm=T) 
min(cost, na.rm=T)
range(cost, na.rm=T)
sort(cost, decreasing=T)
detach(data)    # '데이터셋$' 생략할 수 없도록 설정, attach() 해제
length(pass)   #오류?
length(data$pass)


#########Hmisc 패키지
install.packages("Hmisc")
library(Hmisc)
describe(data)

#########prettyR 패키지
install.packages("prettyR")
library(prettyR)
freq(data)


# quiz> 거주지역 변수 리코딩 후 비율 계산
# 범주화 : 1은 특별시, 2~4 광역시, 5는 시군구 
# 빈도수, 비율, 백분율
View(data)
table(data$resident)
hist(data$resident)
plot(data$resident)

#연속형 변수 범주화
data$resident2[data$resident ==1] <- 1
data$resident2[data$resident >=2 & data$resident<=4] <- 2
data$resident2[data$resident ==5 ] <- 3

table(data$resident2)
barplot(table(data$resident2))
pie(table(data$resident2))
freq(data$resident2)

# quiz> 성별 변수 리코딩 후 비율 계산
# 범주화 : 1은 남자, 2는 여자 
# 빈도수, 비율, 백분율
data$gender2[data$gender == 1] <- 1
data$gender2[data$gender == 2] <- 2
freq(data$gender2)

# quiz> 나이 변수 리코딩 후 비율 계산
# 범주화 : <=45 중년층, 46~59 장년층, >=60 노년층 
# 빈도수, 비율, 백분율
data$age2[data$age <= 45] <- 1
data$age2[data$age >=46 & data$age <= 59] <- 2
data$age2[data$age >=60 ] <- 3
freq(data$age2)

# quiz> 학력 변수 리코딩 후 비율 계산
# 빈도수, 비율, 백분율
data$level2[data$level == 1] <- 1
data$level2[data$level == 2] <- 2
data$level2[data$level == 3] <- 3
freq(data$level2)


###########################샘플 추출###########################
# 벡터 데이터 1~10 로부터 5개 샘플 추출 복원 추출
sample(1:10, 5, replace=TRUE)

# 벡터 데이터 1~10 로부터 5개 샘플 추출 비복원 추출
sample(1:10, 5)

install.packages("sampling")
library(sampling)
head(iris)
result <- strata(c("Species"), size=c(3,3,3) , method="srswor", data=iris)
# srswor : 비복원 단순 임의 추출
# srswr : 복원 단순 임의 추출
# poisson : 포아송 추출
# systematic : 계통 추출

result
getdata(iris, result)

#계통추출 
install.packages("doBy")
library(doBy)
x <- data.frame(x=1:10)
sampleBy(~1, frac=.3, data=x, systematic=TRUE)



# 분할표
table(c("a", "b", "b", "b", "c", "c", "d"))
d <- data.frame(x=c("1", "2", "2", "1"),  y=c("A", "B", "A", "B"),   num=c(3, 5, 8, 7))
(xtabs(num ~ x + y, data=d))
(d2 <- data.frame(x=c("A", "A", "A", "B", "B")))
#각 관찰 결과가 서로 다른 행으로 표현되어 있다면 ‘~ 변수 + 변수 …’ 형태로 포뮬러를 작성한다
(xtabs(~ x, d2))


d <- data.frame(x=c("1", "2", "2", "1"),  y=c("A", "B", "A", "B"),   num=c(3, 5, 8, 7))
xt <- xtabs(num ~ x + y, data=d)   #분할표 생성
xt
margin.table(xt, 1)  # 3 + 7 = 10, 8 + 5 = 13
margin.table(xt, 2)  # 3 + 8 = 11, 7 + 5 = 12
margin.table(xt)     # 3 + 7 + 8 + 5 = 23

prop.table(xt, 1)  #  3/10, 7/10
prop.table(xt, 2)  #  3/11, 7/12
prop.table(xt)     #  3/23, 7/23



#교차분석을 위한 변수 모델링#############################
data <- read.csv("./data/Part-3/cleanDescriptive.csv",header = TRUE)
data
str(data)

#부모의 학력수준이 자녀의 대학진학 여부와 관련이 있는지를 분석하기 위해
#학력수준 변수는 독립변수(영향을 주는) 
#대학진학 여부는 종속변수(영향을 받는)
x<- data$level2
y<- data$pass2
result <- data.frame(Level=x,Pass=y)
dim(result)

#교차분석을 위한 분할표 생성
table(result)

install.packages("gmodels")
library(gmodels)
library(ggplot2)
CrossTable(x=result$Level,y=result$Pass)

head(diamonds)
CrossTable(x=diamonds$color,y=diamonds$cut)



##############################################################
#부모의 학력수준과 자녀의 진학여부와 관련성이 있는지 독립성 검정
##############################################################
#연구가설(H1) :  부모의 학력수준과 자녀의 진학여부와 관련성 있다
#귀무가설(H0) : 부모의 학력수준과 자녀의 진학여부와 관련성이 없다

str(data)

#부모의 학력수준이 자녀의 대학진학 여부와 관련이 있는지를 분석하기 위해
#학력수준 변수는 독립변수
#대학진학 여부 변수는 종속변수
x<- data$level2  
y<- data$pass2

result <- data.frame(Level=x, Pass=y)
CrossTable(x=result$Level, y=result$Pass)

chisq.test(x=result$Level, y=result$Pass)
#해석 :   유의확률(p-value) 0.2507 이 유의수준(α= 0.05) 보다 크므로 귀무가설 채택
#부모의 학력수준과 자녀의 진학여부와 관련성이 없다
#카이제곱 검정통계량 : 2.767, 자유도 : 2
#임계값 : 5.99, 기각값(X^2 >= 5.99) 이면 귀무가설을 기각할 수 있다  
#X^2= 2.767 < 5.99 이므로 귀무가설을 기각 할 수 없다


########### 선호도 검정 : 일원 카이제곱 검정, 한 개의 변인(집단 또는 범주)를 대상으로 검정을 수행, 관찰도수가 기대도수와 일치하는지를 검정###################
#귀무가설 : 기대치와 관찰치는 차이가 없다   예) 스포츠음료에 대한 선호도에 차이가 없다
#대립가설 : 기대치와 관찰치는 차이가 있다.  예) 스포츠음료에 대한 선호도에 차이가 있다
data <- textConnection("스포츠음료종류   관측도수
                     1  41
                     2  30
                     3  51
                     4  71
                     5  61")
x <- read.table(data, header=T)
x
str(x)
chisq.test(x$관측도수)


#해석 : 유의확률(p-value)  0.0003999 이 유의수준(α= 0.05) 보다 작으므로 귀무가설을 기각할 수 있다
#연구가설 채택 됨 (스포츠음료에 대한 선호도에 차이가 있다)
#카이제곱검정통계량 20.88 > 9.49 귀무가설을 기각할 수 있다


##############동질성 검정 : 이원 카이제곱검정 방법, 두 집단의 분포가 동일한지 여부 검정############################
data <- read.csv("./data/Part-3/homogenity.csv", header=TRUE)
head(data)
str(data)
#method 방법 1, 2, 3
#survey 만족도  1:매우만족 ~ 5:매우 불만족

#대립가설 : 교육방법에 따라서 만족도의 차이가 있다.
#귀무가설 : 교육방법에 따라서 만족도의 차이가 없다.

data<- subset(data,!is.na(survey),c(method,survey))

data$method2[data$method==1] <- "방법1"
data$method2[data$method==2] <- "방법2"
data$method2[data$method==3] <- "방법3"

data$survey2[data$survey==1] <- "매우만족"
data$survey2[data$survey==2] <- "만족"
data$survey2[data$survey==3] <- "보통"
data$survey2[data$survey==4] <- "불만족"
data$survey2[data$survey==5] <- "매우불만족"

table(data$method2, data$survey2) #table(행,열)
# 방법 1,2,3 의 관측치의 개수는 50으로 동일 > 반드시 각 집단의 
# 길이가 동일해야 한다.

#동질성 검정
chisq.test(data$method2,data$survey2)

#해석 : 유의확률(p-value)  0.5865 이 유의수준(α= 0.05) 보다 크므로 귀무가설을 기각할 수 없다
#귀무가설 채택 됨 (교육방법에 따라서 만족도의 차이가 없다)
#카이제곱검정통계량 15.51 > 6.5447 귀무가설을 기각할 수 없다




#######################실습 연습문제#######################

#Quiz01> 교육수준(education)과 흡연율(smoking) 간의 관련성을 
#분석하기 위한 연구가설을 수립하고, 각 단계별로 가설을 검정하시오. 
#[독립성 검정]
#귀무가설(H0) : 교육수준과 흡연율의 관계성 없다.
#연구가설(H1) : 교육수준과 흡연율의 관계성 있다.
  
smoke <- read.csv("./data/Part-3/smoke.csv", header=TRUE)
head(smoke)
#education : 1:대졸, 2:고졸, 3:중졸
#smoking : 1:과다흡연, 2:보통흡연, 3:비흡연

#흡연율 변수는 종속변수
x<- smoke$education
y<- smoke$smoking

result <- data.frame(education=x, smoking=y)
CrossTable(x=result$education, y=result$smoking)

#이원카이제곱 검정
chisq.test(x=result$education, y=result$smoking)

#해석 : 유의확률(p-value) 0.0008183 이 유의수준(α= 0.05) 보다 작으므로
#귀무가설 기각 => 교육수준과 흡연율의 관계성 있다.

#카이제곱 검정통계량 : 18.911, 자유도 : 4
#임계값 : 9.49, 기각값(X^2 >= 9.49) 이면 귀무가설을 기각할 수 있다  
#X^2= 18.911 > 9.49 이므로 귀무가설을 기각 할 수 있다.

#####################################################################
#Quiz02> 나이(age3)와 직위(position) 간의 관련성을 단계별로 
# 분석하시오. [독립성 검정]
#귀무가설(H0) : 나이와 직위 간 관계성 없다.
#연구가설(H1) : 나이와 직위 간 관계성 있다.
#age3 : 1-청년층, 2-중년층, 3-장년층 
#position : 1~5
data <- read.csv("./data/Part-3/cleanData.csv", header=TRUE)
head(data)

#나이 변수는 종속변수
x<- data$age3
y<- data$position

result <- data.frame(age=x, position=y)
CrossTable(x=result$age, y=result$position)

#이원카이제곱 검정
chisq.test(x=result$age, y=result$position)

#해석 : 유의확률(p-value) < 2.2e-16 이 유의수준(α= 0.05) 보다 작으므로
#귀무가설 기각 => 나이와 직위 간 관계성 있다.

#카이제곱 검정통계량 : 287.9, 자유도 : 8
#임계값 : 15.51, 기각값(X^2 >= 15.51) 이면 귀무가설을 기각할 수 있다  
#X^2= 287.9 > 15.51 이므로 귀무가설을 기각 할 수 있다.

############################################################
#Quiz03> 직업유형에 따른 응답정도에 차이가 있는가를
# 단계별로 검정하시오.[동질성 검정]
#귀무가설(H0) : 직업유형에 따른 응답정도에 차이가 없다.
#연구가설(H1) : 직업유형에 따른 응답정도에 차이가 있다.
#job : 1:학생, 2:직장인, 3:주부
#response : 1:무응답, 2:낮음, 3:높음

response <- read.csv("./data/Part-3/response.csv", header=TRUE)
head(response) 

response$job2[response$job==1] <- "학생"
response$job2[response$job==2] <- "직장인"
response$job2[response$job==3] <- "주부"

response$response2[response$response==1] <- "무응답"
response$response2[response$response==2] <- "낮음"
response$response2[response$response==3] <- "높음"


table(response$job2, response$response2)  #table(행, 열)
# 직업1,2,3 의 관측치의 개수는 50으로 동일 => 반드시 각 집단의 길이가 동일해야 합니다.

#동질성 검정
chisq.test(response$job2, response$response2)

#해석 :  유의확률(p-value) 6.901e-12 이 유의수준(α= 0.05) 보다 작으므로 
# 귀무가설을 기각
#귀무가설 기각 됨 (직업유형에 따른 응답정도에 차이가 있다)
#카이제곱검정통계량 58.208 > 9.49 귀무가설을 기각할 수 있다
############################################################

#피셔의 정확 검정
# 표본 수가 적거나 표본이 분할표의 셀에 매우 치우치게
# 분포되어 있다면 카이 제곱 검정의 결과가 부정확할 수 있다. 
#fisher.test(
#  x,      # 행렬 형태의 이차원 분할표 또는 팩터
#  y=NULL, # 팩터. x가 행렬이면 무시된다.
#  alternative="two.sided" # 대립가설로 two.sided는 양측 검정, less는 작다, greater는 크다를 의미
#)

#연구가설(H1) : 글씨를 쓰는 손이 박수 칠때 위로 가는지 관련이 있다. (독립이 아니다)
#귀무가설(H0) : 글씨를 쓰는 손이 박수 칠때 위로 가는지 관련이 없다. (독립이다)

#MASS::survey 데이터에서 손 글씨를 어느 손으로 쓰는지와 박수를 칠 때 어느 손이 위로 가는지 사이의 경우에 대해 피셔의 정확 검정을 수행

library(MASS)
xtabs(~ W.Hnd + Clap, data=survey)
chisq.test(xtabs(~ W.Hnd + Clap, data=survey))
fisher.test(xtabs(~ W.Hnd + Clap, data=survey))

###########################################################
#맥니마 검정
# 사건 전후에 어떻게 달라지는지를 알아보는 경우
# ex) 벌금을 부과하기 시작한 후 안전벨트 착용자의 수 변화 있나?
# ex) 선거 유세를 하고 난 뒤 지지율 변화 

#투표권이 있는 나이의 미국인 1,600명에 대해 대통령 지지율을 조사
#1차 조사1st Survey와 2차 조사2nd Survey는 한 달 간격으로 수행
#귀무가설 : 유세 전후의 지지율에 변화가 없다.
#대립가설 : 유세 전후의 지지율에 변화가 있다.
Performance <- matrix(c(794,86,150,570),nrow = 2,
                      dimnames = list(
                        "1st Survey" = c("Approve","Disapprove"),
                        "2nd Survey" = c("Approve","Disapprove")))
Performance
mcnemar.test(Performance)
# 유세 전후의 지지율에 변화가 있다.
###########################################################

