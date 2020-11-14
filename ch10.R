#시각화를 이용한 데이터 탐색
library(dplyr)
library(ggplot2)
library(gapminder)

  #gapminder 데이터의 시각적 탐구

gapminder %>%
  ggplot(aes(gdpPercap, lifeExp, col = continent)) +
  geom_point(alpha = 0.2) +
  facet_wrap(~year) + scale_x_log10()

gapminder %>% filter(year == 1952 &
                       gdpPercap > 10000 &
                       continent == "Asia")

gapminder %>% filter(country == "Kuwait") %>%
  ggplot(aes(year,gdpPercap)) +
  geom_point() + geom_line()

gapminder %>% filter(country == "Kuwait") %>%
  ggplot(aes(year, pop)) +
  geom_point() + geom_line()

gapminder %>% filter(country == "Korea, Rep.") %>%
  ggplot(aes(year, gdpPercap)) +
  geom_point() + geom_line()

gapminder %>% filter(country == "Korea, Rep.") %>%
  ggplot(aes(year, pop)) +
  geom_point() + geom_line()

#gdpPercap과 pop을 효과적으로 관찰하기 위해 gdp추가하여 이용하기
gapminder %>% filter(country == "Kuwait" | country == "Korea, Rep.") %>%
  mutate(gdp = gdpPercap*pop) %>%
  ggplot(aes(year, gdp, col = country)) +
  geom_point() + geom_line()

#공업국가 원유국가 비교
compare_country <- c("Kuwait", "Saudi Arabia", "Iraq", "Iran",
                     "Korea, Rep.", "China", "Japan")


#gdpPerap 변화
gapminder %>%
  filter(country %in% compare_country) %>%
  ggplot(aes(year, gdpPercap, col=country)) +
  geom_point() + geom_line()

#pop 변화
gapminder %>%
  filter(country %in% compare_country) %>%
  ggplot(aes(year, pop, col=country)) +
  geom_point() + geom_line() +
  scale_y_log10()

#gdp 변화
gapminder %>%
  filter(country %in% compare_country) %>%
  mutate(gdp = gdpPercap*pop) %>%
  ggplot(aes(year, gdp, col=country)) +
  geom_point() + geom_line() +
  scale_y_log10()