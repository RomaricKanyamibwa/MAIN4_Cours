load("chiens.rda")
head(chiens)
summary(chiens)
str(chiens)#3 possib pour la taille
dim(chiens)#27 chiens et 7 var

library(FactoMineR)
tab.dis=tab.disjonctif(data)
dim(tab.dis)
#1
acm=MCA(chiens,quali.sup = 7,graph = F)#ou MCA(data)
summary(res)#Pour les valeurs propres le pourcentge n'est pas aussi eleve que pour le acp car en acm
#on a bcp de modalites (on garde au moins le 4 premiers)


#2
plot(acm,choix="ind",invisible="var",habillage=7)

#3
data=acm$ind$coord[,1:2]
Kmeans_classes<-function(k,data)
{
  kmeans.result0=kmeans(scale(data),k)
  return(kmeans.result0$tot.withinss/kmeans.result0$totss)
}
res=rep(NA,10)
for(i in 1:10)
{
  res[i]=Kmeans_classes(i,(data))
}
plot(1:10,res)#on s'arrete quand on a palier (au bout de 4 ou 5 classes on s'arrete)






#4
#a.
par(mfrow=c(1,3))
cah.acm<-HCPC(acm)

