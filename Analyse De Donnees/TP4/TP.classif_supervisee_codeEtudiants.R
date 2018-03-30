
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

head(donnees)

plot(X, pch=as.numeric(y), col=as.numeric(y))   
legend("bottomright", legend=c("classe1", "classe2"), pch=1:2, col=1:2)

library(MASS)
fit=lda(y~., data=donnees)
a=seq(min(X), max(X), length=n)
b=seq(min(X), max(X), length=n)
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



############ 3 eme jeu  : hétéroscédastique
set.seed(2)
pop1 = rmvnorm(n, c(0,0), matrix(c(1,0,0,1),2))  #taille (n,2)
pop2 = rmvnorm(n, c(4,3), matrix(c(3,0,0,0.1),2))
X=rbind(pop1,pop2)   #taille (2n,2)
y=as.factor(c(rep("A",n),rep("B",n)))
donnees = data.frame(X,y)

head(donnees)

plot(X, pch=as.numeric(y), col=as.numeric(y))   
legend("bottomright", legend=c("classe1", "classe2"), pch=1:2, col=1:2)

fit=lda(y~., data=donnees)
a=seq(min(X), max(X), length=n)
b=seq(min(X), max(X), length=n)
grille=NULL
for (i in a) {grille=rbind(grille, cbind(i,b)) } 
colnames(grille)=c("X1","X2")

pred_grille_l = predict(fit, data.frame(grille))$class
plot(X, pch=as.numeric(y), col=as.numeric(y),lwd=2, main="LDA")
points(grille, col=pred_grille_l, cex=0.2)

X11()
fit_q=qda(y~., data=donnees)
pred_grille_q = predict(fit_q, data.frame(grille))$class
plot(X, pch=as.numeric(y), col=as.numeric(y),lwd=2, main="LDA")
points(grille, col=pred_grille_q, cex=0.2)

library(klaR)
partimat(y~.,data=donnees,method="lda")
partimat(y~.,data=donnees,method="qda")

