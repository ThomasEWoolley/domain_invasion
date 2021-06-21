ccc

load OneD_100_runs_r_1.mat

% subplot(1,2,1)


% subplot(1,2,2)
[t,y]=ode45(@(t,y)ODE_network(t,y,n,1),T,[1,zeros(1,n-1)]);

for i=1:length(T)
    Deterministic_point(i)=find(y(i,:)>0.5,1,'last');
end


% pcolor(t,1:100,double(y>0.5)')
% shading interp
% hold on
% plot(T,Pop,'k')
[~,b]=unique(Deterministic_point);
subplot(1,2,1)
plot(T(b),Deterministic_point(b),'b')
hold on
plot(T,mean(Pop,2),'k')

subplot(1,2,2)

hold on
plot(T(1:end-1),diff(mean(Pop,2))./diff(T),'k')
plot(T(1:end-1),mean(diff(mean(Pop,2))./diff(T)),'r')
plot(T(b(1:end-1)),diff(Deterministic_point(b))./diff(T(b)),'b')




function dydt=ODE_network(t,y,n,d)


dydt=1/sqrt(8)*[(1-y(1))*y(2)
    (1-y(2:n-1)).*(y(1:n-2)+y(3:n));
    (1-y(n))*y(n-1)];

end