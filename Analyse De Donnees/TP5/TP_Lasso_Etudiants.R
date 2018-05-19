############ EXO 1

load("Desbois_complet.rda")     

#Q1
head(data)
str(data)
install.packages("glmnet")
data$DIFF=as.factor(data$DIFF)
set.seed(30)
test.ratio <- .2 
n=nrow(data)
n.test <- ceiling(n*test.ratio)
tr <- sample(1:n,n.test)
train <- data[-tr,]
test <- data[tr,]



## reg logit avec toutes variables 
res_logit <- glm(DIFF~.,family=binomial,data=train)


## step AIC
library(MASS)
res_AIC <- step(res_logit)  #backward par defaut
summary(res_AIC)


## Lasso : 
library(glmnet)
res_Lasso <- glmnet(as.matrix(train[,-1]),train$DIFF,family='binomial')  
par(mfrow=c(1,3))
plot(res_Lasso, label = TRUE)
plot(res_Lasso, xvar = "dev", label = TRUE)
plot(res_Lasso, xvar = "lambda", label = TRUE)

sum(coef(res_Lasso,s=exp(-8))!=0)
sum(coef(res_Lasso,s=exp(-6))!=0)
sum(coef(res_Lasso,s=exp(-5))!=0)
sum(coef(res_Lasso,s=exp(-2))!=0)

error_rate<- function(y_pred,y_test){return(mean(y_pred!=y_test))}
pred=predict(res_Lasso,newx =as.matrix(test[,-1]),s=exp(-4),type = "class")
error_rate(pred,test$DIFF)
predict.glmnet(res_Lasso,newx = as.matrix(test[,-1]))
## ridge
cvLasso <- cv.glmnet(as.matrix()) #cv = colette voisembert



## Boxplot
B <- 30
err_Lasso <- rep(NA,B)
err_AIC <- rep(NA,B)
err_ridge <- rep(NA,B)

for (b in 1:B)
{ tr <- sample(1:n,n.test)
  train <- data[-tr,]
  test <- data[tr,]

 # AIC
 res_logit <- glm(DIFF~ ., family = binomial,data=train)
 res_AIC <- step(res_logit,trace = 0)  
 pred_AIC <- predict(res_AIC, newdata=test, type="response")
 class_AIC <- as.factor(1*(pred_AIC >1/2))
 err_AIC[b] <- error_rate(class_AIC,test$DIFF)


 # Lasso
 cvLasso <- cv.glmnet(as.matrix(train[,-1]),train$DIFF,family="binomial", type.measure = "class") 
 pred=predict(cvLasso, newx = as.matrix(test[,-1]), s = 'lambda.min', type = "class")
 err_Lasso[b] <-  error_rate(as.factor(pred),test$DIFF)

 # ridge
 cvridge <- cv.glmnet(as.matrix(train[,-1]),train$DIFF,family="binomial", type.measure =  "class",alpha=0) 
 pred=predict(cvridge, newx = as.matrix(test[,-1]), s = 'lambda.min', type = "class")
 err_ridge[b] <- error_rate(as.factor(pred),test$DIFF)
}

err_test <- data.frame(AIC=err_AIC,Lasso=err_Lasso, ridge=err_ridge)
boxplot(err_test,main="Erreurs test pour 30 decoupages")
 



#bravo !!!!!!!!!!!!!!!!!!trop fort !!!!!!!!!!!!!!!!! wahooooo !!!!############ EXO 2

library(sda)
data(singh2002)
X=singh2002$x
Y=singh2002$y

