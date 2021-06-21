ccc

N=100;
z=reshape(IC(N,N),200,100);
ICs=z(1:100,:);
spy(ICs);
tic
[t,y]=ode45(@(t,y)ODE_network(t,y,N),[0,40],reshape(ICs,N^2,1));
plot(t,sum(y,2),'b')
toc
hold on
tic
[t,y]=ode45(@(t,y)ODE_network_slower(t,y,N),[0,40],reshape(ICs,N^2,1));
plot(t,sum(y,2),'--r')
toc
function dydt=ODE_network(t,y,N)
m=reshape(y,N,N);
m=round(m);
dydt=0.1*reshape((ones(N,N)-m).*(m*diag(ones(N-1,1),-1)+m*diag(ones(N-1,1),1)+...
    diag(ones(N-1,1),-1)*m+diag(ones(N-1,1),1)*m),N^2,1);

end


function dydt=ODE_network_slower(t,y,N)
m=reshape(y,N,N);
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
        dydt(i,j)=0.1*(1-m(i,j))*(sum(a));
    end
end
dydt=reshape(dydt,N^2,1);

end