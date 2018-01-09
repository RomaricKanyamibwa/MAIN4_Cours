function y =Tn(f,n,a,b)

    h=(b-a)/n;
    y=0;
    for i=1:n-1
        
        y=y+f(a+i*h);
        
        
    end
        y=y+(f(a)+f(b))/2;
        y=y*h;

end