ccc
N=5;
m=1:25;
m=reshape(m,5,5)
mm=m*diag(ones(N-1,1),-1)+m*diag(ones(N-1,1),1)+...
    diag(ones(N-1,1),-1)*m+diag(ones(N-1,1),1)*m;



for i=1:N
    for j=1:N
        a=0;
        if i>1
            a(1)=m(i-1,j);
        end
        if i<N
            a(2)=m(i+1,j);
        end
        if j>1
           a(3)=m(i,j-1); 
        end
        if j<N
            a(4)=m(i,j+1);
        end
        
        
        M(i,j)=sum(a);
    end
end
mm-M