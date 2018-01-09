function y=f(t)
    y=0;
%     for i=1:length(t)
%         
%     end
    y=(t>0).*(t<=pi)+(-1*(t<=0).*( t>-pi));


end