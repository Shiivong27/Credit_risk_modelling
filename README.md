# Credit Risk Modelling To Predict Loan Defaults

In this project, I have addressed the problem of classifying highly unbalanced data using supervised machine learning algorithms. Unbalanced data is ubiquitous in nature, it’s dealt with in a wide range of fields including but not limited to that of business, bioinformatics, engineering and banking sector. We have focussed here on Credit Risk, which is defined as risk of default on a debt that may arise from a borrower failing to make required payments. 

In the first resort, the risk is that of the lender and includes lost principal and interest, disruption to cash flows, and increased collection costs. Usually in a Credit Risk problem, loan default is a rare phenomenon and that is why we have such unbalanced data.


Logistic Regression And Model Performance :

In statistics, logistic regression, or logit regression, or logit model is a regression model where the dependent variable (DV) is categorical.Logistic regression measures the relationship between the categorical dependent variable and one or more independent variables by estimating probabilities using a logistic function, which is the cumulative logistic distribution.

Thus, it treats the same set of problems as probit regression using similar techniques with the latter using a cumulative normal distribution curve instead. Equivalently, in the latent variable interpretations of these two methods, the first assumes a standard logistic distribution of errors and the second a standard normal distribution of errors.

Logistic regression can be seen as a special case of the generalized linear model and thus analogous to linear regression. The model of logistic regression, however, is based on quite different assumptions (about the relationship between dependent and independent variables) from those of linear regression. In particular the key differences of these two models can be seen in the following two features of logistic regression.

First, the conditional distribution, is a Bernoulli distribution rather than a Gaussian distribution, because the dependent variable is binary. Second, the predicted values are probabilities andarethereforerestrictedto(0,1)throughthelogisticdistributionfunctionbecauselogistic regression predicts the probability of particular outcomes.


CLASSIFICATION AND REGRESSION TREES :

What is CART?

Decision tree learning uses a decision tree as a predictive model which maps observations about an item to conclusions about the item’s target value. It is one of the predictive modelling approaches used in statistics, data mining and machine learning. Tree models where the target variable can take a finite set of values are called classification trees.

In these tree structures, leaves represent class labels and branches represent conjunctions of features that lead to those class labels. Decision trees where the target variable can take continuous values (typically real numbers) are called regression trees. Decision tree learning is a method commonly used in data mining. The goal is to create a model that predicts the value of a target variable based on several input variables.

-PRIOR PROBABILITIES

In this technique, we will explicitly define the probabilities of defaults and non-defaults, such that the CART model knows when to classify the observation as a default.

-LOSS MATRIX :

In this technique, I will penalize our model everytime it classifes a default as a non-default or a non-default as a default. This is a very strict model and most of the times we won’t get desired results.

-WEIGHING :

In this technique, we weight the important default cases and tell our program to refer to them when classifying.


R packages used:

- readxl
- gmodels
- ggplot2
- ROCR
- pROC
- rpart
- rpart.plot
- rattle
- RColorBrewer
