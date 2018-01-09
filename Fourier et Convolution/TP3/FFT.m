function y=FFT(N,XN)
    %fprintf('N:%d\n',N);
    X0=XN(1:2:end);
    X1=XN(2:2:end);
    y=zeros(N,1);
    if(N==1)
        y=XN;
    else
        y1=FFT((N/2),X0);
        y2=(FFT((N/2),X1));
        for k=1:(N/2)
            y(k)=y1(k)+exp(-(2i*pi*(k-1))/N)*y2(k);
        end

        for k=(N/2)+1:N
            y(k)=y1(k-N/2)+exp(-(2i*pi*(k-1))/N)*y2(k-N/2);
        end
    end
                
    
end