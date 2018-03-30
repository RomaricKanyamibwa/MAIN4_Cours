data=read.table("rendement_mais.txt")
head(data)#on verifie que la table est bien une table bien structuré
is.factor(data$variete)

data$variete=as.factor(data$variete)
attach(data)


boxplot(rendement~variete)
points(tapply(rendement,variete,mean))

tapply(rendement,variete,mean)#la moyenne de 3 types de variete
sqrt(tapply(rendement,variete,var))#l'ecart type de 3 types de variete


res=lm(rendement~variete,contrasts = "contr.treatement")
summary(res)$coefficients

#pvalue < 0.05 donc on rejet H0, µi et µ1 n'influe pas de la même maniere

summary(res)

#on compare  avec une autre variete(ici variete 2)
variete=relevel(variete,ref = 2)
res2=lm(rendement~variete,contrasts = "contr.treatement")
summary(res2)

#Si on a plus de donnes R nous permet de de compairer tous les varietes entre euc automatiquement
pairwise.t.test(rendement,variete,p.adjust="none")

pairwise.t.test(rendement,variete,p.adjust="bonf")
comp.Tuckey = TukeyHSD(aov(rendement~variete))
par(mfrow=c(1,2))
plot(comp.Tuckey)
