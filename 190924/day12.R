#############분석자가 군집수를 설정(자르기)##################
#stats::cutree(계층형 군집분석결과, k=군집수)
library(stats)
library(cluster)
idist<-dist(iris[1:4])
hc<-hclust(idist)  # 계층형 군집분석
plot(hc, hang=-1)
rect.hclust(hc, k=4,  border="red")

#군집분석 결과를 대상으로 3개의 군집수를 지정 
ghc <- cutree(hc, k=3)
ghc   #군집을 의미하는 1~3의 숫자로 출력

iris$ghc <- ghc
table(iris$ghc)   # 군집수의 빈도수

#각 군집별로 내적 특성, 다른 군집과의 차이에 해당하는 외적 특성 확인
g1<-subset(iris, ghc==1)
summary(g1[1:4])

g2<-subset(iris, ghc==2)
summary(g2[1:4])

g3<-subset(iris, ghc==3)
summary(g3[1:4])


#############군집분석 : 최단연결법(Single Linkage Method)##########
#군집에 속하는 두 개체(데이터) 사이의 최단 거리를 이용
#가장 유사성이 큰 개체들을 군집으로 묶어 나가는 방법
#빠르고, 자료에 대한 단조변환에 대하여 Tree구조가 불변하기 때문에 
#순서적 의미를 갖는 자료에 대해서 좋은 결과를 제공함
#최단연결법(Single Linkage Method)은 고립된 군집을 찾는데 유용

a<-c(1, 5)
b<-c(2, 3)
c<-c(5, 7)
d<-c(3, 5)
e<-c(5, 2)
data <- data.frame(a, b, c,d, e)
data
data<-t(data)
data
m1<-hclust(dist(data)^2, method="single")
plot(m1)


#### 최장연결법(Complete Linkage Method)###
#군집들의 응집성을 찾는데 유용

m2<-hclust(dist(data)^2, method="complete")
plot(m2)


######## 와드연결법(Ward's  Method)#######
#새로운 군집으로 인하여 파생되는 ESS(오차 제곱의 합)의 증가량을
#두 군집 사이의 거리로 정의하여 가장 유사성이 큰 개체들을 군집으로 묶어 가는 방법

m3<-hclust(dist(data)^2, method="ward.D2")
plot(m3)

############평균 연결법(Average Linkage Method) ###########
#두 군집 사이의 거리를 각 군집에 속하는 모든 개체들의 평균거리로 정 
#가장 유사성이 큰 개체들을 군집으로 묶어 가는 방법
m4<-hclust(dist(data)^2,method="average")
plot(m4)



##############비계층적 군집 분석 #######################
library(ggplot2)
data(diamonds)
t <- sample(1:nrow(diamonds), 1000)
test <- diamonds[t, ]   #표본으로 검정 데이터 생성
names(test)

data<- test[c("price", "carat", "depth", "table")]
head(data)

#계층적 군집분석
result <- hclust(dist(data), method="ave")
result
plot(result, hang=-1)

#3개의 군집수를 적용하여 비계층적 군집분석 수행
result2 <- kmeans(data, 3)  
names(result2)
result2$cluster #각 개체가 속하는 군집수 확인

data$cluster <- result2$cluster

#price에 가장 큰 영향을 주는 변수들 확인
cor(data[, -5], method="pearson")
plot(data[, -5])  #변수간의 상관계수 보기


library(corrgram)  #상관계수를 색상으로 시각화
corrgram(data[, -5], upper.panle=panel.conf) #상관계수 수치 추가

#비계층분석 결과 price에 가장 영향을 주는 ..군집수 2의 시각화
plot(data$carat, data$price, col=data)#cluster
     #중심점 추가
     points(result2$centers[, c("carat", "price")], col=c(3,1,2),
            pch=8, cex=5)
     


########iris 데이터셋 비계층적 군집 분석 ##########
data<-iris
data$Species <- NULL
head(data)
m<-kmeans(data,3)     

table(iris$Species, m$cluster)     
plot(data[c("Sepal.Length","Sepal.Width")],main="kmeans",col=m$cluster)
m2<-kmeans(data, 4)
m2

table(iris$Species, m2$cluster)
plot(data[c("Sepal.Length","Sepal.Width")],main="kmeans",col=m2$cluster)



#############트랜잭션 객체를 대상으로 연관규칙 생성##############
#arules::read.transactions(), apriori()
install.packages("arules")
library(arules)
tran <- read.transactions("./data/tran.txt", format="basket",sep=",")
#거래 data는 6개
inspect(tran)   #항목(품목) 확인

