ccc
load tz_vec_data_100.mat
n=100;
fs=15;

close all
pop=[];
W=[];
figure('position',[0 0 1/3 .5])
hold on
l=1;
iter=length(z_vec)
z=z_vec{iter};

for i=1:length(t_vec{iter})
    z1=reshape(z(i,:),2*n,n);
    W(:,:,i)=z1(1:n,:);
end
pop{iter}=squeeze(sum(sum(W)));
%%
clc
close all
plot(t_vec{iter},pop{iter}/max(pop{iter}),'g')
hold on
plot(t_vec{iter},1-pop{iter}/max(pop{iter}),'r')

xlabel('Time, $t$')
ylabel('Normalised tissue area')
legend('Healthy','Mutant','location','best')
xlim([0 20])
set(gca,'fontsize',fs)
export_fig('..\..\..\..\..\Pictures\Kras_cell_shrinkage_population.png','-r300')