#For this project we will be using Random Forest CLASSIFICATION


#Here we are importing the dataset and selecting the relevant columns for analysis
social = read.csv('Social_Network_Ads.csv')
social = social[3:5]

#Here we are encoding the target feature as factor
#We are doing this because of classification. Target variable must be 1-0
social$Purchased = factor(social$Purchased, levels = c(0, 1))

#Here we are splitting the dataset into the Training set and Test set
#First we import the caTools library that allows us to split the data
library(caTools)

#We are setting the seed so we get consistent results
set.seed(123)

#Officially splitting the data. 75% split
split = sample.split(social$Purchased, SplitRatio = 0.75)
training_set = subset(social, split == TRUE)
test_set = subset(social, split == FALSE)

#Here we are applying Feature Scaling to our split dataset
#We are selecting all of the columns except the last one, hence -3
training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])



#Here we are fitting RFC to the Training set
#First we import the randomForest library
library(randomForest)

#Now we set up our RFC classifier
#No need for formula = y~x
#We will start with 10 trees in our forest
classifier = randomForest(x = training_set[-3],
                          y = training_set$Purchased,
                          ntree = 10)


#Here we are predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-3])


#Here we are making the Confusion Matrix
cm = table(test_set[, 3], y_pred)



#Visualizing the Training set results
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, newdata = grid_set)
plot(set[, -3],
     main = 'RFC (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))




#Visualizing the Test set results
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, newdata = grid_set)
plot(set[, -3], main = 'RFC (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))