ccc

n=100;
T=0:5:n;
IC1=zeros(n,1);
IC1(1)=1;

IC2=zeros(n,n);
IC2(1,:)=1;

[t1,y1]=ode45(@(t,y)ODE_1D_network(t,y,n),T,IC1);
[t2,y2]=ode45(@(t,y)ODE_2D_network(t,y,n),T,IC2);
subplot(1,4,1)
pcolor(T,1:n,y1')
caxis([0,1])
shading interp
subplot(1,4,3)
Mean_y2=mean(reshape(y2,length(T),n,n),3);
pcolor(T,1:n,Mean_y2')
caxis([0,1])
shading interp
% for i=1:length(T)
%     subplot(1,4,2)
% plot(y1(i,:))
% subplot(1,4,4)
% % pcolor(reshape(y2(i,:),n,n))
% plot(Mean_y2(i,:))
% drawnow
% end


% clc
% close
Index=[];
for i=1:length(T)
    if max(y1(i,:))>0.6 & min(y1(i,:))<0.4
        Index1(i)=find(y1(i,:)<0.5,1,'first');
        Times1(i)=T(i);
    end
    
    if max(y2(i,:))>0.6 & min(y2(i,:))<0.4
        Index2(i)=find(y2(i,:)<0.5,1,'first');
        Times2(i)=T(i);
    end
end
subplot(1,4,2)
Times1(Index1==0)=[];
Index1(Index1==0)=[];

plot(Times1,Index1)
p = polyfit(Times1',Index1',1)
f1 = polyval(p,Times1);
hold on
plot(Times1,f1,'--r')

subplot(1,4,4)
Times2(Index2==0)=[];
Index2(Index2==0)=[];

plot(Times2,Index2)
p = polyfit(Times2',Index2',1)
f = polyval(p,Times2);
hold on
plot(Times2,f,'--r')
plot(Times1,f1,':k')





function dydt=ODE_1D_network(t,y,n)
dydt=1/sqrt(8)*[(1-y(1))*y(2)
    (1-y(2:n-1)).*(y(1:n-2)+y(3:n));
    (1-y(n))*y(n-1)];

end


function dydt=ODE_2D_network(t,y,N)
m=reshape(y,N,N);
% m=round(m);
dydt=0.25*reshape((ones(N,N)-m).*(m*diag(ones(N-1,1),-1)+m*diag(ones(N-1,1),1)+...
    diag(ones(N-1,1),-1)*m+diag(ones(N-1,1),1)*m),N^2,1);

end
