str(cars)

head(cars)

plot(cars)


car_model <- lm(dist ~ speed, data = cars)
coef(car_model) 


plot(cars)
abline(car_model, col = 'red')

#예측 훈련

fitted(car_model) 

#잔차 확인

residuals(car_model) 

#시속 21.5로 달리고 있었다면 제동 거리가 얼마일까?

nx1 <- data.frame(speed=21.5)
predict(car_model, nx1)

#각 스피드의 제동 거리

nx2 <- data.frame(speed = c(25.0, 25.5, 26.0,
                            26.5, 27.0, 27.5, 28.0))
predict(car_model, nx2)

#예측값으로 그래프 그리기

plot(nx2$speed, predict(car_model, nx2),
                        cex=2, pch=20)
abline(car_model)

#lm에 고차 방정식 적용
#lm은 기본적으로 1차 방정식, 직선모델 적합 

plot(cars, xlab='속도', ylab='거리')
x <- seq(0, 25, length.out = 200)
for (i in 1:4) {
  m <- lm(dist~ poly(speed, i), data = cars)
  assign(paste('m', i, sep = '.'), m)
  lines(x, predict(m, data.frame(speed=x)), col = i)
}

#anova함수로 분산분석

anova(m.1, m.2, m.3, m.4)

#women데이터로 모델의 통계량 해석하기

str(women)
#모델링 후 가시화

women_model <- lm(weight ~ height, data = women)
coef(women_model)

#summary 함수로 모델의 상세 내용 보기

summary(women_model)

plot(women)
abline(women_model1, col='red')

#Pr(>|t|) -> 1.09e-14...는 0.05보다 작아서 유의미 하다는 것을 알 수 있음
#Adjusted R-squared를 보면 높은 확률로 예측이 가능하다는 것을 알 수 있음

#cars데이터 모델과 비교

car_model <- lm(dist ~ speed, data = cars)
summary(car_model)


#3차원 차트

install.packages("scatterplot3d")
library(scatterplot3d)

x <- c(3,6,3,6)
u <- c(10, 10, 20, 20)
y <- c(4.65, 5.9, 6.7, 8.02)

m <- lm(y ~ x + u)
coef(m)

fitted(m)
residuals(m)
deviance(m)
deviance(m)/length(x)

#샘플 2개에 대한 예측 수행하기
nx <- c(7.5, 5.0)
nu <- c(15.0, 12.0)
new_data <- data.frame(x=nx, u=nu)
ny <- predict(m, new_data)
ny

summary(m)

#다중 선형 회귀의 적용 trees 데이터

str(trees)

summary(trees)

#Girth 8.5, 13.0, 19.0 / Height 72, 86, 85

new_data <- data.frame(Girth = c(8, 13, 19),
                       Height = c(72, 86, 85))

predict(model, new_data)

#--------------------------------------------------

n <- predict(model, new_data)

s <- scatterplot3d(new_data$Girth, new_data$Height,
                   n, pch=20, type = 'h',
                   color = 'red', angle = 55)
s$plane3d(model)
summary(model)
#-----------------------------------------------------

#======================================================
#변수 선별
install.packages("car")
library(car)
install.packages("MASS")
library(MASS)

newdata <- Prestige[, c(1:5)]
head(newdata)

mod2 <- lm(income ~ education + prestige +
             women + census, data = newdata)

#변수선택 stepAIC()
mod3 <- stepAIC(mod2)
mod
summary(mod2)
summary(mod3)


icecream <- read.csv("d:/R/ds/ch8/data/icecream.csv")
plot(icecream)

#머플러
discount <- c(2, 4, 6, 8, 10)
profit <- c(0, 0, 0, 1, 1)
muffler = data.frame(discount, profit)

plot(muffler, pch = 20, cex = 2, xlim = c(0, 12))
#abline(lm(profit ~ discount, data = muffler))

lmodel <- lm(profit ~ discount, data = muffler)

coef(lmodel)

fitted(lmodel)

residuals(lmodel)

deviance(lmodel)

#선형 모델을 적용한 예측값
newdt <- data.frame(discount = c(1, 5, 12, 20, 30))
p <- predict(lmodel, newdt)
p

plot(muffler, pch = 20, cex = 2, xlim = c(0,32),
     ylim = c(-0.5, 4.2))
abline(lmodel)
res <- data.frame(discount = newdt, profit = p)
points(res, pch = 20, cex = 2, col = 'red')
legend("bottomright", legend = c("train data", "new data"),
       pch = c(20, 20), cex = 2,
       col = c("black", "red"), bg="gray")

#일반화 선형 모델
#glm() 사용
discount <- c(2,4,6,8,10)
profit <- c(0, 0, 0, 1, 1)
muffler = data.frame(discount, profit)
g <- glm(profit ~ discount, data = muffler, family = binomial)

coef(g)
fitted(g)
residuals(g)
deviance(g)

plot(muffler, pch = 20, cex = 2)


# 새로운 데이터 사용 예측하기
newdt <- data.frame(discount = c(1, 5, 12, 20, 30))
p <- predict(g, newdt)
p

p <- predict(g, newdt, type = 'response')
p

plot(muffelr, pch = 20, cex = 2, xlim = c(0, 32))
abline(g, col = 'blue', lwd = 2)
res = data.frame(discount = newdt, profit = p)
points(res, pch = 20, cex = 2, col = 'red')
legend("bottomright", legend = c("train data", "new data"))


#실제 데이터 적용

haberman <- read.csv("https://archive.ics.uci.edu/m1/machine-learning-databases/haberman/haberman.data", header = FALSE)

names(haberman) <- c('age', 'op_year', 'no_nodes', 'survival')
str(haberman)
haberman$survival <- as.factor(haberman$survival)

str(heberman)

#glm

h <- glm(survival ~ age + op_year + no_nodes, data = haberman,
         family = binomial)

coef(h)
deviance(h)
fitted(h)
summary(h)