rule <- apriori(tran, parameter=list(supp=0.3, conf=0.1))  #규칙 16
#맥주를 구매한 사람은 대체로 고기를 사지 않는다
#{라면, 맥주} => {우유}는 향상도가 1.2이므로 두 상품간의 상관성이 높습니다.
rule2 <- apriori(tran, parameter=list(supp=0.1, conf=0.1))  #규칙 32

stran <- read.transactions("./data/demo_single", format="single", cols=c(1,2))
inspect(stran)


stran2 <- read.transactions("./data/single_format.csv", format="single", sep=",", cols=c(1,2), rm.duplicates=T)
stran2      #트랜잭션 248, 항목은 68
summary(stran2)

#규칙 생성 (연관규칙 생성을 위한 평가척도 기본값 supp=0.1, conf=0.8)
astran2 <- apriori(stran2)   # 102 rules

#규칙 확인
inspect(astran2)

#상위 5개만 향상도 기준 내림차순)
inspect(head(sort(astran2, by="lift" ), 5))


##### 연관규칙 생성, 네트워크 형태로 시각화######
data(Adult) 
str(Adult)   #성인 대상 인구 소득에 관한 설문 조사 데이터
# AdultUCI 데이터셋을 트랜잭션 객체로 변환한 데이터셋
#transaction 48842, item 15개
#종속변수(Class)에 의해서 연간 개입 수입이 $5만 이상인지를 예측하

attributes(Adult) #transaction의 변수와 범주
names(AdultUCI) #15개의 변수(컬럼)명

adult <- as(Adult, "data.frame") 
head(adult)
str(adult)
summary(adult)

ar <- apriori(Adult, parameter=list(supp=0.1,conf=0.8)) #rules는 6137개

ar2 <- apriori(Adult, parameter=list(supp=0.3,conf=0.95)) #rules는 124개

ar3 <- apriori(Adult, parameter=list(supp=0.35,conf=0.95)) #rules는 67개

ar4 <- apriori(Adult, parameter=list(supp=0.4,conf=0.95)) #rules는 36개

#상위 6개 규칙
inspect(head(ar4))

#신뢰도 기준 내림차순 정렬 상위 6개
inspect(head(sort(ar4,decreasing = T,by="confidence")))

#향상도 기준 내림차순 정렬 상위 6개
inspect(head(sort(ar4,decreasing = T,by="lift")))

install.packages("arulesViz")
library(arulesViz)

plot(ar3,method="graph",control=list(type="items"))
#5만 달러 이상의 연봉 수령자와 관련된 연관어:

plot(ar4,method="graph",control=list(type="items"))
#5만 달러 이상의 연봉 수령자와 관련된 연관어:
#주당근무시간 형태는 full-time,인종은 백인,국가는 미국,자본손실 무
#직업은 자영업,나이는 중년,결혼여부 기혼

##############Groceries 데이터셋 연관분석 ###############
data("Groceries")
str(Groceries)
Groceries
#1개월 동안 실제 로컬 식품점 매장에서 판매되는 트랜잭션 데이터
#transaction은 9835/item은 169
Groceries_df <- as(Groceries,"data.frame")

rules <- apriori(Groceries, parameter=list(supp=0.001,conf=0.8)) #rules 410개
rules2 <- apriori(Groceries, parameter=list(supp=0.002,conf=0.8)) #rules 11개
inspect(rules)

plot(rules2, method="grouped")


##############Groceries 데이터 셋 연관분석################
data("Groceries")
str(Groceries)
Groceries
#1개월동안 실제 로컬 식품점 매장에서 판매되는 트랜잭션 데이터
#transaction은 9835, item은 169
Groceries_df <- as(Groceries, "data.frame")

rules <- apriori(Groceries, parameter= list(supp=0.001 , conf=0.8))  # rules 410
inspect(rules)
plot(rules, method="grouped")
#빈도수가 가장 높은 상품 순서대로 2개

rules2 <- apriori(Groceries, parameter= list(supp=0.002 , conf=0.8))  # rules 11
inspect(rules2)
plot(rules2, method="grouped")

#빈도수가 가장 높은 상품

#규칙이 A상품 -> B상품 형태로 표현 : 왼쪽에있는 LHS,오른쪽 RHS

#최대길이 (Lhs+Rhs) 3이하 규칙 생성
rules <- sort(rules,decreasing = T,by="confidence")
inspect(rules)

rules <- sort(rules, descreasing=T, by="confidence")
inspect(rules)
plot(rules, method="graph", control=list(type="items"))


