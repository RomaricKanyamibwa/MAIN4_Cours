function y=Acos(N,A,w0,phi,k)

y=ones(N,1);

for i=1:N
   y(i)=A*cos(w0*k(i)+phi); 
end

end