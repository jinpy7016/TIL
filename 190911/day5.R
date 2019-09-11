install.packages("reshape2")
library(reshape2)

#melt
head(airquality)
names(airquality) <- tolower(names(airquality))
head(airquality)
melt_test <- melt(airquality)
head(melt_test)
tail(melt_test)
melt_test2 <- melt(airquality, id.vars = c("month","wind"),measure.vars = "ozone")
head(melt_test2)

#cast
names(airquality) <- tolower(names(airquality))
head(airquality)
aq_melt <- melt(airquality,id=c("month","day"),na.rm = T)
head(aq_melt)
aq_dcast <- dcast(aq_melt, month+day~variable)
head(aq_dcast)
View(airquality)
View(aq_melt)
View(aq_dcast)

#acast
acast(aq_melt, day~month~variable)
acast(aq_melt,month~variable,mean)
dcast(aq_melt,month~variable,mean)

#KoNLP
install.packages("KoNLP")
install.packages("wordcloud2")
library(KoNLP)
useSystemDic()
useSejongDic()
useNIADic()
word_data <- readLines("./data/애국가(가사).txt")
word_data

word_data2<- sapply(word_data,extractNoun,USE.NAMES=F)
word_data2
add_words<-c("백두산","남산","철갑","가을","하늘","달")
buildDictionary(user_dic = data.frame(add_words,rep("ncn",length(add_words))),replace_usr_dic = T)
word_data2 <-sapply(word_data,extractNoun,USE.NAMES = F)
word_data2
undata<-unlist(word_data2)
undata

word_table <- table(undata)
word_table
undata2<-Filter(function(x){nchar(x) >=2},undata)
word_table2<-table(undata2)
word_table2
sort(word_table2,decreasing = T)

install.packages("wordcloud2")
library(wordcloud2)
wordcloud2(word_table2)
wordcloud2(word_table2,color = "random-light",backgroundColor = "black")
wordcloud2(word_table2,fontFamily = "맑은 고딕",size=1.2,color="random-light",backgroundColor="black",shape="star")


#naver 검색api
urlStr <- "https://openapi.naver.com/v1/search/blog.xml?"
searchString<-"query=코타키나발루"
searchString <- iconv(searchString, to="UTF-8")
searchString <- URLencode(searchString)
searchString
etcString<-"&display=100&start=1&sort=sim"
reqUrl<-paste(urlStr,searchString,etcString,sep="")
reqUrl

library(httr)
clientID<-'myclientID'
clientSecret<-'myclientSecret'
apiResult <- GET(reqUrl, add_headers("X-Naver-Client-Id"=clientID,"X-Naver-Client-Secret"=clientSecret))
apiResult
str(apiResult)
apiResult$content
str(apiResult$content)
result<-rawToChar(apiResult$content)
result
Encoding(result)<-"UTF-8"
result

refinedStr <- result
#XML 태그를 공란으로 치환
refinedStr <- gsub("<(\\/?)(\\w ?+)*([^<>]*)>", " ", refinedStr)
refinedStr
#단락을 표현하는 불필요한 문자를 공란으로 치환
refinedStr <- gsub("[[:punct:]]", " ", refinedStr)
refinedStr
#영어 소문자를 공란으로 치환
refinedStr <- gsub("[a-zA-Z]", " ", refinedStr)
refinedStr

#숫자를 공란으로 치환
refinedStr <- gsub("[0-9]", " ", refinedStr)
refinedStr

#여러 공란은 한 개의 공란으로 변경
refinedStr <- gsub(" +", " ", refinedStr)
refinedStr 

library(KoNLP)
library(rJava)

nouns<- extractNoun( refinedStr )
str(nouns)
nouns[1:40]

#길이가 1인 문자를 제외
nouns <-nouns[nchar(nouns) > 1]

#제외할 특정 단어를 정의
excluNouns <- c("코타키나발루", "얼마" , "오늘", "으로", "해서", "API", "저희", "정도")

nouns  <- nouns [!nouns  %in% excluNouns ]
nouns [1:40]

#빈도수 기준으로 상위 50개 단어 추출
wordT <- sort(table(nouns), decreasing=T)[1:50]
wordT

#wordcloud2 패키지 
# wordcloud2 (data, size, shape) 
#단어와 빈도수 정보가 포함된 데이터프레임 또는 테이블, 글자 크기, 워드 클라우드의 전체 모양(circle:기본값, cardioid, diamond, triangle, star등)

#install.packages("wordcloud2")
library(wordcloud2)
wordcloud2(wordT, size=3, shape="diamond")


#########################################################
# 영문서 형태소 분석 및 워드클라우드
#install
install.packages("tm")
install.packages("SnowballC")
install.packages("RColorBrewer")
install.packages("wordcloud")
#load
library("tm")
library("SnowballC")
library("RColorBrewer")
library("wordcloud")

filePath <- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
text<-readLines(filePath)
str(text)

#vectorsource()함수는 문자형 벡터 생성
docs<-Corpus(VectorSource(text))
head(docs)

