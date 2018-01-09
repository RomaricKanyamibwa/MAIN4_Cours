N=1000;%8,20,100

t=-pi:1/10000:pi;
y=SnF(t,N);
y1=FejerN(t,N);

figure(1)
subplot(2,2,1)  
plot(t,y,t,f(t))

%figure(2)
subplot(2,2,2)  
plot(t,y1,t,f(t))

%figure(3)
subplot(2,2,[3 4])  
plot(t,convF(t,N),t,f(t))