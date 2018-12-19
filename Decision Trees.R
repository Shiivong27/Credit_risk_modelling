# Decision Trees

library(rpart) # making decision trees.
library(rpart.plot) # for plotcp and princp functions.
library(rattle)
library(RColorBrewer) # for great decision tree plots
 
# Undersampling the training_set

undersampled_training_set <- read_excel("undersampled_training_set.xlsx")

tree_undersample <- rpart(`loan_status `  ~., method = "class",
                          data = undersampled_training_set,
                          control = rpart.control(cp = 0.001)) # our first decision tree

printcp(tree_undersample)

plotcp(tree_undersample)

tree_min_undersample <- tree_undersample$cptable[which.min(tree_undersample$cptable[,"xerror"]),"CP"]

ptree_undersample <- prune(tree_undersample, cp = tree_min_undersample)

fancyRpartPlot(tree_undersample)

pred_undersample <- predict(ptree_undersample, newdata = test_set, type = "class") # making predictions.

confmat_undersample <- table(test_set$` loan_status `,pred_undersample) # making the confusion matrix.

acc_undersample <- sum(diag(confmat_undersample)) / sum(confmat_undersample)

# Changing the prior probabilities of loan default and non-loan default

tree_prior <- rpart(` loan_status ` ~., method = "class",
                    data = training_set,
                    parms = list(prior = c(0.7,0.3)), # changing the probabilities of non loan default to 0.7
                    control = rpart.control(cp = 0.001)) # and loan default to 0.3

fancyRpartPlot(tree_prior)

printcp(tree_prior) # cp and xerror values.

plotcp(tree_prior) # cp vs xerror plot.

tree_min <- tree_prior$cptable[which.min(tree_prior$cptable[,"xerror"]),"CP"]

# pruning the tree for increased model performance.

ptree_prior <- prune(tree_prior, cp = tree_min) # pruning the tree.

prp(ptree_prior)

## don't forget to display the interactive plots.

pred_prior <- predict(ptree_prior, newdata = test_set, type = "class") # making predictions.

confmat_prior <- table(test_set$` loan_status `,pred_prior) # making the confusion matrix.

acc_prior <- sum(diag(confmat_prior)) / sum(confmat_prior)

prp(ptree_prior)

# Including a loss matrix

tree_loss_matrix <- rpart(` loan_status ` ~., method = "class",
                          data = training_set,
                          parms = list(loss = matrix(c(0,10,1,0),ncol = 2)),
                          control = rpart.control(cp = 0.001))  #penalizing classifying a default
                                                                # as a non default 10 times more.
printcp(tree_loss_matrix)

plotcp(tree_loss_matrix)

tree_min_loss_matrix <- tree_loss_matrix$cptable[which.min(tree_loss_matrix$cptable[,"xerror"]),"CP"]

ptree_loss_matrix <- prune(tree_loss_matrix, cp = 0.0012788)

fancyRpartPlot(tree_loss_matrix)

## don't forget to display the interactive plots.

pred_loss_matrix <- predict(ptree_loss_matrix,newdata = test_set, type = "class")

confmat_loss_matrix <- table(test_set$` loan_status `,pred_loss_matrix)

acc_loss_matrix <- sum(diag(confmat_loss_matrix)) / sum(confmat_loss_matrix)


# including case weights for the training set

case_weights <- ifelse(training_set$` loan_status ` == 0,1,3)

tree_weights <- rpart(` loan_status ` ~ ., method = "class", 
                      data = training_set, 
                      control = rpart.control(cp = 0.001,minsplit = 5,minbucket = 2),
                      weights = case_weights)

plotcp(tree_weights)
prp(tree_weights)

tree_min_weights <- 0.00183101


ptree_weights <- prune(tree_weights, cp = tree_min_weights)

prp(ptree_weights,extra = 1)

pred_weights <- predict(ptree_weights, newdata = test_set,type = "class")

confmat_weights <- table(test_set$` loan_status `,pred_weights)

acc_weights <- sum(diag(confmat_weights)) / nrow(test_set)






