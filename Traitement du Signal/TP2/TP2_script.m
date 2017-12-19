%% Q1
Fs = 128;
L = 8064;             % Length of signal
t = (0:L-1)*T; 
load('noms_electrodes.mat');
A=signauxEEG{1};
sz=size(A);
tmps=1/Fs*sz(2)   %duree d'une video

%% Q2
len=size(signauxEEG);
%hold on
for i=4:8
    plot(t,signauxEEG{i}(1,:));
end

%% Q3
video=10;
hold on
for i=1:3
    A=signauxEEG{video}(i,:);
    FourierT=fft(A,[],2);
    plot(abs(FourierT))
end
%% Partie 2
e=16;
freq=30;
A2=feature_extraction2(signauxEEG,e,15,28);
gscatter(1:40,A2,labels_emotion,'br','xo')
seuil=140;
score_classification(A2,seuil,labels_emotion)