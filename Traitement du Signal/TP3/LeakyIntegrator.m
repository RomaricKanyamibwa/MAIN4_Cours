function y=LeakyIntegrator(k,M,x)

y=(M-1)*MoyGliss(k-1,M-1,x)+1/M*x(k);

end