##########특정 상품 서브셋 생성하여 시각화하기 ############
wmilk <- subset(rules, rhs %in% 'whole milk')
wmilk 
inspect(wmilk)
plot(wmilk, method="graph")

aveg <- subset(rules, rhs %in% 'other vegetables')
aveg
inspect(aveg)
plot(aveg, method="graph")



################장바구니 연관분석 연습문제 1 ################
#연관성 규칙은 상품 호은 서비스 간의 관계를 살펴보고 이로부터 유용한 규칙을 찾아내고자 할 때 이용될 수 있는 기법이다.
#데이터들의 빈도수와 동시발생 확률을 이용하여 한 항목들의 그룹과 다른 항목들의 그룹 사이에 강한 연관성이 있음을 밝혀주는 기법이다.
#예제 데이터 : B 마트에서 판매된 트랜잭션 데이터 파일
#mybasket.csv
#변수 : 의류, 냉동식품, 주류, 야채, 제과, 육류, 과자, 생활장식, 우유
#분석문제 :
#1. 전체 트랜잭션 개수와 상품아이템 유형은 몇개인가?
#2. 가장  발생빈도가 높은 상품아이템은 무엇인가?
#3. 지지도를 10%로 설정했을 때의 생성되는 규칙의 가짓수는?
#4. 상품 아이템 중에서 가장 발생확률이 높은 아이템과 낮은 아이템은 무엇인가?
#5. 가장 발생가능성이 높은 <2개 상품간>의 연관규칙은 무엇인가?
#6. 가장 발생가능성이 높은 <2개 상품이상에서> <제 3의 상품으로>의 연관규칙은 무엇인가?

result <- read.transactions("./data/mybasket.csv", format="basket", sep=",")
result #1. 786 transactions #10items
summary(result) #2. clothes 386
image(result)
data <- as(result, "data.frame")
rules <- apriori(result, parameter=list(supp=0.1, conf=0.1)) #3. 127 rules
inspect(rules) #4. clothes 0.49 / milk 0.18
#5. clothes > bakery / bakery > clothes 0.25
#6. deco,frozen > bakery / bakery,frozen > deco 0.1488550

library(arulesViz)
plot(rules)
plot(rules, method="grouped")  #lhs가로축 조건과 rhs세로축-결과로 구성한 메트릭스 그래프
plot(rules, method="graph", control=list(type="items"))
plot(rules, method="graph", interactive=TRUE , control=list(type="items"))



############## Twitter SNS 연관어 분석 단계 #######################
install.packages("twitteR")
install.packages("ROAuth")
install.packages("base64enc")
library(twitteR)
library(ROAuth)
library(base64enc)
require(RCurl)
#  Twitter 앱 요청 URL과 API 설정
# [Details] - 3개 url 변수 생성
reqURL <- "https://api.twitter.com/oauth/request_token"
authURL <- "https://api.twitter.com/oauth/authorize"
accessURL <- "https://api.twitter.com/oauth/access_token"

# [Keys and Access Tokens] - 4개 변수 : ##Site에서 받아온다.
apiKey <-  "myapikey-xxxxxxxxx" 
apiSecret <- "xxxxxxxxxxxxxxxx" 
accessToken="xxxxxxxxxxxxxxxxx"
accessTokenSecret="xxxxxxxxxxxxxxxxxxxxxxxxxx"

# Twitter 앱 인증 요청
twitCred <- OAuthFactory$new(
  consumerKey = apiKey, 
  consumerSecret = apiSecret,
  requestURL = reqURL,
  accessURL = accessURL, 
  authURL = authURL
)

# Twitter 앱 인증 수행
twitCred$handshake(
  cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")
)

# Twitter 앱 인증을 위한 PIN 받기
setup_twitter_oauth(apiKey, 
                    apiSecret,
                    accessToken,
                    accessTokenSecret)


# 함수 실행 -> 선택: 1(1: Yes)


##Twitter 앱에 접근하여 데이터 가져오기

# 단계 1 : 검색어 입력과 검색 결과 받기 
keyword <- enc2utf8("빅데이터") # UTF-8 인코딩 방식 지정 - base 패키지 
test <- searchTwitter(keyword, n=300) # twitteR 패키지 제공 
test
class(test) # [1] "list"

# 단계 2 :  list 자료구조를 vector 자료구조로 변경
test_vec <- vector() # vector 객체 생성 
n <- 1: length(test)

for(i in n){
  test_vec[i] <- test[[i]]$getText()
}
test_vec

