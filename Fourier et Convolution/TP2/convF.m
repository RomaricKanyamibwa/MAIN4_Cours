function y=convF(t,N)
    
    y=0;
    for k=1:N
        if(k~=0)
           y=y+(((-1)^k-1)/(k)*1i/pi)^2*(exp(1i*k*t));
        end
    end
    y=(2*pi)*y; 

end