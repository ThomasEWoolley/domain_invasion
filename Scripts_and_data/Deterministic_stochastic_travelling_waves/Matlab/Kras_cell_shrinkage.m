clear
close all
clc
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

for i=[1 5000 7000]
    z1=reshape(z(i,:),2*n,n);
    W(:,:,i)=z1(1:n,:);
end
%%
close all
figure('position',[0 0.1 .75 1/3])
subplot(1,3,1)
imagesc(W(:,:,1))
title('$t=0$')
colormap([1 0 0;0 1 0])
axis square
set(gca, 'YDir','normal')
axis([0 100 0 100])
ylabel('Length')
xlabel('Width')
set(gca,'fontsize',15)
subplot(1,3,2)
imagesc(W(:,:,5000))
title('$t=9.1$')
set(gca,'fontsize',15)
axis square
axis off
subplot(1,3,3)
imagesc(W(:,:,7000))
title('$t=14.6$')
set(gca,'fontsize',15)
axis square
axis off
export_fig('..\..\..\..\..\Pictures\Kras_cell_shrinkage.png','-r300')