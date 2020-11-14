x <- c(10.0, 12.0, 9.5, 22.2, 8.0)
y <- c(360.2, 420.0, 359.5, 679.0, 315.3)
m <- lm(y ~ x)
m

plot(x,y)
abline(m, col="red")

#coef : 회귀계수(절편,기울기)
coef(m)

#fitted : 샘플에 대한 예측값
fitted(m)

#residuals : 잔차(오차)를 알려줌
residuals(m)

#deviance : 잔차를 제곱함
#deviance잔차 / length 샘플수 = 평균 제곱 오차
deviance(m) / length(x)

#잔차 제곱의 합
sum(residuals(m)^2)

summary(m)

#새로운 샘플
newx <- data.frame((x = c(10.5, 25.0, 15.0)))
predict(m, newdata = newx)

plot(x,predict(m, newdata = newx), xlim = c(1,21),
     pch=16, col= 'red')
abline(m)