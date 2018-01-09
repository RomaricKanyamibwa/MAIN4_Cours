function y=Convole(appro,f,g,t,n,a,b)

    l=length(t);
    
    for i=1:l
        
       prod=@(s)(f(s)*g(t(i)-s));
        
       y(i)=appro(prod,n,a,b);
        
    end




end