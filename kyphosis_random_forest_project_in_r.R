#For this project we will be working with both Decision Trees and Random Forests

#Here we will be importing the kyphosis dataset, which is internal on R through the rpart library
#Kyphosis is a type of deformation post surgery
#Here we are importing the rpart library
library(rpart)

#Here we are creating our dataframe from the kyphosis dataset
#There are 81 observations of four variables
deformations = kyphosis


#Here is a look at the dataset
#The dependent variable is absent vs. present for kyphosis
#Currently they are encoded as 1-2. Usually we prefer 0-1
str(deformations)

#Here we are going to start building our decision tree
#We have our dependent variable Kyphosis whose outcome is proportional to the rest of the variables
#We chose method = 'class' since this is a classifcation model
#The data we are using for our model is the entire deformations dataset
tree <- rpart(Kyphosis ~ ., method = 'class', data = deformations)


#Let's explore our tree in-depth

#we will start with the printcp function
#It reports the method (Classifcation Tree)
#It reports the variables used in construction (Age and Start)
printcp(tree)


#Here we are plotting our decision tree
plot(tree, uniform=TRUE, main="Kyphosis Classification")
text(tree, use.n=TRUE, all=TRUE)

#There are other ways to plot your tree
#Let's first install the rpart.plot package
#install.packages('rpart.plot')

#Then import the rpart.plot library
library(rpart.plot)

#Here is a better diagram of the decision tree
prp(tree)




#Now we will be moving on to Random Forests to analyze our dataset
#Let's import the randomForest library
library(randomForest)


#Here we will build our Random Forest model
model = randomForest(Kyphosis ~ ., data = deformations)
#Here is just a brief look at the model
print(model)

#Here are the predictions the model made when we ran it
model$predicted

#Here are the amount of trees in our model
#We have 500, which is the default value
model$ntree

#You can even grab a confusion matrix from your model
model$confusion

#Here we are looking at which variables were the most important in making predictions
#Looks like Age > Number in terms of importance
importance(model)
