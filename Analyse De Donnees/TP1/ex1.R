#Analyse descriptive

data=read.table("notes_ACP.txt")
head(data)#on verifie que la table est bien une table bien structuré

summary(data)
boxplot(data)


pairs(data)#Math pysique sont correlés et anglais français aussi.

length(data)

covariance=(length(data)-1)/length(data)*cov(data)

#correlation 
cor(data)

#moyenne empirique
apply(data,2,mean)


#variance empirique
apply(data,2,var)


#ACP-------------------------------------------------------------------------------------
X=scale(data,center = TRUE,scale = FALSE)

n=9
Eigen=eigen((n-1)/n*cov(X))
Valuer_propre=Eigen$values#Matrice S de covariance
Vecteur_propre=Eigen$vectors
#Inertie It
It_mat_cov=sum(diag((n-1)/n*cov(X)))#Inertie avec matrice de covariance 
It=sum(diag(Valuer_propre))#avec valeurs propres
It
It_mat_cov

#Part d'inertie
Part_It=Valuer_propre/It
Part_It#[1] 0.7004669429 0.2984607138 0.0008095538 0.0002627896 (donc on garde que les 2 premiers 
#axes qui contribuent à 99%)

#Methode des ébouilis
plot(Valuer_propre/It,type = "b")#on garde les 2 premiers 

#ACP avec princomp------------------------------------------------------------------------


pca.notes=princomp(data)

Val_p=(pca.notes$sdev)^2
Vect_p=(pca.notes$loadings)
Val_p
Valuer_propre
Vecteur_propre
Vect_p

#3.c
summary(pca.notes)
plot(pca.notes)

plot(pca.notes,type='l')
#On observe que les 2 premiers composant sont le pus significatifs.


#Question 4

#les composantes principales
C=pca.notes$scores
#representation dans le plan principal
plot(C[,1:2],type = "n",xlab = "PC1",ylab = "PC2")
text(C[,1:2],labels = row.names(data),cex = 1.5)
title(main="Projection sur les 2 premiers axes principaux")
#lines(c(min(C[,1]),c(max(C[,1])))


#Question 5 qualites de representation

norm=function(x){return(sum(x^2))}
cos2=cbind(C[,1]^2/apply(X,1,norm),C[,2]^2/apply(X,1,norm))
cos2

rowSums(cos2)

#Question 6 contribution


#FACTOMineR

library(FactoMineR)



