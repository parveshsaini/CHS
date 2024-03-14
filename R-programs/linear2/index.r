set.seed(123)
x <- rnorm(100)
y <- 2*x + rnorm(100)
data <- data.frame(x=x, y=y)
model <- lm(y ~ x, data = data)
summary(model)
# visualizing
