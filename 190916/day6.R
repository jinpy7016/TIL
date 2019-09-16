##############################################
#가격 비교를 위한 스크래핑
#rvest 패키지 : 웹 페이지에서 필요한 정보를 추출하는데 유용한 패키지
#selectr패키지, xml2 패키지가 의존 패키지이므로 함께 설치
#read_html(url) : 지정된 url에서 html 컨텐츠를 가져옵니다.
#jsonline 패키지 : json 파서/생성기가 웹용으로 최적화되어 있는 패키지
##############################################
install.packages("jsonlite")
library(jsonlite)
library(xml2)
library(rvest)
library(stringr)

url <- 'https://www.amazon.in/OnePlus-Mirror-Black-64GB-Memory/dp/B0756Z43QS?tag=googinhydr18418-21&tag=googinkenshoo-21&ascsubtag=aee9a916-6acd-4409-92ca-3bdbeb549f80'

#추출할 정보 : 제목, 가격, 제품 설명, 등급, 크기, 색상

#웹 사이트로부터  HTML code 읽기
webpage <- read_html(url)

#제목 정보의 태그 가져오기
title_html <- html_nodes(webpage, 'h1#title')
title <- html_text(title_html)
title<-gsub("\n","",str_trim(title))
head(title) 
#모든 공백과 줄 바꿈 제거
str_replace_all(title, "[\r\n]", "")

#가격 정보 태그 가져오기
price_html <- html_nodes(webpage, 'span#priceblock_ourprice')
price <- html_text(price_html)
#모든 공백과 줄 바꿈 제거
price <-str_replace_all(price, "[\r\n]", "")
head(price) 

desc <- html_nodes(webpage, 'div#feature-bullets')

###############################################
#프로젝트 1.치킨집이 가장 많은 지역 찾기
#http://www.localdata.kr 에서 음식점 엑셀 데이터를 가공
install.packages("readxl")
library(readxl)
ck<-read_excel("./data/치킨집_가공.xlsx")
head(ck)

addr<-substr(ck$소재지전체주소, 11, 16)
head(addr)

#숫자제거
addr_num <- gsub("[0-9]","",addr)
#공백제거
addr_trim<- gsub(" ","",addr_num)
head(addr_trim)

#도수분포표 작성 후 데이터 프레임으로 변환
addr_count <- addr_trim %>% table() %>% data.frame()
head(addr_count)

#트리맵으로 표현
install.packages("treemap")
library(treemap)
treemap(addr_count,index=".",vSize="Freq",title="서대문구 동별 치킨집 분포")
#내림차순으로 데이터 확인
library(dplyr)
arrange(addr_count,desc(Freq)) %>% head()
###############################################
#프로젝트 2.지역별 미세먼지 농도 비교하기
#http://cleanair.seoul.go.kr/

#데이터 로드
dustdata<-read_excel("./data/dustdata.xlsx",na="")
View(dustdata)
str(dustdata)
as.numeric(dustdata$finedust)
#데이터 추출
dustdata_anal <- dustdata %>% filter(area %in% c("성북구","중구"))
dustdata_anal$finedust<-as.numeric(dustdata_anal$finedust)
head(dustdata_anal)

#데이터 현황 파악
count(dustdata_anal,yyyymmdd) %>% arrange(desc(n))
count(dustdata_anal,area) %>% arrange(desc(n))

#데이터 구별 분리
dust_anal_area_sb <- subset(dustdata_anal,area=="성북구")
dust_anal_area_sb$finedust <- as.double(dust_anal_area_sb$finedust)
dust_anal_area_jg <- subset(dustdata_anal,area=="중구")
dust_anal_area_jg$finedust <- as.double(dust_anal_area_jg$finedust)
head(dust_anal_area_sb)
head(dust_anal_area_jg)

#미세먼지 통계량 도출
install.packages("psych")
library(psych)
describe(dust_anal_area_sb$finedust)
describe(dust_anal_area_jg$finedust)

#분포 확인
boxplot(dust_anal_area_sb$finedust, dust_anal_area_jg$finedust,
        main="finedust_compare", xlab="AREA",names = c("성북구","중구"),
        ylab="FINEDUST_PM",col=c("blue","green"))
