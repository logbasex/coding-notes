## [How to Extract the Intercept from a Linear Regression Model in R](https://www.geeksforgeeks.org/how-to-extract-the-intercept-from-a-linear-regression-model-in-r/)

Linear regression is a method of predictive analysis in machine learning. It is basically used to check two things:

- If a set of **predictor variables (independent)** does a good job predicting the **outcome variable (dependent)**.
- Which of the predictor variables are significant in terms of predicting the outcome variable and in what way, which is determined by the magnitude and sign of the estimates respectively.

Linear regression is used with one outcome variable and one or more than one predictor variable. Simple linear regression will work with one outcome and one predictor variable. The simple linear regression model is essentially a linear equation of the form `y = c + b*x`; **where `y` is the dependent variable (outcome), `x` is the independent variable (predictor), `b` is the slope of the line; also known as `regression coefficient` and `c` is the `intercept`; labeled as constant**.

> y = b*x + c
>  
> c : intercept
>  
> b : regression coefficient

A linear regression line is a line that best fits the graph between the predictor variable (independent) and the predicted variable (dependent).