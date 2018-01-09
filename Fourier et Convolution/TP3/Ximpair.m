function X0=Ximpair(m,Xm)
disp('impair')
    disp(Xm)
    X0=Xm(1:2:floor(m/2));
end
