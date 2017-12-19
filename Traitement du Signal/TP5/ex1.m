T=1/100;%en S
f=3600;
fe=8000;%freq dechantillon
Te=1/fe;
t=0:Te:T;
y=cos(2*pi*f*t);
plot(t,y);