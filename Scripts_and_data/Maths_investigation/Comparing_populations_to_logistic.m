ccc
%%
clc
close all
if ~exist('t_vec')
    load tz_vec_data_100.mat
end

for j=20
    
    p=[];
    for i=1:length(t_vec{j})
        z=reshape(z_vec{j}(i,:),200,100);
        p(i,1)=sum(sum(z(1:100,:)));
    end
    
    d=-1./(4*t_vec{j}).*log(p(1)./p.*(p-100^2)./(p(1)-100^2));
    subplot(1,2,1)
    plot(d)
    hold on
    dc=mean(d(floor(length(d)/3):ceil(length(d)/3*2)));
    plot([floor(length(d)/3),floor(length(d)/3)],[min(d(d<1)) max(d(d<1))])
    plot([ceil(length(d)/3*2),ceil(length(d)/3*2)],[min(d(d<1)) max(d(d<1))])
    subplot(1,2,2)
    plot(t_vec{j},p)
    xlim([0 20])
    %     axis([0 20 0 max(p)])
    
    hold on
    [t,y]=ode45(@(t,y)ODEfun(t,y,dc),[0,20],p(1));
    plot(t,y,'--')
    
    load Network_ODE_data.mat
    plot(t,sum(y,2))
    
    
end

function dydt=ODEfun(t,y,d)
dydt =4*d*y*(1-y/100^2);
end