ccc

N=100;

%%
clc
close all
if ~exist('t_vec')
    load tz_vec_data_100.mat
end

for j=20
    
    z=reshape(z_vec{j}(1,:),200,100);
    IC=z(1:100,:);
%     spy(IC);
    
    [t,y]=ode45(@(t,y)ODE_network(t,y,N),[0,20],reshape(IC,N^2,1));
    
%     subplot(1,2,1)
    plot(t,sum(y,2))
%     for i=1:length(t)
%         subplot(1,2,2)
%         pcolor(reshape(y(i,:),N,N))
%         shading interp
%         colorbar
%         caxis([0 1])
%         drawnow
%     end
%     
    
end
% save('Network_ODE_data.mat','t','y')

function dydt=ODE_network(t,y,N)
m=reshape(y,N,N);
dydt=0.618*reshape((ones(N,N)-m).*(m*diag(ones(N-1,1),-1)+m*diag(ones(N-1,1),1)+...
    diag(ones(N-1,1),-1)*m+diag(ones(N-1,1),1)*m),N^2,1);

end