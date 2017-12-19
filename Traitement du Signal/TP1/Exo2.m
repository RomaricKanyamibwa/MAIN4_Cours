[y,Fs]=audioread('Son1.wav');

%sound(Aud1)
length=size(y);
length=length(1)
Duration=1/Fs*length
Aud1=audioread('Son1.wav');
plot(Aud1)

%sound(y(1:16:end,:),Fs)

x=mystere(y,4);
sound(x,Fs)
