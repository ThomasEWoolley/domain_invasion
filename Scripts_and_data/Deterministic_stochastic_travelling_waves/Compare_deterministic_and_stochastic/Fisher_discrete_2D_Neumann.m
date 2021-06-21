ccc

nl=10;
nw=100;
T=0:1:50;
x=1:nw;
IC2=zeros(nl,nw);
IC2(:,1)=1;

[t1,y1]=ode45(@(t,y)ODE_2D_network(t,y,nl,nw,0.54346),T,IC2);
y1=reshape(y1,length(T),nl,nw);
y1=squeeze(y1(21,:,:));

[~,WavePoint1]=max((y1<0.5),[],2);
WaveX1=x(WavePoint1);
WaveX1=WaveX1(WaveX1>1);



nl=100;
IC2=zeros(nl,nw);
IC2(:,1)=1;
[t2,y2]=ode45(@(t,y)ODE_2D_network(t,y,nl,nw,0.54346),T,IC2);
y2=reshape(y2,length(T),nl,nw);
y2=squeeze(y2(21,:,:));

[~,WavePoint2]=max((y2<0.5),[],2);
WaveX2=x(WavePoint2);
WaveX2=WaveX2(WaveX2>1);


%%
close all
clc

fig=figure('position',[0 0.1 1/3 1/3]);
subplot(2,1,1)
pcolor(squeeze(y1(:,:)))
shading interp
set(gca,'YDir','normal')
hold on
plot(smooth(WavePoint1,4),1:length(WavePoint1),'k')
axis tight
set(gca,'fontsize',15)
subplot(2,1,2)
pcolor(squeeze(y2(:,:)))
shading interp
set(gca,'YDir','normal')
hold on
plot(smooth(WavePoint2,4),1:length(WavePoint2),'k')
axis tight
xlabel('Domain width')
set(gca,'fontsize',15)
han=axes(fig,'visible','off'); 
han.YLabel.Visible='on';
ylabel(han,'Domain length');
set(gca,'fontsize',15)
export_fig('../../../Pictures/Deterministic_neumann.png','-r300')

function dydt=ODE_2D_network(t,y,nl,nw,R)
m=reshape(y,nl,nw);
right=[m(:,2:end) zeros(nl,1)];
left=[zeros(nl,1) m(:,1:end-1)];
up=[zeros(1,nw);m(1:end-1,:)];
down=[m(2:end,:);zeros(1,nw)];
dydt=R*reshape((ones(nl,nw)-m).*(up+down+...
    left+right),nl*nw,1);

end
