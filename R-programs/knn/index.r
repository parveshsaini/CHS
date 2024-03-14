library(ggplot2)
library(class)
library(caret)
data(mtcars)
# Preprocessing: Normalize the dataset
preprocessParams <- preProcess(mtcars, method=c("center", "scale"))
mtcarsNorm <- predict(preprocessParams, mtcars)
# Feature Selection:
features <- mtcarsNorm[,1:10]
# Target variable: predict 'am' (Automatic or Manual transmission)
target <- mtcars$am
set.seed(123)
trainIndex <- createDataPartition(target, p=0.8, list=FALSE)
trainData <- features[trainIndex,]
testData <- features[-trainIndex,]
trainLabels <- target[trainIndex]
testLabels <- target[-trainIndex]
# Training the k-NN model
knnModel <- knn(train=trainData, test=testData, cl=trainLabels, k=3)
ggplot(mtcars, aes(x=mpg, y=hp, color=factor(am))) + geom_point() +
labs(color="Transmission (0=Automatic, 1=Manual)")
confusionMatrix(table(knnModel, testLabels))