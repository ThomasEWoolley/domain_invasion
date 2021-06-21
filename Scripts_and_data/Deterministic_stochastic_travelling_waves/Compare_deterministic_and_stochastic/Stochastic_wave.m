ccc
load('Processed_100_runs_2d_r_1_width_1.mat')
x=1:100;
z=squeeze(mean(Aligned_2d_pops,4));
pcolor(T,x,z)
caxis([0,1])
shading interp
hold on
[~,WavePoint]=max((z'<0.5),[],2);
WaveX=x(WavePoint);
T=T(WaveX>1);
WaveX=WaveX(WaveX>1);
plot(T,WaveX,'--k')
fit(T',WaveX','poly1')
% % figure
% % plot(T(2:end),diff(WaveX)./diff(T))
% % axis([0 100 0 2])