set.seed(123)
x <- rnorm(100)
y <- 2*x + rnorm(100)
data <- data.frame(x=x, y=y)
model <- lm(y ~ x, data = data)
summary(model)
# visualizing
plot(y ~ x, data = data, main = "Linear Regression", xlab = "X", ylab = "Y")
abline(model, col = "blue")