function y=MoyGliss(k,M,x)

y=0;
k-M+1
i=k:k-M+1
for i=k:-1:k-M+1
    y=y+x(i);
end
y=y/M;


end