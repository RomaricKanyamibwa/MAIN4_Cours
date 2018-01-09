function y =Rn(f,n,a,b)

    h=(b-a)/n;
    y=0;
    for i=0:n-1
        
        y=y+f(a+i*h);
        
        
    end
        y=y*h;

end