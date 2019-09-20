###########요인분석 결과 요인 점수를 이용한 요인 적재량 시각화 ##########
# 6개 과목 (s1~s6) 
# 점수벡터 (5점 만점, 척도:5)
s1 <- c(1, 2, 1, 2, 3, 4, 2, 3, 4, 5)  #자연과학
s2 <- c(1, 3, 1, 2, 3, 4, 2, 4, 3, 4)  # 물리화학
s3 <- c(2, 3, 2, 3, 2, 3, 5, 3, 4, 2)  #인문사회
s4 <- c(2, 4, 2, 3, 2, 3, 5, 3, 4, 1)  # 신문방송
s5 <- c(4, 5, 4, 5, 2, 1, 5, 2, 4, 3)  #응용수학
s6 <- c(4, 3, 4, 4, 2, 1, 5, 2, 4, 2)  # 추론통계
name <-1:10  #각 과목의 문제 이름

#데이터 프레임 생성
subject <- data.frame(s1, s2, s3, s4, s5, s6)
str(subject)
result <- factanal(subject, factors=3, rotation="varimax" , scores="regression")
result
plot(result$scores[, c(1:2)], main="Factor1과 Factor2의 요인점수 행렬")
text(result$scores[, 1], result$scores[, 2], labels=name, cex=0.7, pos=3, col="red")
points(result$loadings[, c(1:2)], pch=19, col="blue")
text(result$loadings[, 1], result$loadings[, 2], labels=rownames(result$loadings), cex=0.8, pos=3, col="blue")

install.packages("scatterplot3d")
library(scatterplot3d)

#요인 점수별 분류
Factor1 <- result$scores[,1]
Factor2 <- result$scores[,2]
Factor3 <- result$scores[,3]

#scatterplot3d(밑변, 오른쪽변, 왼쪽변, type)
d3 <- scatterplot3d(Factor1,Factor2,Factor3,type='p')

#요인 적재량 표시
loadings1 <- result$loadings[,1]
loadings2 <- result$loadings[,2]
loadings3 <- result$loadings[,3]
d3$points3d(loadings1,loadings2,loadings3,bg="red",pch=21,cex=2, type='h')


########요인 분석 결과를 이용하여  변수 묶기->  상관분석이나 회귀분석에서 독립변수로 사용할 수 있는 파생변수 생성 ####################
#Factor1은 응용과학
#Factor2은 응용수학
#Factor3은 자연과학

app <- data.frame(subject$s5, subject$s6)
soc <- data.frame(subject$s3, subject$s4)
net <- data.frame(subject$s1, subject$s2)

#산술평균을 계산하여 요인별 파생변수 생성
app_science <- round((app$subject.s5 + app$subject.s6)/ncol(app), 2)
soc_science <- round((soc$subject.s3 + soc$subject.s4)/ncol(soc), 2)
net_science <- round((net$subject.s1 + net$subject.s2)/ncol(net), 2)

#상관관계 생성
subject_factor_df <- data.frame(app_science,soc_science,net_science)
cor(subject_factor_df)
#해석 > '응용과학' 기분으로 '사회과학'은 양의 상관성을 나타내고, '자연과학'은 음의 상관성을 나타내고
#'사회과학'과 '자연과학'은 상관성이 없음을 나타냄


################잘못 분류된 요인 제거로 변수 정제 #################
#음료수 제품의 11개의 변수 (친밀도, 적절성, 만족도 3가지 영역)
# 특정 변수가 묶일 것으로 예상되는 요인이 묶이지 않는 경우, 해당 변수를 제거하는 정제 작업이 필요합니다.
install.packages("memisc")
library(memisc)
data.spss <- as.data.set(spss.system.file("./data/Part-3/drinking_water.sav"))
data.spss 
# 제품 친밀도 (q1 : 브랜드, q2:친근감, q3:익숙함, q4:편안함)
# 제품 적절성 (q5 : 가격적절성, q6:당도적절성, q7:성분적절성)
# 제품 만족도 (q8 : 음료의 목넘김, q9:맛, q10:향 ,q11:가격)

drinking_water <- data.spss[1:11]
drinking_water_df <- as.data.frame(drinking_water[1:11])
str(drinking_water_df)

#요인분석
result <- factanal(drinking_water_df, factors=3, rotation="varimax")

#Uniqieness는 11개 변수가 0.5 이하의 값이면 모두 유효하다고 볼 수 있다.
#loadings : Factor1(q8~11), Factor2(q1~3), Factor3(q4~7)
#p-value는 0.0255로 유의수준 0.05보다 작기 때문에 요인수 선택에 문제가 있다고 볼 수 있다.
#(p-value는 chi_square 검정의 결과로서 기대치와 관찰지에 차이가 있음을 알려주는 확률값)

