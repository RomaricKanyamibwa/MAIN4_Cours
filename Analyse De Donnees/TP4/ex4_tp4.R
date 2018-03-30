#Q1
data=read.table("SAheart.data",sep=",",header = T,row.names = 1)
head(data)
str(data)#type des variables
summary(data)
is.factor(data[,5])#variable qualitative
is.factor(data[,10])
data$chd=as.factor(data$chd)
attach(data)

#a)
library(rpart)
arbre=rpart(chd~.,data)
print(arbre)
summary(arbre)

#c)
plot(arbre,uniform=TRUE)
text(arbre,all=TRUE,use.n = TRUE ,fancy = TRUE)

#d)minsplit nombre d'observation ,minbucket=nombre minimal dans la feuille (par defaut minsplit/3

#Q2) ici on change le cp de l'arbre par defat 0
plotcp(arbre)

