data=read.table("fromage.txt",header = T,row.names = 1)
head(data)#on verifie que la table est bien une table bien structuré
attach(data)


#Q2 method CAH

hc<- hclust(dist(data))#hc<- hclust(dist(data2),method = "ward.D2")
plot(hc,hang=-1)

# b)on centre et reduit avec scale
data2=scale(data)
hc<- hclust(dist(data2),method = "ward.D2")
hc
par(mfrow=c(2,2))

plot(hc,hang=-1)
hc<- hclust(dist(data2),method = "single")#à evitetr
hc
plot(hc,hang=-1)
hc<- hclust(dist(data2),method = "complete")
hc
plot(hc,hang=-1)
hc<- hclust(dist(data2),method = "average")
hc
plot(hc,hang=-1)



#c)
hc<- hclust(dist(data2),method = "ward.D2")
par(mfrow=c(1,2))
barplot(hc$height)#pour determiner combien de groupe nous allons faire
#on regarde barblot 
plot(hc,hang=-1)
rect.hclust(hc,k=5)#on fait 5 group on regardant l'histogramme et le dendrogramme
groups<- cutree(hc,k=4)
groups5<- cutree(hc,k=5)
table(groups,groups5)


data[groups5==1,]#les fromages du groupe 1 et leurs caracteristique
colMeans(data[groups5==1,])
colMeans(data[groups5==2,])
colMeans(data[groups5==3,])
colMeans(data[groups5==4,])
colMeans(data[groups5==5,])
which(groups5==5)#les fromage qui se trouvent dans le groupe 5
which(groups5==3)


#Q3.a)

kmeans.result=kmeans(scale(data),5)#on scale pour centre-reduire les données
kmeans.result$size

#b)les tailles de groupe changent parce que chaque fois 
#on prend des groupes de taille different 

#3c)
data2=scale(data)
hc<- hclust(dist(data2),method = "ward.D2")
hc$labels
groups5<- cutree(hc,k=5)
gr1=colMeans(data2[groups5==1,])
gr2=colMeans(data2[groups5==2,])
gr3=colMeans(data2[groups5==3,])
gr4=colMeans(data2[groups5==4,])
gr5=colMeans(data2[groups5==5,])
gravity=rbind(gr1,gr2,gr3,gr4,gr5)

#Kmeans travaille sur des données centre et reduit!!
means.result=kmeans(scale(data),centers = gravity,5)#on scale pour centre-reduire les données
kmeans.result$size

#d)
kmeans.result$withinss#Inertie intra class pour chacune de class
kmeans.result$tot.withinss#sum(kmeans.result$withinss)  Inertie totale intra class
kmeans.result$betweenss#inertie inter-classe
kmeans.result$totss#(inertie totale)

means.result=kmeans(scale(data),nstart = 100,5) #on obtient la mếme chose que avec
# center= gravity mais avec un ordre different
means.result
kmeans.result$withinss#Inertie intra class pour chacune de class
kmeans.result$tot.withinss#sum(kmeans.result$withinss)  Inertie totale intra class
kmeans.result$betweenss#inertie inter-classe
kmeans.result$totss#(inertie totale)

#e)

table(groups5,kmeans.result$cluster)
#les groupes obtenus ne sont pas les mêmes.

#f
#on met un nombre entre 2 et 10!!

Kmeans_classes<-function(k,data)
{
  kmeans.result0=kmeans(scale(data),k)
  return(kmeans.result0$tot.withinss/kmeans.result0$totss)
}
res=rep(NA,10)
for(i in 1:10)
{
  res[i]=Kmeans_classes(i,scale(data))
}
plot(1:10,res)#on s'arrete quand on a palier (au bout de 4 ou 5 classes on s'arrete)

#4
means.result=kmeans(data,nstart = 100,5)
pairs(means.result,col=kmeans.result$cluster)
