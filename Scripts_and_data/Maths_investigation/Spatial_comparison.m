ccc
load 'Processed_100_runs'
%%
Z=mean(Aligned_2d_pops,4);
ICs=reshape(IC(100,100),200,100);
ICs=ICs(1:100,:);
[t,y]=ode45(@(t,y)ODE_network(t,y,100,0.06),T,reshape(ICs,100^2,1));

figure('position',[0 0 1 1])
for i=1:401
    subplot(1,3,1)
    imagesc(Z(:,:,i)),caxis([0 1])
    subplot(1,3,2)
    imagesc(reshape(y(i,:),100,100)),caxis([0 1])
    subplot(1,3,3)
imagesc(Z(:,:,i)-reshape(y(i,:),100,100)),caxis([0 1])
    drawnow
end






function dydt=ODE_network(t,y,N,d)
m=reshape(y,N,N);
% m=round(m);
dydt=0.06*reshape((ones(N,N)-m).*(m*diag(ones(N-1,1),-1)+m*diag(ones(N-1,1),1)+...
    diag(ones(N-1,1),-1)*m+diag(ones(N-1,1),1)*m),N^2,1);

end
