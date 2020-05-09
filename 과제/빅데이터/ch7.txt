install.packages("ggplot2")
library(ggplot2)
ex_mpg <- as.data.frame(mpg)
str(ex_mpg)

#slide29

ex_mpg %>%
  filter(manufacturer=="audi") %>%
  araange(desc(hwy)) %>%
  head(5)

#slide30

ex_mpg %>%
  mutate(tot_miles = cty + hwy,
         avg_miles = tot_miles/2) %>%
  arrange(desc(avg_miles)) %>%
  head(3)

#slide31

ex_mpg %>%
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty)) %>%
  head(10)

#회사별로 자동차종류가 "suv"인 자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 정렬하고 1~5위까지 출력하기

ex_mpg %>%
  filter(class == "suv") %>%
  group_by(manufacturer) %>%
  mutate(total = (cty + hwy)/2) %>%
  summarise(tot_mean = mean(total)) %>%
  arrange(desc(tot_mean)) %>%
  head(5)

#"compact"차종 수를 내림차순으로 정렬해 출력하세요

ex_mpg %>%
  filter(class == "compact") %>%
  group_by(manufacturer) %>%
  summarise(cnt = n()) %>%
  arrange(desc(cnt))

#n_mpg.csv파일을 n_mpg 데이터로 가져와서 작업하기

n_mpg <- read.csv("d:/SY/R/ds/ch5/data/n_mpg.csv")

#filter()를 이용해 hwy 변수의 결측치를 제외하고, 어떤 구동방식의 hwy평균이 높은지 알아보기

n_mpg %>%
  filter(!is.na(hwy)) %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

#ou_mpg.csv 파일을 ou_mpg 데이터로 가져와서 작업하기

ou_mpg <-
  read.csv("d:/SY/R/ds/ch5/data/ou_mpg.csv",
           stringsAsFactors = F)

ou_mpg1 <-
  read.csv("d:/SY/R/ds/ch5/data/ou_mpg.csv",
           stringsAsFactors = F)
ou_mpg1 %>%
  group_by(drv) %>%
  summarise(mean_cty = mean(cty))

#------------------------------------------------------------

table(ou_mpg$drv)
ou_mpg$drv <-
  ifelse(ou_mpg$drv %in% c("4", "f", "r"),
         ou_mpg$drv, NA)


#2
boxplot(ou_mpg$cty)$stats
ou_mpg$cty <-
  ifelse(ou_mpg$cty < 9 | ou_mpg$cty >26,
         NA, ou_mpg$cty)
boxplot(ou_mpg$cty)

#3
ou_mpg %>%
  filter(!is.na(drv) & !is.na(dty)) %>%
  group_by(drv) %>%
  summarise(mean_cty = mean(cty))


#------------------------------

avocado <- read.csv("d:/SY/R/ds/ch5/data/avocado.csv")
str(avocado)

#총 판매량과 평균가격 속성을 지역에 따라 구분하여 요약

(x_avg <- avocad %>%
    group_by(region) %>%
    summarise(V_avg = mean(Total.volume),
              P_avg = mean(AveragePrice)))

#총 판매량과 평균가격 속성을 지역 연도별로 세분화하기

(x_avg <- avocado %>%
    group_by(region, year) %>%
    summarise(V_avg = mean(Total.Volume),
              P_avg = mean(AveragePrice)))

#총 판매량을 기준으로 판매량 순위와 최댓값을 기록한 연도와 지역 출력
arrange(x_avg, desc(V_avg))
x_avg1 <- x_avg %>% filter(region != "TotalUS")
x_avg1 %>% arrange(desc(V_avg)) %>%
  head(1)

(x_avg2 <- avocad %>%
    group_by(region, year, month(Date), type) %>%
    summarise(V_avg = mean(Total.Volume),
              P_avg = mean(AveragePrice)))

# win.data.txt 파일을 읽어들여 wine데이터로 지정하기
wine <- read.table("d:/SY/R/ds/ch5/data/wine.data.txt",
                   header = FALSE, sep= ",")
head(wine)

#wine.name.txt 파일을 읽어들여 wine 데이터의 열이름으로 지정함
names(wine)[2:14] <- substr(n, 4, nchar(n))
names(wine)
names(wine)[1] <- "id"
names(wine)

#wine데이터의 60%만 추출하여  train_set 데이터에 지정함
train_set <- sample_frac(wine, 0.6)
str(train_set)
test_set <- setdiff(wine, train_set)
str(test_set)