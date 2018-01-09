%m=[8;16;32;64];
%  for m=[8,16,32,64]
%      Omega(m)
%  end
 
%% B1

N=16;
for i=-N+1:1:N
   disp(i);
   fchapN_D(i,N,@f2) 
end
 