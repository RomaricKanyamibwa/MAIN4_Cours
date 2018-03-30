data=read.csv("Presidentielle.CSV",row.names = 1)
head(data)#on verifie que la table est bien une table bien structuré

summary(data)

attach(data)


#piechart for candidates (2 for columns and 1 for lines)
pie(apply(data,2,sum))

#piechart for region
pie(apply(data,1,sum))#iles de france et Rhone-alpes les plus/le moins


#3 test de khi-deux
chisq.test(data)#on rejette H0 car pvalue<5% donc les 2 variables sont liées


#4
library(FactoMineR)
res=CA(data)
res$eig #on garde les 4 premiers valeurs propres (dimensions) car ils contribuent à 91%
res$col$contrib #contributions de candidats , la contribution sur chaque axe


plot(res,axes = c(1,3))#on change les axes on met la dim3 au lieu de dim2
summary(res)
#region
res$row$contrib
res$row$cos2#si cest prs de 1 cest bien represente

#5
res1=CA(data,row.sup = 23,col.sup = c(11,12))
res1$col$contrib
#sur laxe 1 lepen et Bayrou contribue le plus
#picardie a beaucoup voté pour lepen (cos2>0.8)
#bretagne n'a pas  beaucoup voté pour lepen (cos2>0.8)
res1$row$cos2

#En paca ils ont voté en majorite Sarkozy et lepen (les candidats les plus proche à paca)

#b) on a droit de parler d'une region si leurs point sont bien representes.
#un point est bien represente sur le plan si la somme de leur cos est  proche de 1

#c)Picardier et Nord Pdc  se resemblent car ils sont proche l'un à lautre
#et leurs sommes de cos2 dim1 et cos2dim2 sont près de 1 


#e)Lepen et Royal


plot(res1,selectRow = "cos2 0.8",selectCol = "cos2 0.8")#on garde les données bien representes
plot(res1,selectRow = "contrib 2",selectCol = "contrib 2")#les données qui contribuent
