iris
attach(iris)
head(iris)
str(iris)
kmeans.result=kmeans(iris[,1:4],3)
names(kmeans.result)

plot(Sepal.Length,Sepal.Width)
plot(Sepal.Length,Sepal.Width,col=kmeans.result$cluster)
points(kmeans.result$centers,pch=8,col=1:3)

table(iris$Species,kmeans.result$cluster)
summary(iris)


#CAH
hc<- hclust(dist(iris[,1:4]),method = "ward.D2")
plot(hc,hang=-1,labels = iris$Species)
rect.hclust(hc,k=3)
groups<- cutree(hc,k=3)
groups
table(iris$Species,groups)
barplot(hc$height)
