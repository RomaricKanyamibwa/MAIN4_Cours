function [precision] = score_classification(feature_values,seuil,labels)

% feature_values : valeurs pour chaque vid�o de la feature EEG consid�r�e
% seuil          : seuil de d�cision
% labels         : annotation �motionnelle de chaque vid�o (1=n�g, 2=pos)

prediction1 = 1*(feature_values<seuil) + 2*(feature_values>=seuil);
precision1 = sum(prediction1==labels)/length(labels);% compl�ter

prediction2 = 2*(feature_values<seuil) + 1*(feature_values>=seuil);
precision2 = sum(prediction2==labels)/length(labels);% compl�ter

precision = max(precision1,precision2);


gscatter(1:40,feature_values,labels,'br','xo')

end

