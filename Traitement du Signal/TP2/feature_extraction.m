function [feature_values] = feature_extraction(signauxEEG)

feature_values = zeros(40,1);

for video=1:40
    signal = signauxEEG{video};
    feature_values(video')=norm(signal);
% compl�ter
end

end

