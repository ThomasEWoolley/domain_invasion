ccc

m = 0;
x = linspace(0,100,400);
t = linspace(0,100,100);

u = pdepe(m,@pdex1pde,@pdex1ic,@pdex1bc,x,t);
% Extract the first solution component as u.

%%
close all
pcolor(t,x,u')
shading interp
ylabel('space')
xlabel('time')
% axis equal
% axis tight

[~,WavePoint]=max((u<0.5),[],2);
hold on
WaveX=x(WavePoint);
plot(t,WaveX,'--k')
fit(t(t>20)',WaveX(t>20)','poly1')
% figure
% plot(t(2:end),diff(WaveX)./diff(t))

save('Burger_pdepe.mat')



% --------------------------------------------------------------
function [c,f,s] = pdex1pde(x,t,u,DuDx)
DuDx(u>1)=0;
u(u<0)=0;
u(u>1)=1;

r=1;
R=r/sqrt(8);

c = 1;
f = 0;
s = -DuDx*r;
end
% --------------------------------------------------------------
function u0 = pdex1ic(x)
u0 = 0;
end
% --------------------------------------------------------------
function [pl,ql,pr,qr] = pdex1bc(xl,ul,xr,ur,t)
% ul(ul<0)=0;
% ul(ul>1)=1;
ur(ur<0)=0;
ur(ur>1)=1;
pl = ul-1;
ql = 0;
pr = 0;
qr = 1;
end