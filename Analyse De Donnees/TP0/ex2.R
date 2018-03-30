data=read.table("anova2.txt")
head(data)#on verifie que la table est bien une table bien structuré
#complet si on n'a pas de plan de donnes qui manquent
#equilibre: meme nombre d'elements
#on prefere des donnees equilibre et complet pour avoir une experience non-biaisé

is.factor(data$variete)#true
is.factor(data$lux)#false
data$lux=as.factor(data$lux)
is.factor(data$lux)
attach(data)
lux
variete
RC

#courte analyse descriptive
boxplot(RC~lux)
points(tapply(RC,lux,mean))

boxplot(RC~variete)
points(tapply(RC,variete,mean))


#modele   anova2  avec le terme d'interaction
res=lm(RC~variete*lux,contrasts = c("contr.treatment","contr.treatment"))
par(mfrow=c(2,2))
plot(res)

#Q2
res=lm(log(RC)~variete*lux,contrasts = c("contr.treatment","contr.treatment"))
par(mfrow=c(2,2))
plot(res)


#Q3
shapiro.test(res$residuals)#pvalue >5% donc on garde H0, nos données semble gaussien

bartlett.test(res$residuals~variete)#pvalue> 5% on garde H0 ,les residues semble
bartlett.test(res$residuals~lux)#pvalue> 5% on garde H0

#Q4
summary(res)


#TESTS de FIsher
library(car)
Anova(res)
anova(res)

#4
resBon=lm(log(RC)~variete+lux)
summary(resBon)


#5



#APPLICATION!!
data2=read.table("fertilisation.rotation.txt")
head(data2)#on verifie que la table est bien une table bien structuré
is.factor(data2$fertilisation)#False
is.factor(data2$rotation)#True
#On a le droit de mettre le * fois quand nos données ne sont pas repetitifs
data2$fertilisation=as.factor(data2$fertilisation)
attach(data2)
#courte analyse descriptive
boxplot(rendement~fertilisation)
points(tapply(rendement,fertilisation,mean))

boxplot(rendement~rotation)
points(tapply(rendement,rotation,mean))

res3.0=lm(rendement~fertilisation*rotation,contrasts = c("contr.treatment","contr.treatment"))
par(mfrow=c(2,2))
plot(res3.0)

res3=lm(log(rendement)~fertilisation*rotation)
par(mfrow=c(2,2))
plot(res3)
abs(rstudent(res3))[abs(rstudent(res3))>2]
data3=data2[-c(6,15)]
attach(data3)
res4=lm(log(rendement)~fertilisation*rotation)
par(mfrow=c(2,2))
plot(res4)


shapiro.test(res4$residuals)#les residues semblent etre gaussien
bartlett.test(res4$residuals~fertilisation)#pvalue> 5% on garde H0 ,les residues semble
bartlett.test(res4$residuals~rotation)#pvalue> 5% on garde H0

summary(res4)
Anova(res4)

