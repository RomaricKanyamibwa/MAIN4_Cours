load("chiens.rda")
head(chiens)
summary(chiens)
str(chiens)#3 possib pour la taille
dim(chiens)#27 chiens et 7 var

data=chiens[,1:6]
dim(data)

library(FactoMineR)
tab.dis=tab.disjonctif(data)
dim(tab.dis)

res=MCA(chiens,quali.sup = 7)#ou MCA(data)
summary(res)#Pour les valeurs propres le pourcentge n'est pas aussi eleve que pour le acp car en acm
#on a bcp de modalites (on garde au moins le 4 premiers)

plot(res)
#les gros chiens pas affectueux/rapide
#petits chiens affectueux! /lents

names(res)
res$var$contrib
res$ind$cos2

#chien de compagnie est un chien de petit taille,poids affectueux 