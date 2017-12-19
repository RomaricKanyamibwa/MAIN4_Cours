%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Exercice 1                 %
%                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phi=pi/8;
A=1;
N=20;
w0=pi/2;
Fe=4000;%Hertz
Te=1/Fe;
t=0:Te:(N-1)*Te;
y=Acos(N,A,w0,phi,0:N-1);
n=0:(N-1);
x=A*cos(w0*n+phi);

figure(1)
plot(n,x);

hold on
% for i=[5,10,20,40]
%     N=i;
%     t=0:Te:(N-1)*Te;
%     y=Acos(N,A,w0,phi,t);
%     %plot(t,y);
% 
% end

%y=Acos(N,A,w0,phi,t);

f=400;
w0=pi*2*f;
t=0:Te:(N-1)*Te;
x=A*cos(w0*t+phi);
figure(2)
plot(t,x);
k=0:N-1;
%f=@(t)(A*cos(2*pi*f*t/Fe));