dw_df <- drinking_water_df[-4]
str(dw_df)

s <- data.frame(dw_df$q8, dw_df$q9, dw_df$q10, dw_df$q11) #만족도
c <- data.frame(dw_df$q1, dw_df$q2, dw_df$q3) #친밀도
p <- data.frame(dw_df$q5, dw_df$q6, dw_df$q7) #적절성 

satisfaction <-round( (dw_df$q8+dw_df$q9+dw_df$q10+dw_df$q11)/ncol(s), 2)
closeness <-round( (dw_df$q1+dw_df$q2+dw_df$q3)/ncol(s), 2)
pertinence <- round( (dw_df$q5+dw_df$q6+dw_df$q7)/ncol(s), 2)

#상관관계 분석
dwf_df <- data.frame(satisfaction,closeness,pertinence)
colnames(dwf_df) <- c("제품 만족도","제품 친밀도", "제품 적절성")
cor(dwf_df)
#해석 > 제품 친밀도와 제품 적절성이 상관관계가 높음


##########상관관계분석 #######################################
result <- read.csv("./data/Part-3/product.csv", header=TRUE)
head(result)
str(result)

summary(result)
sd(result$제품_친밀도); sd(result$제품_적절성); sd(result$제품_만족도)

cor(result$제품_친밀도, result$제품_적절성)
#0.4992086

cor(result$제품_적절성, result$제품_만족도)
#0.7668527

cor(result$제품_친밀도+result$제품_적절성, result$제품_만족도)
#0.7017394

cor(result, method="pearson")

#상관계수에 따라 색의 농도로 시각화
install.packages("corrgram")
library(corrgram)
corrgram(result)

corrgram(result,upper.panel = panel.conf)
corrgram(result,lower.panel = panel.conf)

# 상관성, 밀도곡선, 유의확률 시각화
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
# 상관성, p값(*), 정규분포 시각화
chart.Correlation(result, histogram=, pch="+")

#############회귀분석################## 
product <- read.csv("./data/Part-3/product.csv",header = T)
head(product)
str(product)

y<-product$제품_만족도  #종속변수
x<-product$제품_적절성  #독립변수
df <- data.frame(x, y)

# 단순 선형회귀 모델 생성 lm(y~x, data)
library(stats)
result.lm <- lm(formula=y~x, data=df)
result.lm

# Y=0.7789 +0.7393*X 

# 생성된 선형회귀 모델의 적합값과 잔차 계산
names(result.lm)    #모델 관련 정보 확인
fitted.values(result.lm)[1:2]   #모델의 적합값 확인 3.735963, 2.996687
head(df, 1)   #관측값  x=4, y=3

Y=0.7789 +0.7393*4   #회귀방정식을 적용하여 모델로부터 적합값 계산
Y     #3.7361

#오차는 관측값-적합값
3 - 3.735963     #-0.735963

residuals(result.lm)[1:2]  #-0.7359630, -0.9966869

#관측값 = 잔차(오차)+ 적합값
-0.7359630 + 3.735963    #3

#선형회귀분석 모델 시각화
plot(formula = y ~ x, data=result)
abline(result.lm, col="red")

#선형회귀분석 결과
summary(result.lm)

# Multiple R-squared:  0.5881 는 독립변수에 의해서 종속변수가 얼마만큼 설명되었는가 (회귀모델의 설명력)
# Multiple R-squared 값은 독립변수와 종속변수 간의 상관관계를 나타내는 결정계수
# 설명력이 1에 가까울수록 설명변수(독립변수)가 설명을 잘한다고 판단할 수 있습니다. => 변수의 모델링이 잘 되었다는 의미

#Adjusted R-squared:  0.5865은 오차를 감안하여 조정된 R 값으로 (실제 분석은 이 값을 적용합니다.)

#F-statistic:   374 회귀모델의 적합성을 나타내며    
#p-value: < 2.2e-16 
#F-statistic와 p-value를 이용하여 회귀모델 자체를 신뢰할 수 있는지 판단
#p-value가 0.05보다 매우 작기 때문에 회귀선이 모델에 적합하다고 볼 수 있습니다.

#x            0.73928    0.03823  19.340  < 2e-16 ***
#x변수의 t=19.340 , p-value는 < 2e-16 이므로  p-value가 0.05보다 매우 작기 때문에 "제품의 가격과 품질을 결정하는 제품 적절성은 제품 만족도에 양의 영향을 미친다." 연구가설 



#############다중 회귀 분석#############
product <- read.csv("./data/Part-3/product.csv",header = TRUE)
head(product)
str(product)

y <- product$제품_만족도 #종속변수
x1 <- product$제품_적절성 #독립변수1
x2 <- product$제품_친밀도 #독립변수2
df <- data.frame(x1,x2,y)

