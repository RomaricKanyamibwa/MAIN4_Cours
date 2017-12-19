function [feature_values] = feature_extraction3(signauxEEG)

feature_values = zeros(40,1);

for video=1:40
    signal = signauxEEG{video};
    feature_values(video')=sum(diag(signal));
% compl�ter
end

end
