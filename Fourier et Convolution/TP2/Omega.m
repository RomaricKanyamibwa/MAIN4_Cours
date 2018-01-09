function y=Omega(m)

    y=ones(m,m);
    for i=2:m
       for j=2:m
           y(i,j)=(exp(-2i*pi/m))^((i-1)*(j-1));
       end
    end

end