# data type과 구조보기 
class(test_vec); str(test_vec)

#파일 저장 및 가져오기
write.csv(test_vec, "c:/Rwork/output/test.txt", quote = FALSE, row.names = FALSE)
test_txt <- file("C:/Rwork/output/test.txt")
twitter <- readLines(test_txt)
str(twitter)


## Twitter 검색 데이터 대상 연관어 분석

# 단계 1 : 한글 처리를 위한 패키지 설치
library(rJava) # 아래와 같은 Error 발생 시 Sys.setenv()함수로 java 경로 지정
library(KoNLP) # rJava 라이브러리가 필요함

# 단계 2 :  줄 단위 단어 추출
lword <- Map(extractNoun, twitter) 
length(lword) 
lword <- unique(lword) # 중복제거1(전체 대상)
length(lword) 
lword <- sapply(lword, unique) # 중복제거2(줄 단위 대상) 
length(lword) 
lword # 추출 단어 확인

# 단계 3 :  데이터 전처리
# (1) 길이가 2~4 사이의 단어 필터링 함수 정의
filter1 <- function(x){
  nchar(x) <= 4 && nchar(x) >= 2 && is.hangul(x)
}
# (2) Filter(f,x) -> filter1() 함수를 적용하여 x 벡터 단위 필터링 
filter2 <- function(x){
  Filter(filter1, x)
}

# (3) 줄 단어 대상 필터링
lword <- sapply(lword, filter2)
lword # 추출 단어 확인(길이 1개 단어 삭제됨)

#  트랜잭션 생성 : 연관분석을 위해서 단어를 트랜잭션으로 변환
library(arules) 
wordtran <- as(lword, "transactions") # lword에 중복데이터가 있으면 error발생
wordtran 
inspect(wordtran)  # 트랜잭션 내용 보기

# 단어 간 연관규칙 산출
tranrules <- apriori(wordtran, parameter=list(supp=0.09, conf=0.8))  # 54 rule(s)
inspect(tranrules) # 연관규칙 생성 결과(23개) 보기

# 연관어 시각화 
# (1) 데이터 구조 변경 : 연관규칙 결과 -> 행렬구조 변경(matrix 또는 data.frame) 
rules <- labels(tranrules, ruleSep=" ") # 연관규칙 레이블을 " "으로 구분하여 변경   
rules # 예) 59 {경영,마케팅}   => {자금} -> 59 "{경영,마케팅} {자금}"
class(rules)

rules <- sapply(rules, strsplit, " ",  USE.NAMES=F) 
rules
class(rules) 

# 행 단위로 묶어서 matrix로 반환
rulemat <- do.call("rbind", rules)
rulemat
class(rulemat)

# (2) 연관어 시각화를 위한 igraph 패키지 설치
library(igraph)   

# (3) edgelist보기 - 연관단어를 정점 형태의 목록 제공 
ruleg <- graph.edgelist(rulemat[c(1:54),], directed=F) 

# (4) edgelist 시각화
X11()
plot.igraph(ruleg, vertex.label=V(ruleg)$name,
            vertex.label.cex=1.0, vertex.label.color='black', 
            vertex.size=20, vertex.color='green', vertex.frame.color='blue')



##########비정상 시계열 자료를 정상성 시계열 자료 변환 ##########
data(AirPassengers)  #12년간 항공기 탑승 승객 수
str(AirPassengers)

#차분을 이용한 평균에 대한 정상화
par(mfrow=c(1,2))
ts.plot(AirPassengers) #시계열 시각화
diff <- diff(AirPassengers) #차분 수행
plot(diff) #평균 정상화

#로그를 이용한 분산에 대한 정상화
par(mfrow=c(1,2))
plot(AirPassengers)
log <- diff(log(AirPassengers)) #로그 + 차분
plot(log)

##########시계열 자료로부터 추세선 시각화##################
data("WWWusage") #인터넷 사용시간을 분 단위로 측정
str(WWWusage) #측정치 : 100,자료구조 형태 : 벡터 

ts.plot(WWWusage, type="l", col="red") #가로축:t, 세로:시계열

#다중 시계열 자료의 추세선 시각화 
data("EuStockMarkets") #유럽 주요 국가 주식의 주가지수 일일 마감 가격
str(EuStockMarkets)
EuStock <- data.frame(EuStockMarkets)
X11()
plot(EuStock$DAX[1:1000],type="l",col="red")
plot(EuStock$DAX[1:1000],EuStock$SMI[1:1000],main="주가지수 추세선")





















