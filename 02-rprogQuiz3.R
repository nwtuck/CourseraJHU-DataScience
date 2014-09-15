library(datasets)
data(iris)

?iris

iris

## mean of 'Sepal.Length' for the species virginica
mean(iris[iris$Species=="virginica","Sepal.Length"])

## returns a vector of the means of the variables 
## 'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width'
## MARGIN=2, removes rows
apply(iris[, 1:4], 2, mean)

library(datasets)
data(mtcars)

mtcars

## calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)
with(mtcars, tapply(mpg, cyl, mean))

## absolute difference between the average horsepower of 4-cylinder cars and 
## the average horsepower of 8-cylinder cars
x <- with(mtcars, tapply(hp, cyl, mean))
tail(x,n=1)-head(x, n=1)

