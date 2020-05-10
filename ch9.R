gap 1 <- gapminder::gapminder

plot(gap1$gdpPercap, gap1$lifeExp, col=gap1$continent)
legend("bottomright", legend = levels((gap1$continent)),
       pch = c(1:length(levels(gap1$continent))),
       col = c(1:length(levels(y$continent))))

#로그 스케일 사용

plot(log10(gap1$gdpPercap), gap1$lifeExp, col=gap1$continent)
legend("bottomright", legend = levels((gap1$continent)),
       pch = c(1:length(levels(gap1$continent))),
       col = c(1:length(levels(y$continet))))

#ggplot

ggplot(gap1, aes(x = gdpPercap, y = lifeExp, col = continent)) + geom_point
() + scale_x_log10()

#size 지정, 인구 수에 따라 크기가 다르게 나옴

ggplot(gap1, aes(x=gdpPercap, y = lifeExp, col = continent, size=pop)) +
  geom_point() + scale_x_log10()

#마커에 투명도 설정하기

ggplot(gap1, aes(x = gdpPercap, y = lifeExp, col = continent, size=pop)) +
  geom_point(aplha = 0.5) + scale_x_log10()

#히스토그램

ggplot(iris, aes(x = Sepal.width, fill = species, color = Species)) +
  geom_histogram(binwidth = 0.5, position = "dodge") +
  theme(legend.position = "top")

summary(iris)

#산점도 작성

ggplot(iris, aes(x = Petal.Length, y = Petal.width, color = Species)) +
  geom_point(size = 3) +
  ggtitle("꽃잎의 길이") +
  xlim(1, 8) +
  ylim(0, 3) +
  theme(plot.title = element_text(size = 25, face = "bold",
                                  colour = "steelblue"))



#ggplot2 배경 설정하기

ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()


library(ggplot2)
library(dplyr)

df <- data.frame(month = c(1:6),
                 rain = c(55, 50, 45, 50, 60, 70))
df

#막대그래프

ggplot(df, aes(x = month, y = rain))+
       geom_bar (stat = "identity",
                 width = 0.7,
                 fill = "steelblue") +
  ggtitle("월별강수량") +
  theme(plot.title = element_text(size = 25, face = "bold",
                                  colour = "steelblue")) +
  labs(x="월", y="강수량") +
  coord_flip()

#선 그래프 작성

df2 <- data.frame(year = c(1937:1960), #1937~1960 민간항공기 이용한 마일리지
                  cnt = as.vector(airmiles))
ggplot(df2, aes(x = year, y = cnt)) +
  geom_line(col = "red") +
  geom_point()

#시각화에 특화된 ggplot2 라이브러리

gapminder %>% filter(lifeExp > 70) %>% group_by(continent) %>%
  summarise(n = n_distinct(country)) %>%
  ggplot(aes(x = continent, y = n)) + geom_bar(stat = "identity")

gapminder %>% filter(year == 2007) %>%
  ggplot(aes(lifeExp, col = continent)) +
  geom_histogram()

gapminder %>% filter(year == 2007) %>%
  ggplot(aes(lifeExp, col = continent)) +
  geom_boxplot()


#Spectral 팔레트

gapminder %>% filter(lifeExp > 70) %>%
  group_by(continent) %>%
  summarise(n = n_distinct(country)) %>%
  ggplot(aes(x = continent, y = n)) +
  geom_bar(stat = "identity", aes(fill = continent)) +
  scale_fill_brewer(palette = "Spectral")

# Blues 팔레트
gapminder %>% filter(lifeExp > 70) %>%
  group_by(continent) %>%
  summarise(n = n_distinct(country)) %>%
  ggplot(aes(x = continent, y = n)) +
  geom_bar(stat = "identity", aes(fill = continent)) +
  scale_fill_brewer(palette = "Blues")


#reorder <큰순에서 작은순으로 내림차순


#막대순서

gapminder %>% filter(lifeExp > 70) %>%
  group_by(continent) %>%
  summarise(n = n_distinct(country)) %>%
  ggplot(aes(x = reorder(continent, -n), y = n)) +
  geom_bar(stat = "identity", aes(fill = continent)) +
  scale_fill_brewer(palette = "Blues")


#관측연도 구분
ggplot(gap1, aes(x = gdpPercap, y = lifeExp, col = continent, size=pop)) +
  geom_point(aplha = 0.5) + scale_x_log10() + facet_wrap(~year)


#1952년 아시아 대륙의 인구 분포에서 각 국가의 순위를 매기기
gapminder %>% filter(year == 1952 & continent == "Asia") %>%
  ggplot(aes(reorder(country, pop),pop)) +
  geom_bar(stat = "identity") +
  coord_flip()


gapminder %>% filter(year == 1952 & continent == "Asia") %>%
  ggplot(aes(x = reorder(country, pop), y = pop)) +
  geom_col() +
  coord_flip()

#로그 스케일 축 사용

gapminder %>% filter(year == 1952 & continent == "Asia") %>%
  ggplot(aes(reorder(country, pop),pop)) +
  geom_bar(stat = "identity") +
  scale_y_log10() +
  coord_flip()

gapminder %>% filter(year == 1952 & continent == "Asia") %>%
  ggplot(aes(x = reorder(country, pop), y = pop)) +
  geom_col() +
  scale_y_log10() +
  coord_flip()

#변화추세 선 그래프
gapminder %>% filter(country == "korea, Rep.") %>%
  ggplot(aes(year, lifeExp, col = country)) +
  geom_line() +
  geom_point()

gapminder %>%
  ggplot(aes(x = year, y = lifeExp, col = continent)) +
  geom_point(alpha = 0.2) +
  geom_smooth()

# hist 함수 사용
x <- filter(gapminder, year == 1952)
hist(x$lifeExp, main = "Histogram of lifeExp in 1952")

#ggplot 라이브러리 geom_histogram()사용
x %>% ggplot(aes(lifeExp)) + geom_histogram()

x %>% ggplot(aes(lifeExp)) +
  geom_histogram(Fill = "white" , colour="black")

# geom_boxplot()사용
x %>% ggplot(aes(continent, lifeExp)) +
  geom_boxplot()

#gdpPercap과 lifeExp간의 상관관계 시각화
plot(log10(gapminder$gdpPercap), gapminder$lifeExp)

gapminder %>%
  ggplot(aes(gdpPercap, lifeExp)) +
  geom_point(alpha = 0.2, size = 2) +
  scale_x_log10()

plot(vis_air$Temp, vis_air$Ozone, xlab = "온도", ylab = "오존",
     main = "온도와 오존", pch = 5, cex=1.2, col= "navy",
     xlim=c(50,100), ylim=c(0,180))

#gapminder의 1952년 아시아 국가들의 gdp 구성고ㅏ비율

x <- gapminder %>%
  filter(year == 1952 & continent == "Asia") %>%
  mutate(gdp = gdpPercap*pop) %>%
  select(country, gdp) %>%
  arrange(desc(gdp)) %>%
  head()
pie(x$gdp, x$country)
barplot(x$gdp, names,arg = x$country)


#matplot 함수
matplot(iris[,1:4], type="1")
legend("topleft", names(iris)[1:4], lty = c(1:4), col = c(1:4))

#hist함수
hist(iris$Sepal.Length)