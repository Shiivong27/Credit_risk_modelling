
# Data Preprocessing and Data Visualization

library(readxl) # loading the excel package

library(gmodels)

library(ggplot2)

loan_data <- read_excel("loan_data.xlsx") # loan_data is our data set

str(loan_data)

histogram <- hist(loan_data$loan_amnt, breaks = 200, xlab = "Loan Amount", 
               main = "Histogram of the Loan Amount",col = "red")

loan_data$` loan_status ` <- factor(loan_data$` loan_status `)

CrossTable(loan_data$` loan_status `)

CrossTable(loan_data$` home_ownership `)

Cross <- CrossTable(loan_data$` home_ownership `,loan_data$` loan_status `,
                    prop.r = TRUE,prop.c = FALSE,prop.t = FALSE,prop.chisq = FALSE)

Cross1 <- CrossTable(loan_data$grade,loan_data$` loan_status `,
                     prop.r = TRUE,prop.c = FALSE,prop.t = FALSE,prop.chisq = FALSE) 

plot(Cross$prop.tbl,col = c("bisque2","azure3"),main = "Proportions of Default/Non-Default wrt Ownership"
     ,xlab = "Grade of the customer",ylab = "1 - Default    0 - Non-default")

plot(Cross1$prop.tbl,col = c("cornflowerblue","chartreuse3"),main = "Proportions of Default/Non-Default wrt Grade"
     ,xlab = "Grade of the customer",ylab = "1 - Default    0 - Non-default")

summary(loan_data$`emp_length `) # finding the number of missing data in emp_length

summary(loan_data$int_rate) # finding the number of missing data in int_rate 

loan_data$ir_cat <- rep(NA, length(loan_data$int_rate)) # making a null column

loan_data$ir_cat[which(loan_data$int_rate <= 8)] <- "0-8"
loan_data$ir_cat[which(loan_data$int_rate > 8 & loan_data$int_rate <= 11)] <- "8-11"
loan_data$ir_cat[which(loan_data$int_rate > 11 & loan_data$int_rate <= 13.5)] <- "11-13.5"
loan_data$ir_cat[which(loan_data$int_rate > 13.5)] <- "13.5+"
loan_data$ir_cat[which(is.na(loan_data$int_rate))] <- "Missing"

loan_data$ir_cat <- as.factor(loan_data$ir_cat) # converting into categories

plot(loan_data$ir_cat,xlab = "Interest rate categories",ylab = "Count") # visualizing the propportions

loan_data$emp_cat <- rep(NA, length(loan_data$`emp_length `)) # making a null column

loan_data$emp_cat[which(loan_data$`emp_length ` <= 15)] <- "0-15"
loan_data$emp_cat[which(loan_data$`emp_length ` > 15 & loan_data$`emp_length ` <= 30)] <- "15-30"
loan_data$emp_cat[which(loan_data$`emp_length ` > 30 & loan_data$`emp_length `<= 45)] <- "30-45"
loan_data$emp_cat[which(loan_data$`emp_length `> 45)] <- "45+"
loan_data$emp_cat[which(is.na(loan_data$`emp_length `))] <- "Missing"

loan_data$emp_cat <- as.factor(loan_data$emp_cat)

plot(loan_data$emp_cat,xlab = "Employee length categories",ylab = "Count")

loan_data$int_rate <- NULL

loan_data$`emp_length ` <- NULL

new <- ggplot(loan_data, aes(x = factor(` loan_status `), fill = grade))

val = c("lightcyan2", "lightcyan3","lightblue","lightcyan4","cadetblue3","aquamarine","darkblue")
lab = c("A","B","C","D","E","F","G")
new + geom_bar(position = "dodge",alpha = 0.75) + 
      scale_x_discrete("Loan Status") +
      scale_y_continuous("Count") +
      scale_fill_manual("Grades",values = val,labels = lab)

ggplot(loan_data, aes(x = factor(` loan_status `), fill = grade)) + geom_bar(position = "fill")

ggplot(loan_data,aes(x = annual_inc,y = ir_cat)) + geom_point() +
  facet_grid(grade ~ .)

# scale down loan_data$annual_inc first



color <- scale_fill_brewer("Loan Grades",palette = "Reds")

loan_new <- loan_data

loan_new$annual_inc <- loan_new$annual_inc/10000

ggplot(loan_new,aes(x = annual_inc,fill = factor(grade))) + 
  geom_histogram(binwidth = 1) + color + facet_grid(grade ~. )



