l=2;
m=2^l;
Xm=ones(m,1);
Xm(1:2:end)=3*Xm(1:2:end);
%Xpair(2*m,Xm)

FFT(m,Xm)
fft(Xm)
