#"NHIS2016" 파일 가져오기

NHIS2016 <-
  read.csv("d:/SY/R/ds/ch6/data/NHIS_OPEN_GJ_2016.csv",
           fileEncoding ="EUC-KR")

str(NHIS2016)
View(NHIS2016)


#---------------------------------------------------------

#NHIS2016M 생성


NHIS2016M <- NHIS2016[1:26]

#2-3
#결측값 제거
NHIS2016M <- na.omit(NHIS2016)
View(NHIS2016M)


#----------------------------------------------------------

#2017년 데이터 불러오기

NHIS2017 <-
  read.csv("d:/SY/R/ds/ch6/data/NHIS_OPEN_GJ_2017.csv",
           fileEncoding ="EUC-KR")


NHIS2017M <- na.omit(NHIS2017M)
View(NHIS2017M)

#데이터 병합하여 저장
NHIS2016_7M <-
  merge(NHIS2016M, NH2017M, all = T)
View(NHIS2016_7M)


#각 대륙의 연도별 gdpPercap의 평균값을 데이터로 추출한 후 해당 데이터를 사용하여 그래프를 그리고 범례를 원하는 위치에 추가하기 
#dplyr 라이브러리
library(gapminder)
library(dplyr)

gdpPercap <- gapminder %>% group_by(year, continent) %>%
  summarise(c_pop = mean(pop))

head(gdpPercap,20)
View(gdpPercap)
View(gapminder)


#그래프, 기본, 대륙별 색상, 대륙별 표식, 대륙별 범례
plot(gdpPercap$year, gdpPercap$c_pop)

#대륙별 색상
plot(gdpPercap$year, gdpPercap$c_pop, col = gdpPercap$continent)

#대륙별 표식
plot(gdpPercap$year, gdpPercap$c_pop, col = gdpPercap$continent, pch=c(1:5))
plot(gdpPercap$year, gdpPercap$c_pop, col = gdpPercap$continent,
     pch=c(1:length(levels(gdpPercap$continent))))
plot(gdpPercap$year, gdpPercap$c_pop, col = gdpPercap$continent,
     pch=c(1:nlevels(gdpPercap$continent)))


levels(gdpPercap$continent)
nlevels(gdpPercap$continent)

#대륙별 범례

legend("topleft", legend = levels(gdpPercap$continent),
       pch = c(1:5), col=c(1:5))

legend("topleft", legend = levels(gdpPercap$continent),
       pch = c(1:length(levels(gdpPercap$continent))),
       col=c(1:length(levels(gdpPercap$continent))))


#1957년 gdpPercap과 lifeExp의 대륙별 평균을 데이터로 추출한 후, 해당 데이터를 사용하여 가로축에는 continent, 세로축에는 gdpPercap 평균값을 나타낸 그래프로 시각화하기
#plot( ) 사용

lifeExp <- gapminder %>%
  filter(year == "1957") %>%
  group_by(year, continent) %>%
  summarise(m_lifeExp=mean(lifeExp),
            m_gdpPercap=mean(gdpPercap))
head(lifeExp, 20)