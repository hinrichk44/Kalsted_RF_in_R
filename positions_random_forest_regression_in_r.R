#Here we are running a Random Forest Regression in R
#Very similar to Decision Tree Regression


#Here we are importing our dataset
#We have 10 observations of three variables
#We have a person's position, level, and salary
salaries = read.csv('positions.csv')


#Here we will remove the Position column since it's redundant with Level
salaries =  salaries[2:3]


#Here we will start to fit the Random Forest Regressor to the dataset

#First we must install the randomForest package
#install.packages('randomForest')

#Now we will import the randomForest library
library(randomForest)

#We are setting the seed so we get consistent results
set.seed(1234)

#Officially creating our regressor
#X can be a dataframe or matrix
#y must be a vector!!! The dollar sign creates that vector
#We're going to start with 10 trees in our forest
regressor = randomForest(x = salaries[1], y = salaries$Salary, ntree = 10)



#Now we will visualize our Random Forest results
#First we import the ggplot2 library
library(ggplot2)

#Here we will initialize the plot for our Random Forest Regression, but with x_grid
#By having several trees instead of one like DTR, we get more "steps" in our graph
#The more trees we add, the more steps we get, because the average of the trees will converge to the actual value
x_grid = seq(min(salaries$Level), max(salaries$Level), 0.1)
ggplot() +
  geom_point(aes(x = salaries$Level, y = salaries$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('Random Forest Regression)') +
  xlab('Level') +
  ylab('Salary')