#t검정(p-value 값이 0.05보다 작으면 집단간 차이가 통계적으로 
#유의미하게 나타난다고 볼 수 있다.)
t.test(data=dustdata_anal,finedust ~ area,var.equal=T)

###############################################
#프로젝트 4.지하철역 주변 가격 알아보기
#google maps api
install.packages("devtools")
install_github("dkahle/ggmap")
library(devtools)
library(ggmap)
library(dplyr)

#엑셀 데이터 가져오기
station_data<-read.csv("./data/역별_주소_및_전화번호.csv")
str(station_data)

#지하철역 좌표구하기
#apikey등록
googleAPIkey <- "구글apikey"
register_google(googleAPIkey)
station_code<-as.character(station_data$구주소)
station_code<-geocode(station_code)
View(station_code)
station_code_final <-cbind(station_data,station_code)
head(station_code_final)

#아파트 실거래가 데이터 가공
apart_data <- read.csv("./data/아파트_실거래가.csv")
head(apart_data)
apart_data$전용면적 <- round(apart_data$전용면적)
head(apart_data)
count(apart_data,전용면적) %>% arrange(desc(n))
apart_data_85 <-subset(apart_data,전용면적=="85")
head(apart_data_85)
str(apart_data_85)

#아파트 단지별 평균 거래 금액
#거래금액 쉼표제거
apart_data_85$거래금액 <- gsub(",","",apart_data_85$거래금액)
head(apart_data_85)
#단지명별 평균
apart_data_85_cost <- aggregate(as.integer(거래금액) ~ 단지명, apart_data_85, mean)
head(apart_data_85_cost)
#거래금액 열 이름 변경
apart_data_85_cost <- rename(apart_data_85_cost,"거래금액"="as.integer(거래금액)")
head(apart_data_85_cost)
#중복되는 단지명 제거
apart_data_85 <- apart_data_85[!duplicated(apart_data_85$단지명),]
head(apart_data_85)
#단지명 기준으로 데이터 병합
apart_data_85 <- left_join(apart_data_85,apart_data_85_cost,by="단지명")
head(apart_data_85)
#열 명칭 변경 
apart_data_85<-apart_data_85 %>% select("단지명","시군구","번지","전용면적","거래금액.y")
apart_data_85<-rename(apart_data_85,"거래금액" = "거래금액.y")
head(apart_data_85)

#시군구와 번지 합치기
#시군구/번지 열 합치기
apart_address<-paste(apart_data_85$"시군구",apart_data_85$"번지")
head(apart_address)
#데이터프레임 구조로 변경
apart_address<-paste(apart_data_85$"시군구",apart_data_85$"번지") %>% data.frame()
head(apart_address)
#열 이름 변경
apart_address <- rename(apart_address,"주소"=".")
head(apart_address)

#좌표정보 추가 후 최종 데이터 생성
#주소를 위/경도로 변환 후 _code 에 저장
apart_address_code <- as.character(apart_address$"주소") %>% enc2utf8() %>% geocode()
#데이터셋 합친 후 일부 열만 _final에 저장
apart_code_final<-cbind(apart_data_85,apart_address,apart_address_code) %>%
  select("단지명","전용면적","거래금액","주소",lon,lat)
head(apart_code_final)

#마포구 지도 가져오기
mapo_map <- get_googlemap("mapogu",maptype = "roadmap",zoom=12)
ggmap(mapo_map)
install.packages("ggplot2")
library(ggplot2)

#지하철역 위치 표시
ggmap(mapo_map)+
  geom_point(data=station_code_final,aes(x=lon,y=lat),colour="red",size=3)+
  geom_text(data=station_code_final,aes(label=역명,vjust=-1))

#홍대입구역 인근 아파트 정보 표시
hongdae_map <- get_googlemap("hongdae station",maptype = "roadmap",zoom=15)
ggmap(hongdae_map) +
  geom_point(data=station_code_final,aes(x=lon,y=lat),colour="red",size=3)+
  geom_text(data=station_code_final,aes(label=역명,vjust=-1))+
  geom_point(data=apart_code_final,aes(x=lon,y=lat))+
  geom_text(data=apart_code_final,aes(label=단지명,vjust=-1))+
  geom_text(data=apart_code_final,aes(label=거래금액,vjust=-1))
#######################################################