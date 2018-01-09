function y=KSI(s)

    n=length(s);
    
    
    for i=1:n
    y(i)=(1/2)*(s(i)>=-1 && s(i)<=1);
    
    end



end