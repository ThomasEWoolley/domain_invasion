ccc
figure('position',[0 0.1 1 0.6])
fs=15;
%% Stochastics
load('Processed_100_runs_2d_r_1_width_1.mat')
x=1:100;
z=squeeze(mean(Aligned_2d_pops,4));
subplot(1,16,[1 2])
pcolor(T,x,z)
caxis([0,1])
shading interp
hold on
[~,WavePoint]=max((z'<0.5),[],2);
WaveX=x(WavePoint);
T=T(WaveX>1);
WaveX=WaveX(WaveX>1);
plot(T,WaveX,'--k')
f{1}=fit(T',WaveX','poly1');
xlabel('Time, $t$')
ylabel('Space')
set(gca,'fontsize',fs)
%% Burger discrete
load Burger_discrete.mat
subplot(1,16,[4 5])
pcolor(T,1:n,y1')
caxis([0,1])
shading interp
hold on
plot(Tw,WaveX,'--k')
f{2}=fit(Tw(Tw>20)',WaveX(Tw>20)','poly1');
set(gca,'fontsize',fs)
%% Burger pdepe
load Burger_pdepe.mat
subplot(1,16,[7 8])
pcolor(t,x,u')
caxis([0,1])
shading interp
hold on
plot(t,WaveX,'--k')
f{3}=fit(t(t>20)',WaveX(t>20)','poly1');
set(gca,'fontsize',fs)
%% Fisher discrete
load Fisher_discrete.mat
subplot(1,16,[10 11])
pcolor(T,1:n,y1')
caxis([0,1])
shading interp
hold on
plot(Tw,WaveX,'--k')
f{4}=fit(Tw(Tw>20)',WaveX(Tw>20)','poly1');
set(gca,'fontsize',fs)
%% Fisher pdepe
load Fisher_pdepe.mat
subplot(1,16,[13 14])
pcolor(t,x,u')
shading interp
caxis([0,1])
hold on
plot(t,WaveX,'--k')

f{5}=fit(t(t>20)',WaveX(t>20)','poly1');
set(gca,'fontsize',fs)
%%
subplot(1,16,[15 16])
caxis([0 1])
colorbar
axis off
set(gca,'fontsize',fs)
export_fig('..\..\..\Pictures\Simulation_methods.png','-r300')
%%

figure('position',[0 0.1 0.5 0.5])
clf
for i=1:length(f)
    hold on
    ci=confint(f{i});
    errorbar(i,f{i}.p1,f{i}.p1-ci(1,1),ci(2,1)-f{i}.p1,'o','linewidth',3)
end
xticks(1:5)
ax = gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = '';
myLabels={'Stochastic','Discrete','Continuum','Discrete','Continuum';
    'simulation','advection','advection','PDE','PDE'};
for i = 1:length(myLabels)
    text(i, ax.YLim(1)-0.005, sprintf('%s\n%s\n%s', myLabels{:,i}), ...
        'horizontalalignment', 'center', 'verticalalignment', 'top','fontsize',13);    
end
ylabel({'Wave speed and';'95\% confidence interval'})
ax.XLabel.String = sprintf('\n\n\n%s', 'Simulation method');
set(gca,'fontsize',15)
drawnow
export_fig('..\..\..\Pictures\Wavespeed_sims.png','-r300')
