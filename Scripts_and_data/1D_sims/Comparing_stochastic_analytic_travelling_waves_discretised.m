ccc
load('Hundred_runs_300_space.mat')
M=mean(p,3);
r=1;
figure('position',[0 0 .5 1/3])
hold on
Col={'k','b','r'};
l=1;

for i=[26,51,75]
    plot(M(i,:),Col{l})
    l=l+1;
end
xlabel('Space')
ylabel('$\langle W \rangle$')
ts=[0 50 100 150];
w0=zeros(300,1);
w0(1)=1;
[t,yA]=ode45(@(t,w)Advection(t,w,r),ts,w0);
[t,yF]=ode45(@(t,w)Fisher(t,w,r),ts,w0);
l=1;
Points=1:300;

for i=2:length(t)
    y_to_plot=yA(i,Points);
    I1=find(abs(diff(y_to_plot))>0.005,1,'first');
    I2=find(abs(diff(y_to_plot))>0.005,1,'last');
    Points2=I1:2:I2;
    plot(Points2,yA(i,Points2),'o','color',Col{l},'linewidth',1)
    plot(yF(i,:),':','color',Col{l})
    l=l+1;
end
legend('$t=50$','$t=100$','$t=150$')
set(gca,'fontsize', 15);
xlim([0 200])
export_fig('../../Pictures/Wave_shape_comparison.png','-r300')
%%
w0=zeros(300,1);
w0(1)=1;
[t,yA]=ode45(@(t,w)Advection(t,w,r),linspace(0,length(w0)),w0);
[t,yF]=ode45(@(t,w)Fisher(t,w,r),linspace(0,length(w0)),w0);


figure('position',[0 0 .5 1/3])
subplot(1,7,[5 6])
imagesc(t,1:length(w0),yF')
formatter

subplot(1,7,[3 4])
imagesc(t,1:length(w0),yA')
formatter

subplot(1,7,[1 2])
imagesc(T,1:n,M')
formatter
xlim([0,300])
subplot(1,7,7)
axis off
colorbar

export_fig('../../Pictures/Space_time_comparison.png','-r300')
%%
figure
hold on
Indices=Tracker(M);
p1=plot(T,Indices,'b')

Indices=Tracker(yF);
p2=plot(t,Indices,'k')

Indices=Tracker(yA);
p3=plot(t,Indices,'g--')
xlabel('Time')
ylabel('Space')
axis([0 300 0 300])
legend([p1(1) p2(1) p3(1)],'Stochastic data','Non-linear Fisher equation','Advection equation','location','no')
set(gca,'fontsize', 15);
export_fig('../../Pictures/Wave_speed_comparison.png','-r300')
%%
function formatter
axis tight
set(gca,'YDir','normal')
xlabel('Space')
ylabel('Time')
end

function dwdt=Advection(t,w,r)
dwdt=zeros(length(w),1);
dwdt(1)=0;
dwdt(2:end)=r*(w(1:end-1)-w(2:end));
end

function dwdt=Fisher(t,w,r)
dwdt=zeros(length(w),1);
r=1/sqrt(8);
dwdt(1)=0;
dwdt(2:end-1)=r.*(1-w(2:end-1)).*(w(1:end-2)-2*w(2:end-1)+w(3:end))...
    +2*r*w(2:end-1).*(1-w(2:end-1));
dwdt(end)=r.*(1-w(end)).*(w(end-1)-w(end))...
    +2*r*w(end).*(1-w(end));
end

function Indices=Tracker(w)
[a,b]=size(w);
Indices=zeros(a,3);
for i=1:a
    Indices(i,1)=find(w(i,:)>.1,1,'last');
    Indices(i,2)=find(w(i,:)>.5,1,'last');
    Indices(i,3)=find(w(i,:)>.9,1,'last');
end
end

