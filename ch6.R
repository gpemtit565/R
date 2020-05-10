#daplyr (p156)
library(dplyr)
library(gapminder)
View(gapminder)
str(gapminder)

seclect(gapminder, country, year, lifeExp)
gapminder %>% select(country, year, lifeExp)
gapminder %>% select(-pop)

table(gapminder$continent)
summary(gapminder)

#filter
filter(gapminder, country == "Croatia")
gapminder %>% filter(country == "Croatia")  

gapminder %>% filter(continent == "Oceania")
gapminder %>% filter(continent != "Africa")
gapminder %>% filter(pop >= 100000000)
gapminder %>% filter(pop >= mean(pop))
gapminder %>% filter(pop <= median(pop))


#country가 'Croatia'인 데이터만 추출하여 출력하기

filter(gapminder, country == "Croatia")
gapminder %>% filter(country == "Croatia")

#continent가 'Oceania'인 데이터만 추출하여 출력하기

gapminder %>% filter(continent == "Oceania")

#continent가 'Africa'가 아닌 데이터만 추출하여 출력하기

gapminder %>% filter(continent != "Africa")

#인구(pop)가 100,000,000 이상인 데이터만 추출하여 출력하기

gapminder %>% filter(pop >= 100000000)

#인구가 평균 이상인 데이터만 추출하여 출력하기

gapminder %>% filter(pop >= mean(pop))

#인구가 중앙값 이하인 데이터만 추출하여 출력하기

gapminder %>% filter(pop <= median(pop))

#인구가 100,000,000이하인 아시아 데이터만 추출하여 출력하기

gapminder %>% filter(pop <= 100000000 & continent == "Asia")

#continent가 Asia 또는 Oceania인 데이터만 추출하여 출력하기

gapminder %>% filter(continent=="Asia" | continent == "Oceania")

#continent가 Asia 또는 Europe 또는 Oceania인 데이터만 추출항ㅕ출력하기
#%in#(매치 연산자 사용)

gapminder %>% filter(continent %in% c("Asia", "Europe", "Oceania"))

#행/열 단위의 연산(p158)
#인구의 평균을 요약 출력함
#대륙별로 인구의 평균을 요약 출력함
#대륙별로 그룹짓고 같은 대륙은 나라별로 그룹 지은 후
#인구(pop)의 평균을 요약 출력함

summarise(gapminderm, pop_avg = mean(pop))
summarise(group_by(gapminder, continent),
          pop_avg = mean(pop))
summarise(group_by(gapminder, continent, country),
          pop_avg = mean(pop))

gapminder %>% summarise(pop_avg = mean(pop))
gapminder %>% group_by(continent) %>%
  summarise(pop_avg = mean(pop))
gapminder %>% group_by(continent, country) %>%
  summarise(pop_avg = mean(pop))

#국가가 'Croaita'인 데이터들의 country, year, lifeExp 열들만 추출한 후 기대수명의 평균을 요약하여 출력함

gapminder %>%
  filter(country == "Croatia") %>%
  select(country, year, lifeExp) %>%
  summarise(lifeExp_avg = mean(lifeExp))

#대륙을 기준으로 오름차순 정렬하여 출력함
#대륙을 기준으로 오름차순 정렬하고 출력하고 같은 대륙내에서는 연도의 내림차순으로 정렬함
gapminder %>% arrange(continent)
gapminder %>%
  arrange(continent, desc(year))

#mutate 함수

library(readxl)
exam <- read_excel("d:/SY/R/ds/ch5/data/exam.xlsx")
View(exam)

#세 과목점수의 총점 변수 추가하기
#세 과목점수의 총점 변수와 평균 변수 추가하기

exam %>% mutate(total = math + english + science) %>%
  head()

exam %>% mutate(total = math + english + science,
                mead = (math + english + science)/3) %>%
  head()

#과학 점수가 60이상이면 "pass"아니면 "fail"로 표시

exam%>%
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>%
  head()

#total 파생 변수를 추가한 후 total을 기준으로 오름차순 정렬하기

exam %>%
  mutate(total = math + english + science) %>%
  arrange(total) %>%
  head()

exam %>%
  mutate(total = math + english + science) %>%
  araange(total) %>%
  head()

#class별로 묶은후 각 class의 과목별 평균, 학생 수 산출한 데이터를 class_exam으로 할당하기

exam %>% group_by(class) %>%
  summarise(mean_math = mean(math),
            mean_english = mean(english),
            mean_science = mean(science),
            num = n())

#dplyr 복습 ggplot2 ::mpg 데이터 사용
install.packages("ggplot2")
library(ggplot2)
ex_mpg <- as.data.frame(mpg)
str(ex_mpg)

#slide26

ex_mpg_4 <- ex_mpg %>% filter(displ <= 4)
mean(ex_mpg_4$hwy)

ex_mpg_5 <- ex_mpg %>% filter(displ >= 5)
mean(ex_mpg_5$hwy)

#"audi"와 "toyota"중 어느 제조회사의 연비가 평균적으로 더 높은지 알아보세요.

ex_mpg %>%
  filter(manufacturer=="audi" | manufacturer=="toyota") %>%
  group_by(manufacturer) %>%
  summarise(manu_mean = mean(cty)) %>%
  print()

#"chevrolet", "ford", "honda"자동차의 고속도로 연비 평균을 알아보려고 한다. 이 회사들의 자동차를 추출한 뒤 hwy전체 평균을 구해보세요
ex_mpg %>%
  filter(manufacturer %in% c("chevrolet", "ford", "honda")) %>%
  summarise(hwy_mean = mean(hwy)) %>%
  print()