# 텍스트의 특수 문자 등을 대체하기 위해 tm_map () 함수를 사용하여 변환이 수행됩니다.
# “/”,“@”및“|”을 공백으로 바꿉니다.
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
head(docs)

# 소문자로 변환
docs <- tm_map(docs, content_transformer(tolower))
# 수치 데이터 제거
docs <- tm_map(docs, removeNumbers)
# 영어 불용어 제거
docs <- tm_map(docs, removeWords, stopwords("english"))

# 벡터 구조로 사용자가 직접 불용어  설정 , 제거
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 

# 문장 부호 punctuations
docs <- tm_map(docs, removePunctuation)

# 공백 제거
docs <- tm_map(docs, stripWhitespace)

# 텍스트 형태소 분석
docs <- tm_map(docs, stemDocument)
docs

# 문서 매트릭스는 단어의 빈도를 포함하는 테이블입니다. 
# 열 이름은 단어이고 행 이름은 문서입니다. 
# text mining 패키지에서 문서 매트릭스를 생성하는 함수 사용
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)


set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))



###########################################################
#ggplot2
install.packages("ggplot2")
library(ggplot2)
str(airquality)
ggplot(airquality,aes(x=day,y=temp))+geom_point()
ggplot(airquality,aes(x=day,y=temp))+geom_point(size=2,color="red")
ggplot(airquality,aes(x=day,y=temp))+geom_line()
ggplot(airquality,aes(x=day,y=temp))+geom_line()+geom_point()

#막대그래프
ggplot(mtcars,aes(x=cyl))+geom_bar(width = 0.5)
ggplot(mtcars,aes(x=factor(cyl)))+geom_bar(width = 0.5)
ggplot(mtcars,aes(x=factor(cyl)))+geom_bar(aes(fill = factor(gear)))
#선버서트/원 그래프
ggplot(mtcars,aes(x=factor(cyl)))+geom_bar(aes(fill = factor(gear)))+coord_polar()
ggplot(mtcars,aes(x=factor(cyl)))+geom_bar(aes(fill = factor(gear)))+coord_polar(theta="y")

#상자/히스토그램
ggplot(airquality,aes(x=day,y=temp,group=day))+geom_boxplot()
ggplot(airquality,aes(temp))+geom_histogram(binwidth=1)


#그래프의 이해를 높이는 객체 추가하기
str(economics)
ggplot(economics,aes(x=date,y=psavert))+geom_line()+
  geom_abline(intercept = 12.18671,slope = -0.0005444)
ggplot(economics,aes(x=date,y=psavert))+geom_line()+
  geom_hline(yintercept = mean(economics$psavert))
#install.packages("dplyr")
library(dplyr)
x_inter<-filter(economics,psavert==min(economics$psavert))$date
ggplot(economics,aes(x=date,y=psavert))+geom_line()+
  geom_vline(xintercept = x_inter)

#텍스트 입력 및 도형 그리기
ggplot(airquality,aes(x=day,y=temp))+geom_point()+
  geom_text(aes(label=temp,vjust=0,hjust=0))
ggplot(mtcars,aes(x=wt,y=mpg))+geom_point()+
  annotate("rect",xmin=3,xmax=4,ymin=12,ymax=21,alpha=0.5,fill="skyblue")
ggplot(mtcars,aes(x=wt,y=mpg))+geom_point()+
  annotate("rect",xmin=3,xmax=4,ymin=12,ymax=21,alpha=0.5,fill="skyblue")+
  annotate("segment",x=2.5,xend=3.7,y=10,yend=17,color="red",arrow=arrow())
ggplot(mtcars,aes(x=wt,y=mpg))+geom_point()+
  annotate("rect",xmin=3,xmax=4,ymin=12,ymax=21,alpha=0.5,fill="skyblue")+
  annotate("segment",x=2.5,xend=3.7,y=10,yend=17,color="red",arrow=arrow())+
  annotate("text",x=2.5,y=10,label="point")

#그래프 제목 및 축 제목을 추가하고 디자인 테마 적용하기
ggplot(mtcars,aes(x=gear))+geom_bar()+
  labs(x="기어수",y="자동차수",title="변속기 기어별 자동차수")



##############################################################
#scrapping
#############################################################
install.packages('rvest')
library(rvest)
#스크래핑할 웹 사이트 URL을 변수에 저장
url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'
#웹 사이트로부터  HTML code 읽기
webpage <- read_html(url)   
webpage
# 스크래핑할 데이터 - rank, title, description, runtime, genre, rating, metascore, votes, gross_earning_in_Mil, director, actor
#랭킹이 포함된 CSS selector를 찾아서 R 코드로 가져오기
rank_data_html <- html_nodes(webpage,'.text-primary')
#랭킹 데이터를 텍스트로 가져오기
rank_data <- html_text(rank_data_html)
head(rank_data)
#랭킹 데이터를 수치형 데이터로 변환
rank_data<-as.numeric(rank_data) 
head(rank_data)
#str(rank_data)
#length(rank_data)

title_data_html<-html_nodes(webpage,'.lister-item-header a')
title_data<-html_text(title_data_html)
length(title_data)
title_data

