function y=SnF(t,N)
    y=0;
    for k=1:N
           y=y+(((-1)^k-1)/(k))*(2i*sin(k*t));
    end
    y=1i/(pi)*y;
    %y=yi;

end