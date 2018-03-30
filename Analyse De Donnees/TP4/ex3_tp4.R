
#Q1
data=read.table("SAheart.data",sep=",",header = T,row.names = 1)
head(data)
str(data)#type des variables
summary(data)
is.factor(data[,5])#variable qualitative
is.factor(data[,10])
data$chd=as.factor(data$chd)

plot(data)

attach(data)
#Q2

res<-glm(chd~.,family = binomial,data=data)
summary(res)

#Q3

OR_AntFam=exp(res$coefficients["famhistPresent"])
#Si tu as un  historique familiale tu 2.5 plus de chance d'avoir la maladie
OR=exp(summary(res)$coefficients[,1])
#quand le taux cholysterol augmente d'une unite le risque d'avoir la maladie augmente de 0.18 (on multiplie de 1,18)

#Q4
res0=glm(chd~1,family = "binomial",data=data)
anova(res0,res,test="Chisq")#comparaison de res et res0
#pvalue< 5% donc on rejette H0,donc il y a au moins une variable explicative significative

#Q5
summary(res)

#Q6
library("MASS")
res_AIC<-step(res)
#on met tjrs le petit model avant le grang model , 
anova(res_AIC,res,test="Chisq")#comparaison de res et res0
#pvalue>5% on ne rejette pas H0, H0 semble correct

# Q7
#pred est la proba à priori que l'individu soit malade
pred=predict(res_AIC, data.frame(sbp=150, tobacco=10, ldl=5, adiposity=23, 
                                 famhist="Present", typea=70, obesity=25, alcohol=100, age=50) , type="response")
#la proba qu il appartient à la class chd=1 est 0.76 
class=1*(pred>0.5)
#> class
#1 (individu) 
#1 (classe de l'individu)

# Q8
library(car)
crPlots(res_AIC)
#on regarde la courbe verte et on voit si elle est lineaire ou pas
#si la courbe nous donne une tendance quadratique il faut mettre un carre à la variable en question
vif(res_AIC)#on test si il sont lineaire ou pas (si vif >5 ou 10 on de la colinearité)

#graphe 
x11()
par(mfrow=c(2,2))
plot(res_AIC)
#on regarde pas les qqplot et les autres graphes car notre residues ne sont pas gaussien
#on regarde que le graphe en ban à droite pour trouver les leviers et les residues
# attention pas de diagnostic gaussien  !

# résidus de Pearson trop elevés ? 
abs(residuals(res_AIC,type="pearson"))[abs(residuals(res_AIC,type="pearson"))>2]
# résidus de deviance trop elevés ? 
abs(residuals(res_AIC,type="deviance"))[abs(residuals(res_AIC,type="deviance"))>2]

# points leviers ? 
infl = influence.measures(res_AIC)
leviers = infl$infmat[,"hat"]
p<-length(res_AIC$coefficients)
n<-nrow(data)
leviers[leviers > 3* p/n]



#Q9a)
n=nrow(data)
test.ratio=0.2
n.test=ceiling(n*test.ratio)
tr=sample(1:n,n.test)
data.train=data[-tr,]
data.test=data[tr,]

res.train<-glm(chd~tobacco+ldl+famhist+typea+age,family = binomial,data=data.train)
pred_logit<-predict(res.train,data.test,type="response")
class_logit<-1*(pred_logit>1/2)

#d)
table(class_logit,data.test$chd)

#e)taux de bon classement
mean(class_logit==data.test$chd)

# Q9f)
library(ROCR)
pred_logit <- predict(res.train, data.test, type="response")
predictions_logit <- prediction( pred_logit,  data.test$chd)
perf_logit <- performance(predictions_logit , "tpr", "fpr" )
plot(perf_logit)

AUC_logit <- performance(predictions_logit,"auc")@y.values[[1]]


# Q9g)
library(boot)
# définir l'erreur de classement comme une fonction entre les 
#observations $Y$ et les classes prédites $class$  
  cout <- function(Y, class)   {return(mean(abs(Y-class)>0.5))}

# estimation du taux d'erreur par CV
cv.glm(data, res_AIC, cout)$delta[1]



