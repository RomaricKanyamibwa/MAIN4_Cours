function y=f(t)
    x=mod(t,pi);
    if(x<=1/4 && x>-1/4)
        y=1;
    else
        y=0;
    end
end