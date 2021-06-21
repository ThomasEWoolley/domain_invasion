ccc

n=100;
T=0:1:n;
x=1:n;
IC1=zeros(n,1);
IC1(1)=1;

[t1,y1]=ode45(@(t,y)ODE_1D_network(t,y,n),T,IC1);
pcolor(T,1:n,y1')
caxis([0,1])
shading interp

[~,WavePoint]=max((y1<0.5),[],2);
hold on
WaveX=x(WavePoint);
WaveX=WaveX(WaveX>1);
Tw=T(WaveX>1);
plot(Tw,WaveX,'--k')
fit(Tw(Tw>20)',WaveX(Tw>20)','poly1')
save('Burger_discrete.mat')

% 
% Index=[];
% for i=1:length(T)
%     if max(y1(i,:))>0.6 & min(y1(i,:))<0.4
%         Index1(i)=find(y1(i,:)<0.5,1,'first');
%         Times1(i)=T(i);
%     end
%     
% end
% figure
% Times1(Index1==0)=[];
% Index1(Index1==0)=[];
% 
% plot(Times1(2:end),diff(Index1)./diff(Times1))




function dydt=ODE_1D_network(t,y,n)
dydt=[0
    (y(1:n-1)-y(2:n))];

end
