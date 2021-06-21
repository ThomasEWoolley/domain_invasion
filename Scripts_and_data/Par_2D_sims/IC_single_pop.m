function x=IC_single_pop(n,r)
close all

x=ones(n,n);

for i=1:n
    for j=1:n
        
        if round(i-n/2)^2+round(j-n/2)^2<(r/2)^2
            x(i,j)=0;
        end
        
    end
end
