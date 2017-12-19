%%


Fs = 128;             % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 8064;             % Length of signal
t = (0:L-1)*T;        % Time vector


%% Spectre d'amplitude

e = 3; % �lectrode
video = 4; % vid�o
signal = signauxEEG{video};
Y = fft(signal,[],2);
P2 = abs(Y/L);%je prend le module et je normalise
P1 = P2(:,1:L/2+1);%je prend le moitie des coefficients
P1(:,2:end-1) = 2*P1(:,2:end-1);%je double la valeur
f = Fs*(0:(L/2))/L;
plot(f,P1(e,:)) 


%% "J'ai fini, venez voir ce que j'ai fait !" (pour m'appeler en fin de TP)
[son,Fe] = audioread('fini.wav');
sound(son,Fe);
