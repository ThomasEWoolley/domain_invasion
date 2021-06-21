ccc

if ~exist('z_vec')
    load ./Prism_data/tz_vec_data_4_days
end
T=readtable('./Prism_data/Kras HET over time.csv');
TT=table2array(T);
Bins=TT(:,1);
Week1=TT(~isnan(Bins),2:5);
Bins1=Bins(~isnan(Bins));

Week5=TT(~isnan(Bins),8:13);
Bins2=Bins1(~isnan(mean(Week5,2)));
Week5=Week5(~isnan(mean(Week5,2)),:);

%%
close all
figure('position',[0.1 0 1/3+.1 1/2 ])
m1=mean(Week1,2);
stdm1=std(Week1')';
errorbar(Bins1,m1,stdm1,stdm1,'bx')

hold on
m2=mean(Week5,2);
stdm2=std(Week5')';
errorbar(Bins2,m2,stdm2,stdm2,'rx')

ft = fittype('a*x^b');
[C,gofC] = fit(Bins1,m1,ft, 'StartPoint', [1663 -1]);
[M,gofM] = fit(Bins2,m2,ft, 'StartPoint', [200 -1]);
x=linspace(200, 1e4);
plot(x,C(x),'b--','linewidth',1)
plot(x,M(x),'r--','linewidth',1)


set(gca,'xscale','log')
axis([200,1e4,0,11])
set(gca,'yscale','log'),ylim([0.01 10])
xlabel('Kras mutant patch size $\left(\mu\textrm{m}^2\right)$')
ylabel('Kras mutant patch density $\left(\textrm{mm}^{-2}\right)$')

Decay_time=3.6;

for i=1:length(z_vec)
    z=reshape(z_vec{i}(1,:),200,100);
    Area(i)=sum(sum(z(101:200,:)));
    Diameter(i)=sqrt(Area(i)/pi)*2;
    
    [~,Index]=min(abs(t_vec{i}-Decay_time));
    z=reshape(z_vec{i}(Index,:),200,100);
    Evolved_Area(i)=sum(sum(z(101:200,:)));
end
plot(Area,C(Area),'bo')
plot(Evolved_Area,C(Area),'ro')
% legend('Kras mutant cell distribution at 7 days (mean$\pm$standard deviation)','Kras mutant cell distribution at 35 days (mean$\pm$standard deviation)','Power law fit 7 days','Power law fit 35 days','Initial condition','Modelling prediction at 35 days','location','best')
set(gca,'fontsize',15)
legend('Kras mutant cell distribution at 7 days (mean$\pm$standard deviation)','Kras mutant cell distribution at 35 days (mean$\pm$standard deviation)','Power law fit 7 days','Power law fit 35 days','Initial condition','Modelling prediction at 35 days','location','best','fontsize',10)
export_fig('../../Pictures/Size_density_plot.png','-r300')