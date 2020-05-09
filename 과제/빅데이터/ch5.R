install.packages("gapminder")
install.packages("dplyr")
library(gapminder)
library(dplyr)

glimpse(gapminder)
str(gapminder)
    
#각 나라의 기대 수명
gapminder[, c("country", "lifeExp")]

#각 나라의 기대 수명에 측정 연도를 같이 출력
gapminder[, c("country", "lifeExp", "year")]

#나라가 크로아티아인 자료 출력
gapminder[gapminder$country == "Croatia",]

#크로아티아의 인구 속성만 출력
gapminder[gapminder$country == "Crotia","pop"]

#크로아티아의 기대수명고ㅏ인구 속성 출력
gapminder[gapminder$country == "Croatia", c("lifeExp","pop")]

#1990년도 이후의 크로아티아의 기대 수명과 인구 속성 출력
gapminder[gapminder$country == "Croatia"&gapminder$year > 1990,
          c("lifeExp","pop")]

#크로아티아의 기대 수명과 인구 속성의 평균 출력, apply()함수 사용
apply(gapminder[gapminder$country == "Croatia",c("lifeExp","pop")], 2, mean)