#다중회귀분석
result.lm <- lm(formula = y~x1+x2,data=df)
result.lm #절편(0.66731) 과 기울기(x1:0.68522, x2:0.09593) 확인

#다중 공선성문제 확인
install.packages("car")
library(car)

vif(result.lm) #분산팽창요인(VIF) - 결과값이 10 이상인 경우에는 다중 공선성문제를 의심해 볼 수 있다.

#다중 회귀 분석 결과 보기
summary(result.lm)
#Multiple R-squared:  0.5975,    Adjusted R-squared:  0.5945 
#F-statistic: 193.8 on 2 and 261 DF,  p-value: < 2.2e-16
#x1           0.68522    0.04369  15.684  < 2e-16 ***
#x2           0.09593    0.03871   2.478   0.0138 *  

#x1는 제품의 적절성이 제품 만족도에 미치는 영향 t검정통계량 15.684, 
#x2는 제품의 친밀도가 제품 만족도에 미치는 영향 t검정통계량 2.478
#x1, x2의 유의 확률은 0.05보다 작기 때문에 제품 만족도에 양의 영향을 미친다(연구 가설 채택)

#상관계수(결정계수) 0.5975 다소 높은 상관관계를 나타냄, 설명력은 59.45%
#회귀모델의 적합성 f검정통계량 193.8, p-value < 2.2e-16이므로 0.05 보다 매우 낮으므로 회귀모델은 적합하다고 볼 수 있습니다.



##############다중 공선성 문제 해결과 모델 평가###################
#iris의 Sepal.Length(꽃받침 길이)를 종속변수로 지정하고 Sepal.Width, Petal.Length, Petal.Width을 독립변수로 ...

fit <- lm(formula= Sepal.Length ~ Sepal.Width+Petal.Length+Petal.Width, data=iris)
fit

#다중공선성 문제 확인
vif(fit)
#Petal.Length, Petal.Width 변수는 강한 상관관계로 인해서 다중 공선성 문제가 의심된다.

#다중공선성 문제가 의심되는 변수의 상관관계 확인
cor(iris[, -5])

#학습데이터와 검정 데이터를 7:3으로 표본 추출
x <- sample(1:nrow(iris), 0.7*nrow(iris)) #70% 표본 추출
train <- iris[x, ] #학습데이터
test <- iris[-x, ] #검정데이터

#Petal.Width 변수를 제거한 후 학습데이터로부터 회귀모델 생성
model <- lm(formula= Sepal.Length ~ Sepal.Width+Petal.Length, data=iris)
model
summary(model)

#꽃받침의 너비가 꽃받침의 길이에 영향을 미친다
#꽃잎의 길이가 꽃받침의 길이에 영향을 준다

##########검정데이터에 회귀모델 적용 예측값 생성 후 모델 평가 #############
head(train, 1)
#회귀방정식 4.3           3          1.1         0.1
Y=2.2491 + 0.5955*3+ 0.4719*1.1
Y #회귀모델로부터 계산된 예측값 4.55469

#오차 = 예측값 - 관측값 (4.55469-4.3) 0.25469

#stats::predict(model,data)
pred <- predict(model, test)
pred #예측값 생성

#모델 평가는 상관계수를 이용하여 모델의 정확도를 평가합니다.
cor(pred, test$Sepal.Length)
#예측치와 실제 관측치는 상관계수가 0.9077556 이므로 매우 높은 상관관계를 보인다고 할 수 있으며
#모델의 정확도가 아주 높다고 볼 수 있다.




###########요인 분석 연습문제 ##############
#다음은 drinkig_water_example.sav 파일의 데이터 셋이 구성된 테이블이다. 전체 2개의 요
#인에 의해서 7개의 변수로 구성되어 있다. 아래에서 제시된 각 단계에 맞게 요인분석을 수행
#하시오

data <- as.data.set(spss.system.file("./data/Part-3/drinking_water_example.sav"))
data 

drinking_water <- data[1:7]
str(drinking_water_df)

#요인분석(베리멕스회전법, 요인수2)
result <- factanal(drinking_water_df, factors=2, rotation="varimax")
result

#요인별 변수 묶기
dw_df <- drinking_water_df
f1 <- data.frame(dw_df$q1, dw_df$q2, dw_df$q3)  #요인 1001
f2 <- data.frame(dw_df$q4, dw_df$q5, dw_df$q6, dw_df$q7)  #만족도
#요인 1001 (q1:브랜드, q2:친근감, q3: 익숙함)
#제품 만족도 (q4:음료의 목 넘기, q5:음료의 맛, q6:음료의 향 , q7:가격)

#요인별 산술평균 계산

