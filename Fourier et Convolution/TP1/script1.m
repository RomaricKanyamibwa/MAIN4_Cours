%===============================================%
% auteur : MERHANE Boussad Et Romaric kanyamibwa ---
% date   : 26/09/2017
% 
% 
%==============================================%

% initialisation 

f=@(x)sin(x);

a=-10;
b=10;
n=100;

disp('fonction Rn');
r=Rn(f,n,a,b)

disp('fonction Tn');

t=Tn(f,n,a,b)


disp('différence');

diff=r-t;

x=-10:1/10:10;
y=KSI(x);
plot(x,y);
ylim([-0.5,1])
hold on

plot(x,0.5*ones(length(x)));


% calcul de Rn et Tn pour n =10,50,100
r10 =  Rn(@KSI,10,-10,10)
r50 =  Rn(@KSI,50,-10,10)
r100 =  Rn(@KSI,100,-10,10)


t10 =  Tn(@KSI,10,-10,10)
t50 =  Tn(@KSI,50,-10,10)
t100 =  Tn(@KSI,100,-10,10)


% calcul de la convolé

% méthode des rectangles

plot(x,Convole(@Rn,@KSI,@KSI,x,500,-10,10))
plot(x,Convole(@Tn,@KSI,@KSI,x,100,-10,10))
ylim([-0.5,1])

%méthode des triangle


hold off

s=-10:1/10:10;
k=10;
plot(s,gk(s,k))



