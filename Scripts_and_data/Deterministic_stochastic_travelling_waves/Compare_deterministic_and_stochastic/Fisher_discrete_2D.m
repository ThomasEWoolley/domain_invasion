ccc

nl=100;
nw=100;
T=0:2:50;
x=1:nw;
IC2=zeros(nl,nw);
IC2(:,1)=1;



[t2,y2]=ode45(@(t,y)ODE_2D_network(t,y,nl,nw,0.54346),T,IC2);
y2=reshape(y2,length(T),nl,nw);
y2mean=squeeze(mean(y2,2));
[~,WavePoint]=max((y2mean<0.5),[],2);
WaveX=x(WavePoint);
WaveX=WaveX(WaveX>1);
Tw=t2(WaveX>1);

pp=fit(Tw(Tw>20),WaveX(Tw>20)','poly1')

j=nl;
load(['Processed_100_runs_2d_r_1_width_',num2str(j),'.mat']);
Mean_pops=mean(mean(Aligned_2d_pops,4),2);

Mean_pops=squeeze(Mean_pops(:,1,:));
Index=[];
Times=[];
l=1;
for i=1:2:length(T)
    if max(Mean_pops(:,i))>0.6 & min(Mean_pops(:,i))<0.4
        Index(l)=find(Mean_pops(:,i)<0.5,1,'first');
        Times(l)=T(i);
   l=l+1;     
    end
end
%%
close all
fig=figure('position',[0 0.1 1/3 1/3]);
z=mean(Aligned_2d_pops,4);
subplot(2,1,1)
imagesc(1:100,1:100,z(:,:,20)')
set(gca,'YDir','normal')
axis([0 100 0 100])
set(gca,'fontsize',15)
subplot(2,1,2)
imagesc(1:100,1:100,squeeze(y2(11,:,:)))
set(gca,'YDir','normal')
axis([0 100 0 100])
xlabel('Domain width')
set(gca,'fontsize',15)
han=axes(fig,'visible','off'); 
han.YLabel.Visible='on';
ylabel(han,'Domain length');
set(gca,'fontsize',15)
export_fig('../../../Pictures/Deterministic_stochastic_large_grid.png','-r300')

figure
hold on
plot(Tw,WaveX,'or')
plot(Times, Index,'-k')

axis([0 40 0 100])
p=fit(Times',Index','poly1')
xlabel('Time, $t$')
ylabel('Space')
set(gca,'fontsize',15)
legend('Deterministic wavefront','Stochastic wavefront','location','no')
export_fig('../../../Pictures/Deterministic_stochastic_wave_speeds.png','-r300')
% z=load('Comsol_output_data.txt');
% x=reshape(z(:,1),100,100);
% y=reshape(z(:,2),100,100);
% z(:,[1,2])=[];
% z=reshape(z,100,100,101);
% u=squeeze(mean(z,2));
% [~,WavePoint]=max((u'<0.5),[],2);
% hold on
% WaveX=x(WavePoint);
% WaveX=WaveX(WaveX>1);
% Tw=T(WaveX>1);
% plot(Tw,WaveX,'--r')
% pp=fit(Tw(Tw>20)',WaveX(Tw>20)','poly1')

% [t2,y2]=ode45(@(t,y)ODE_2D_network(t,y,nl,nw,0.6),T,IC2);
% y2=reshape(y2,length(T),nl,nw);
% y2mean=squeeze(mean(y2,2));
% % imagesc(1:nw,1:nl,squeeze(y2(10,:,:)))
% 
% [~,WavePoint]=max((y2mean<0.5),[],2);
% % hold on
% WaveX=x(WavePoint);
% WaveX=WaveX(WaveX>1);
% Tw=t2(WaveX>1);
% hold on
% plot(Tw,WaveX,'--k')
% pp=fit(Tw(Tw>20),WaveX(Tw>20)','poly1')
function dydt=ODE_2D_network(t,y,nl,nw,R)
m=reshape(y,nl,nw);
right=[m(:,2:end) zeros(nl,1)];
left=[zeros(nl,1) m(:,1:end-1)];
up=[m(end,:);m(1:end-1,:)];
down=[m(2:end,:);m(1,:)];
dydt=R*reshape((ones(nl,nw)-m).*(up+down+...
    left+right),nl*nw,1);

end