desc_data_html<-html_nodes(webpage,'.ratings-bar+ .text-muted')
desc_data <- html_text(desc_data_html)
length(desc_data)
library(stringr)
desc_data<-gsub("\n","",str_trim(desc_data))
head(desc_data)

runtime_data_html<-html_nodes(webpage,'.lister-item-header+ .text-muted .runtime')
runtime_data <- html_text(runtime_data_html)
runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)

genre_data_html<-html_nodes(webpage,'.lister-item-header+ .text-muted .genre')
genre_data <- html_text(genre_data_html)
genre_data<-gsub("\n","",genre_data)
#1개이상의 공백을 제거하는 데이터 처리
genre_data<-gsub(" ","",genre_data)
#, . * 특수문자 제거하는 데이터 처리
genre_data<-gsub(",.*","",genre_data)
#문자열 데이터를 범주형 데이터로 변환 처리
genre_data<-as.factor(genre_data)
genre_data

#votes 영역의 CSS selectors를 이용한 스크래핑 
votes_data_html<-html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')
#votes 데이터 text로 가져오기
votes_data<-html_text(votes_data_html)
#콤마(,) 제거 데이터 처리
votes_data<-gsub(",","",votes_data)
#votes 데이터를 numerical으로 변환 데이터 처리
as.numeric(votes_data)

#IMDB rating 영역의 CSS selectors를 이용한 스크래핑
rating_data_html<-html_nodes(webpage,'.ratings-bar strong')
#IMDB rating 데이터 text로 가져오기
rating_data<-html_text(rating_data_html)
##IMDB rating 데이터를 numerical으로 변환 데이터 처리
as.numeric(rating_data)

#감독
director_data_html<-html_nodes(webpage,'.text-muted+ p a:nth-child(1)')
director_data<-html_text(director_data_html)
director_data<-as.factor(director_data)
director_data

#배우
actor_data_html<-html_nodes(webpage,'.lister-item-content .ghost+ a')
actor_data<-html_text(actor_data_html)
actor_data<-as.factor(actor_data)
actor_data

# metascore 영역의 CSS selectors를 이용한 스크래핑
metascore_data_html <- html_nodes(webpage,'.metascore')
# metascore 데이터 text로 가져오기
metascore_data <- html_text(metascore_data_html)
head(metascore_data)
#1개 이상의 공백 제거
metascore_data<-gsub(" ","",metascore_data)
length(metascore_data)
metascore_data
#metascore 누락된 데이터  NA처리하기  - 29,58, 73, 96
for (i in c(29,58, 73, 96)){
  a<-metascore_data[1:(i-1)]    #리스트로 확인
  b<-metascore_data[i:length(metascore_data)]
  metascore_data<-append(a,list("NA"))
  metascore_data<-append(metascore_data,b)
}
metascore_data
# metascore  데이터를 numerical으로 변환 데이터 처리
metascore_data<-as.numeric(metascore_data)
# metascore  데이터 개수 확인
length(metascore_data) 
#metascore 요약 통계 확인
summary(metascore_data)

# gross revenue(총수익)  영역의 CSS selectors를 이용한 스크래핑 
revenue_data_html <-html_nodes(webpage,'.sort-num_votes-visible span:nth-child(5)')
# gross revenue(총수익) 데이터 text로 가져오기
revenue_data<-html_text(revenue_data_html)
revenue_data
# '$' 와 'M' 기호 제거 데이터 처리
revenue_data<-gsub("[$M]","",revenue_data)
# gross revenue(총수익) 데이터 개수 확인
length(revenue_data)
# 누락된 데이터  NA로 채우기 29,45,57,62,73,93,98
for (i in c(29,45,57,62,73,93,98)){
  a<-revenue_data[1:(i-1)]    #리스트로 확인
  b<-revenue_data[i:length(revenue_data)]
  revenue_data<-append(a,list("NA"))
  revenue_data<-append(revenue_data,b)
}
# gross revenue(총수익) 데이터를 numerical으로 변환 데이터 처리
revenue_data<-as.numeric(revenue_data)
# gross revenue(총수익) 데이터 개수 확인
length(revenue_data)
revenue_data
# gross revenue(총수익) 요약 통계 확인 
summary(revenue_data)

#data.frame으로 변환
movies_df<-data.frame(Rank = rank_data, Title = title_data,
                      Description = desc_data, Runtime = runtime_data,
                      Genre = genre_data, Rating = rating_data,
                      Metascore = metascore_data, Votes = votes_data,   
                      Director = director_data, Actor = actor_data)

#변환된 data.frame 구조 확인
str(movies_df)

library('ggplot2')
#상영시간이 가장 긴 필름의 장르는?
#x축 상영시간, y축 장르별 필름 수 
qplot(data = movies_df,Runtime,fill = Genre,bins = 30)

#상영시간이 130-160 분인 장르중 votes가 가장 높은 것은?
ggplot(movies_df,aes(x=Runtime,y=Rating))+
  geom_point(aes(size=Votes,col=Genre))



