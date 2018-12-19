# Logistic Regression


library(ROCR)
library(pROC)

index_train <- sample(1:nrow(loan_data), 2 / 3* nrow(loan_data)) # making a random sample of training set.

training_set <- loan_data[c(index_train), ] # storing the random sample in a training set.

test_set <- loan_data[-index_train, ]




# Let's start playing around with logistic regression.


log_reg_small <- glm(` loan_status ` ~ ir_cat + grade + loan_amnt + annual_inc,
                     family = "binomial", data = training_set)

summary(log_reg_small) # estimating the vaiable's of importance in our model. Loan amount is not significant.

predictions_small <- predict(log_reg_small, newdata = test_set,
                              type = "response")                

range(predictions_small) # getting the range of the probabilities calculated above.

pred_cutoff_15_small <- ifelse(predictions_small > 0.15,1,0)

conf_15_small <- table(test_set$` loan_status `,pred_cutoff_15_small)

accuracy_15_small <- sum(diag(conf_15_small))/sum(conf_15_small)

pred_cutoff_20_small <- ifelse(predictions_small > 0.20,1,0)

conf_20_small <- table(test_set$` loan_status `,pred_cutoff_20_small)

accuracy_20_small <- sum(diag(conf_small_20))/sum(conf_small_20)

pred_train_small <- predict(log_reg_small,type = "response")

predROC_small <- prediction(pred_train_small, training_set$ ` loan_status `)

perfROC_small <- performance(predROC_small,"tpr","fpr")

plot(perfROC_small, colorize = TRUE,
     print.cutoffs.at = seq(0,1,0.1),text.adj = c(-0.2,1.7))

AUC_small <- as.numeric(performance(predROC_small , "auc")@y.values)


# some new shit

predROC_small <- roc(test_set$` loan_status `,predictions_small)

# some new shit






log_reg_full <- glm(` loan_status ` ~., family = "binomial", data = training_set)

summary(log_reg_full)

predictions_full <- predict(log_reg_full, newdata = test_set, type = "response")

range(predictions_full)

pred_cutoff_15 <- ifelse(predictions_full > 0.15,1,0)

confmat_15_full <- table(test_set$` loan_status `,pred_cutoff_15)

accuracy_15 <- sum(diag(confmat_15_full))/sum(confmat_15_full)

pred_cutoff_20 <- ifelse(predictions_full > 0.20,1,0)

confmat_20_full <- table(test_set$` loan_status `,pred_cutoff_20)

accuracy_20 <- sum(diag(confmat_20_full))/sum(confmat_20_full)

pred_train_full <- predict(log_reg_full,type = "response")

predROC_full <- prediction(pred_train_full, training_set$ ` loan_status `)

perfROC_full <- performance(predROC_full,"tpr","fpr")

plot(perfROC_full, colorize = TRUE,
     print.cutoffs.at = seq(0,1,0.1),text.adj = c(-0.2,1.7))

AUC_full <- as.numeric(performance(predROC_full , "auc")@y.values)








