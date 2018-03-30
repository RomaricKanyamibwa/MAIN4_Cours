
################# EX 1 : ACP versus AFD






######################## EX 2 : comparaison frontières de décision 

# 1er jeu : cas homoscédastique et équiprobable.
set.seed(1)
library(mvtnorm)
n=100
pop1 = rmvnorm(n, c(0,0), matrix(c(1,0,0,1),2))  
pop2 = rmvnorm(n, c(4,3), matrix(c(1,0,0,1),2))
X=rbind(pop1,pop2)   #taille (2n,2)
y=as.factor(c(rep("A",n),rep("B",n)))
donnees = data.frame(X,y)
head(donnees)

plot(X, pch=as.numeric(y), col=as.numeric(y))   
legend("bottomright", legend=c("classe1", "classe2"), pch=1:2, col=1:2)




library(MASS)
fit=lda(y~., data=donnees)
a=seq(min(X), max(X), length=100)
b=seq(min(X), max(X), length=100)
grille=NULL
    for (i in a) {grille=rbind(grille, cbind(i,b)) } 
colnames(grille)=c("X1","X2")

pred_grille_l = predict(fit, data.frame(grille))$class
plot(X, pch=as.numeric(y), col=as.numeric(y),lwd=2, main="LDA")
points(grille, col=pred_grille_l, cex=0.2)


pred_grille_geom = predict(fit, prior=c(0.5,0.5), data.frame(grille))$class
X11()
plot(X, pch=as.numeric(y), col=as.numeric(y),lwd=2,main="AFD")
points(grille, col=pred_grille_geom, cex=0.2)




############ 2er jeu : homscédastique et non équiprobable.
set.seed(2)
n=200
pop1 = rmvnorm(n, c(0,0), matrix(c(1,0,0,1),2))  #taille (n,2)
pop2 = rmvnorm(n/10, c(4,3), matrix(c(1,0,0,1),2))
X=rbind(pop1,pop2)   #taille (2n,2)
y=as.factor(c(rep("A",n),rep("B",n/10)))
donnees = data.frame(X,y)




############ 3 eme jeu  : hétéroscédastique
set.seed(2)
pop1 = rmvnorm(n, c(0,0), matrix(c(1,0,0,1),2))  #taille (n,2)
pop2 = rmvnorm(n, c(4,3), matrix(c(3,0,0,0.1),2))
X=rbind(pop1,pop2)   #taille (2n,2)
y=as.factor(c(rep("A",n),rep("B",n)))
donnees = data.frame(X,y)




######################## EX 3 : regression logistique


# Q7
pred=predict(res_AIC, data.frame(sbp=150, tobacco=10, ldl=5, adiposity=23, 
                famhist="Present", typea=70, obesity=25, alcohol=100, age=50) , type="response")
class=1*(pred>0.5)



# Q8
library(car)
crPlots(res_AIC)

vif(res_AIC)

#graphe 
par(mfrow=c(2,2))
plot(res_AIC)
# attention pas de diagnostic gaussien  !

# résidus de Pearson trop elevés ? 
abs(residuals(res_AIC,type="pearson"))[abs(residuals(res_AIC,type="pearson"))>2]
# résidus de deviance trop elevés ? 
abs(residuals(res_AIC,type="deviance"))[abs(residuals(res_AIC,type="deviance"))>2]

# points leviers ? 
infl = influence.measures(res_AIC)
leviers = infl$infmat[,"hat"]
p<-length(res_AIC$coefficients)
n<-nrow(donnees)
leviers[leviers > 3* p/n]



# Q9f)
library(ROCR)
pred_logit <- predict(res_train, donnees.test, type="response")
predictions_logit <- prediction( pred_logit,  donnees.test$chd)
perf_logit <- performance(predictions_logit , "tpr", "fpr" )
plot(perf)

AUC_logit <- performance(predictions_logit,"auc")@y.values[[1]]


# Q9g)
library(boot)
# définir l'erreur de classement comme une fonction entre les
              observations $Y$ et les classes prédites $class$  
cout <- function(Y, class)   {return(mean(abs(Y-class)>0.5))}

# estimation du taux d'erreur par CV
cv.glm(donnees, res_AIC, cout)$delta[1]




######################## EX 4 : arbre

# Q4
library(ROCR)
pred_cart = predict(arbre.opt_train, donnees.test, type="prob")[,2]  #2ème colonne donne classe 1
predictions_cart <- prediction( pred_cart,  donnees.test$chd)
perf_cart <- performance(predictions_cart , "tpr", "fpr" )
plot(perf_cart)
AUC_cart <- performance(predictions_cart,"auc")@y.values[[1]]


