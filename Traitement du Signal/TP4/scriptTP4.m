%% Partie 1
M=5;
%moyenne glissante avec filt
%filt construit la reponse impulsioner d'un filtr
%filt construit un filtre
sys=filt([ones(1,M)],[M])
impulse(sys)
hold on
%leaky integrator
lambda=0.95;
sys=filt([1-lambda],[1 -lambda])
impulse(sys)

%%
a=[0.05 0.25 0.15 0.5 0.3 0.7 1];
hold on
for i=a
    sys=filt([1],[1 -i])
    impulse(sys)
end

%% Partie 2
[b,a]=butter(8,0.01)

%x=0:1/10:2*pi;
[y,Fs]=audioread('Son1.wav');
y2=filter(b,a,y(:,1));
figure(1)
plot(abs(fft(y(:,1))))
hold on
plot(abs(fft(y2)))
legend('y','butter')

%% Partie 3




