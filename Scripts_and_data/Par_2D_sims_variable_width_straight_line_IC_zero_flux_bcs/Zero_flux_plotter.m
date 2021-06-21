ccc
load Processed_100_runs_2d_r_1_width_10.mat
Mean_pops1=squeeze(mean(Aligned_2d_pops,4));
T1=T;
load Processed_100_runs_2d_r_1_width_100.mat
Mean_pops2=squeeze(mean(Aligned_2d_pops,4));
T2=T;

%%
close all
clc
fig=figure('position',[0 0.1 1/3 1/3]);
i=21;
subplot(2,1,1)
hold on
pcolor(squeeze(Mean_pops1(:,:,i))')
Plot_surf=squeeze(Mean_pops1(:,:,i))';
[~,WavePoint]=max((Plot_surf<0.5),[],2);
plot(smooth(WavePoint,4),1:length(WavePoint),'k')
shading interp
caxis([0 1])
% axis([0 100 0 10])
axis tight
set(gca,'fontsize',15)

i=201;
subplot(2,1,2)
hold on
pcolor(squeeze(Mean_pops2(:,:,i))')
Plot_surf=squeeze(Mean_pops2(:,:,i))';
[~,WavePoint]=max((Plot_surf<0.5),[],2);
plot(smooth(WavePoint,25),1:length(WavePoint),'k')
shading interp
caxis([0 1])
% axis([0 100 0 100])
axis tight
set(gca,'fontsize',15)
xlabel('Domain width')

han=axes(fig,'visible','off'); 
han.YLabel.Visible='on';
ylabel(han,'Domain length');
set(gca,'fontsize',15)

export_fig('../../Pictures/Stochastic_neumann.png','-r300')