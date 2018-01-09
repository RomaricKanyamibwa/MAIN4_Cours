function y=g(s)

    n=length(s);
    
    for i=1:n
            
        if(abs(s(i))>1)
           y(i)=0;
        else
            
            y(i)=1-abs(s(i));
            
        end 
    end
end