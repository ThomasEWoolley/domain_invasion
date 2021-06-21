ccc
load('Hundred_species_runs.mat')
M=mean(p,3);
r=1;
hold on
for i=[11,21,31,41]
plot(M(i,:))
end
xlabel('Space')
ylabel('$\langle W \rangle$')

w0=zeros(100,1);
w0(1)=1;
PdeyA = pdepe(0,@(x,t,u,DuDx)pdeyA(x,t,u,DuDx,r),@pdex1ic,@pdex1bc,1:1:100,[0 20 40 60 80]);
PdeyF = pdepe(0,@(x,t,u,DuDx)pdeyF(x,t,u,DuDx,r),@pdex1ic,@pdex1bc,0:1:100,[0 20 40 60 80]);
[t,yA]=ode45(@(t,w)Advection(t,w,r),[0 20 40 60 80],w0);
[t,yF]=ode45(@(t,w)Fisher(t,w,r),[0 20 40 60 80],w0);
for i=2:length(t)
plot(yA(i,:),'--')
plot(yF(i,:),':')
plot(PdeyA(i,:),'d')
plot(PdeyF(i,:),'*')
end


%%
w0=zeros(300,1);
w0(1)=1;
[t,yA]=ode45(@(t,w)Advection(t,w,r),linspace(0,length(w0)),w0);
[t,yF]=ode45(@(t,w)Fisher(t,w,r),linspace(0,length(w0)),w0);
PdeyF = pdepe(0,@(x,t,u,DuDx)pdeyF(x,t,u,DuDx,r),@pdex1ic,@pdex1bc,1:1:length(w0),linspace(0,length(w0)));
PdeyA = pdepe(0,@(x,t,u,DuDx)pdeyA(x,t,u,DuDx,r),@pdex1ic,@pdex1bc,1:1:length(w0),linspace(0,length(w0)));

%%
figure
subplot(1,5,1)
hold on
imagesc(t,1:length(w0),yF')
axis tight

subplot(1,5,2)
hold on
imagesc(t,1:length(w0),yA')
axis tight

subplot(1,5,3)
hold on
imagesc(T,1:100,M')
axis tight
xlim([0,100])


subplot(1,5,4)
hold on
imagesc(t,1:length(w0),PdeyF')
axis tight


subplot(1,5,5)
hold on
imagesc(t,1:length(w0),PdeyA')
axis tight

%%
figure
hold on
Indices=Tracker(yA);
% plot(t,Indices,'k')
c=diff(Indices)./diff(t);
mean(c(c>0),'omitnan')
plot(t(1:end-1),c)

Indices=Tracker(yF);
% plot(t,Indices,'k')
c=diff(Indices)./diff(t);
mean(c(c>0),'omitnan')
plot(t(1:end-1),c)

Indices=Tracker(M);
% plot(T,Indices,'k')
c=diff(Indices)./diff(T');
mean(c(c>0),'omitnan')
plot(T(1:end-1),c)

Indices=Tracker(PdeyF);
% plot(t,Indices,'k')
c=diff(Indices)./diff(t);
mean(c(c>0),'omitnan')
plot(t(1:end-1),c)

Indices=Tracker(PdeyA);
% plot(t,Indices,'k')
c=diff(Indices)./diff(t);
mean(c(c>0),'omitnan')
plot(t(1:end-1),c)

%%
% export_fig('../../Pictures/Wave_speed_1D.png','-r300')
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

% dwdt(1)=0;
% dwdt(2:end-1)=r.*(1-w(2:end-1)).*(w(1:end-2)+w(3:end));
% dwdt(end)=r.*(1-w(end)).*(w(end-1));
end

function Indices=Tracker(w)
[a,b]=size(w);
Indices=zeros(a,1);
for i=1:a
Indices(i)=find(w(i,:)>.5,1,'last');
end
end


function [c,f,s] = pdeyF(x,t,u,DuDx,r)
r=r/sqrt(8);
c = 1/(1-u);
f = r*DuDx;
s = 2*r*u;
end

function [c,f,s] = pdeyA(x,t,u,DuDx,r)
if u>1
    u=1;
    DuDx=0;
end
c = 1;
f = 0;
s = -r*DuDx;
end

function u0 = pdex1ic(x)
u0 = 0;
end

function [pl,ql,pr,qr] = pdex1bc(xl,ul,xr,ur,t)
pl = ul-1;
ql = 0;
pr = 0;
qr = 1;
end