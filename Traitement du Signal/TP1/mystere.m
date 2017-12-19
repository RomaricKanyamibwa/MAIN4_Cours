function [y] = mystere(x,B)
%MYSTERE Fait quelque chose de mystérieux

% Input :
% x     : (n x 2) vecteur
% B     : nombre entier

% Outuput :
% y     : (n x 2) vecteur

M       = max(x(:));
m       = min(x(:));
A       = M-m;
Delta   = A/2^B;
x2      = floor((x-m)/Delta);

M2      = max(x2(:));
m2      = min(x2(:));
y       = (x2-m2)/(M2-m2)*(M-m)+m;

end

