load("DataLubischew.Rdata")
data=DataLubischew()
head(data)
X=data[,1:6]
Y=data[,7]#especes
is.factor(Y)
Y=as.factor(Y)
#2.ACP-------------------------------------------------------------------------------------
#FACTOMineR

library(FactoMineR)
pca<-PCA(X)

#2.c
plot(pca,col.ind=Y)

#3. AFD

library(MASS)
afd=lda(X,grouping=Y)
afd$scaling

plot(afd)

K=nlevels(Y)#nombre de classes, on a K classes donc on attend K-1 axes
pred=predict(afd,prior=rep(1,K)/K)
C.afd=pred$x

#a.il y a K-1=2 axes
#b. 
afd #on voit que le axe LD1 explique à 82% nos  données

#c.oui afd nous donne une meilleieure discrimination

#d
newdata=data.frame(M1=175,M2=125,M3=51,M4=140,M5=14,M6=104)
pred.new=predict(afd,newdata,prior=rep(1,K)/K)
pred.new#new.data appartient au premier groupe



