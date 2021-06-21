ccc
%%
clc
close all
if ~exist('t_vec')
    load Processed_100_runs.mat
end

for j=1:length(t_vec)
    d(:,j)=-1./(4*T').*log(Aligned_pops(1,j)./Aligned_pops(:,j).*...
        (Aligned_pops(:,j)-100^2)./(Aligned_pops(1,j)-100^2));
end
subplot(1,2,1)
plot(d,'b')
hold on
Mean_d=mean(d,2);
plot(Mean_d,'k')
dc=mean(Mean_d(300:end));

subplot(1,2,2)
plot(T,Aligned_pops,'b')
hold on
plot(T,mean(Aligned_pops,2),'k')
xlim([0 40])
hold on
[t,y]=ode45(@(t,y)ODEfun(t,y,dc),[0,40],Pops{1}(1));
plot(t,y,'--g')
[t,y]=ode45(@(t,y)ODEfun(t,y,0.1),[0,40],Pops{1}(1));
plot(t,y,'--r')
[t,y]=ode45(@(t,y)ODEfun(t,y,0.1/4),[0,40],Pops{1}(1));
plot(t,y,'--r')


N=100;

z=reshape(IC(N,N),200,100);
ICs=z(1:100,:);
[t,y]=ode45(@(t,y)ODE_network(t,y,N,dc),[0,40],reshape(ICs,N^2,1));
plot(t,sum(y,2),':')


function dydt=ODEfun(t,y,d)
dydt =4*d*y*(1-y/100^2);
end

function dydt=ODE_network(t,y,N,d)
m=reshape(y,N,N);
% m=round(m);
dydt=0.0625*reshape((ones(N,N)-m).*(m*diag(ones(N-1,1),-1)+m*diag(ones(N-1,1),1)+...
    diag(ones(N-1,1),-1)*m+diag(ones(N-1,1),1)*m),N^2,1);

end

function dydt=ODE_network_2(t,y,N,d)
m=reshape(y,N,N);
prob=sum(y)/N^2;
% m=round(m);
dydt=4*0.0065*reshape((ones(N,N)-m).*prob,N^2,1);

end

function dydt=ODE_network_3(t,y,N,d)
m=reshape(y,N,N);
prob=2*sqrt(pi*(N^2-sum(y)))/N^2;
% m=round(m);
dydt=4*0.1*reshape((ones(N,N)-m).*prob,N^2,1);

end


function dydt=ODE_network_4(t,y,N,d)
m=reshape(y,N,N);
B=bwboundaries(round(m));
X=[];
Y=[];
for k=1:length(B)
boundary = B{k};
x=boundary(:,2);
y=boundary(:,1);

y(x==1|x==N)=[];
x(x==1|x==N)=[];

x(y==1|y==N)=[];
y(y==1|y==N)=[];
X=[X;x];
Y=[Y;y];
end
prob=length(X)/N^2;
% m=round(m);
dydt=4*0.1*reshape((ones(N,N)-m).*prob,N^2,1);

end