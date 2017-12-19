function [feature_values] = feature_extraction2(signauxEEG,electrode,freq_min,freq_max)

feature_values = zeros(40,1);

Fs = 128;             % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 8064;             % Length of signal
t = (0:L-1)*T;        % Time vector
e = electrode; % �lectrode



for video=1:40
    signal = signauxEEG{video};
    % compl�ter
    Y = fft(signal,[],2);
    P2 = abs(Y/L);%je prend le module et je normalise
    P1 = P2(:,1:L/2+1);%je prend le moitie des coefficients
    P1(:,2:end-1) = 2*P1(:,2:end-1);%je double la valeur
    f = Fs*(0:(L/2))/L;
    P=P1(e,:);
    feature_values(video)=sum(P(f<freq_max & f>freq_min));
end

end