f1_mean <-round( (dw_df$q1+dw_df$q2+dw_df$q3)/ncol(c), 2) #요인 1001
f2_mean <-round( (dw_df$q4+dw_df$q5+dw_df$q6+dw_df$q7)/ncol(p), 2) #만족도

#상관관계 분석
dwf_df <- data.frame(f1_mean, f2_mean)
colnames(dwf_df) <-c("제품친밀도","제품만족도")
cor(dwf_df)

#요인적재량 행렬의 칼럼명 변경하시오 ("제품친밀도","제품만족도")

#요인점수를 이용한 요인적재량 시각화하시오

#요인별 변수로  묶기

#생성된 두 개의 요인을 데이터프레임으로 생성한 후 이를 이용하여 두 요인 간
#의 상관관계 계수를 제시하시오

###################################################################


################다중 회귀 분석 연습문제 #####################
#01] product.csv 파일의 데이터를 이용하여 다음과 같은 단계로 다중회귀분석을 수행하시오.
product <- read.csv("./data/data-4/product2.csv", header=TRUE)
head(product)
str(product)
#단계1 : 학습데이터(train), 검정데이터(test)를 7 : 3 비율로 샘플링
x <- sample(1:nrow(product), 0.7*nrow(product))  #70% 표본 추출, 행번호 추출
train <- product[x, ] #학습데이터 
test <- product[-x, ] #검정데이터

#단계2 : 학습데이터 이용 회귀모델 생성
#변수 모델링) y변수 : 제품_만족도, x변수 : 제품_적절성, 제품_친밀도
model <- lm(formula= 제품_만족도 ~ 제품_적절성+제품_친밀도, data=product)
model
summary(model)

#단계3 : 검정데이터 이용 모델 예측치 생성
head(train, 1)
#102 3 3 3
#회귀방정식
Y = 0.66731 + 0.68522*3 + 0.09593*3
Y    #회귀모델로부터 계산된 예측값 3.01076

# 오차 = 예측값 - 관측값 (3.01076 - 3) 0.01076
pred <- predict(model, test)
pred    #예측값 생성
View(pred)
length(pred)
length(product$제품_만족도)

View(product$제품_만족도)
#단계4 : 모델 평가 : cor() 함수 이용
cor(pred,product$제품_만족도[1:80])


##########################################################
#ggplot2패키지에서 제공하는 diamonds 데이터 셋을 대상으로 carat, table, depth 변수
#중 다이아몬드의 가격(price)에 영향을 미치는 관계를 다중회귀 분석을 이용하여 예측하시오.
#조건1) 다이아몬드 가격 결정에 가장 큰 영향을 미치는 변수는?
#조건2) 다중회귀 분석 결과를 양(+)과 음(-) 관계로 해설




##########################################################


#########로지스틱 회귀분석 #############
weather <- read.csv("./data/data-4/weather.csv",stringsAsFactors = F)
dim(weather) #관측치 366 / 변수 15
str(weather)
View(weather)
weather_df <- weather[,c(-1,-6,-8,-14)]

#y변수(RainTomorrow)의 로짓변환 : (0,1)로 생성
weather_df$RainTomorrow[weather_df$RainTomorrow=='Yes'] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow=='No'] <- 0
weather_df$RainTomorrow <-  as.numeric(weather_df$RainTomorrow)
head(weather_df)

#학습 데이터와 검정데이터 생성(7:3)
idx <- sample(1:nrow(weather_df),nrow(weather_df)*0.7)
train <- weather_df[idx, ]
test <- weather_df[-idx, ]

str(train)

#학습 데이터로부터 로지스틱 회귀모델 생성
weather_model <- glm(RainTomorrow ~ ., data=train, family='binomial')
weather_model
summary(weather_model)

#로지스틱 회귀모델 예측치 생성
pred <- predict(weather_model, newdata = test, type="response") #response는 예측결과를 0~1 사이의 확률값으로 예측치를 반환
pred #예측치가 1에 가까울 수록 비율 확률이 높다고 할 수 있다
#예측치를 이항형으로 변환 : 0.5 이상이면 1, 0.5 미만이면 0
result_pred <- ifelse(pred >= 0.5 , 1, 0)
table(result_pred) #0:91 / 1:12
table(result_pred, test$RainTomorrow)
#result_pred  0  1
#          0 84 12
#          1  5  7
# 분류 정확도는 (84+7)/(84+12+5+7) : 0.8425926

#ROC Curve 를 이용한 모델 평가
install.packages("ROCR")
library(ROCR)
pr <- prediction(pred, test$RainTomorrow)
prf <- performance(pr, measure="tpr", x.measure="fpr")
plot(prf)
#왼쪽 상단의 계단모양의 공백만큰 분류 정확도에서 오분류(missing)를 의미한다.










