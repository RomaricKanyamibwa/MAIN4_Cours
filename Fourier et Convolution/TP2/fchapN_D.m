function y=fchapN_D(k,N,f)
    y=0;
    %Om=Omega(2*N);
    w=exp(-1i*pi*k/N);
    for j=0:2*N-1
       y=y+f(j*pi/N)*(w)^j;
    end

    y=1/(2*N)*y;
end