set.seed(123)
x <- rnorm(100)
z <- 1 + 2*x
prob <- 1/(1+exp(-z))
y <- rbinom(100,1,prob)
data <- data.frame(x=x, y=y)
model <- glm(y ~ x, data = data, family = binomial())
plot(y ~ x, data = data, main = "Logistic Regression", xlab = "X", ylab = "Y")
curve(predict(model, newdata=data.frame(x=x), type="response"), add=TRUE,
col="blue")
