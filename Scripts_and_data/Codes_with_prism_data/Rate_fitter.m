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

m1=mean(Week1,2);
m2=mean(Week5,2);

ft = fittype('a*x^b');
[C,gofC] = fit(Bins1,m1,ft, 'StartPoint', [1663 -1]);
[M,gofM] = fit(Bins2,m2,ft, 'StartPoint', [200 -1]);

for i=7:length(z_vec)
    z=reshape(z_vec{i}(1,:),200,100);
    Area(i-6)=sum(sum(z(101:200,:)));
end




%%
close all
clc
x=exp(1/M.b*log(C(Area)/M.a));
y=M(x);
hold on
plot(Area,C(Area),'o')
plot(Area,M(Area),'o')
plot(x,y)
l=1;
Error=[];
Decay_time=linspace(3.2,3.3);
for d=Decay_time
    for i=7:length(z_vec)
        [~,Index]=min(abs(t_vec{i}-d));
        z=reshape(z_vec{i}(Index,:),200,100);
        Evolved_Area(i-6)=sum(sum(z(101:200,:)));
    end
%     [Area', Evolved_Area'];
%     plot(Evolved_Area,C(Area),'*')
    drawnow
    Error(l)=sum((M(Evolved_Area)-C(Area)).^2);
    l=l+1;
end
[~,Decay_time_iterate]=min(Error)
plot(Evolved_Area,C(Area),'*')
set(gca,'yscale','log')
set(gca,'xscale','log')
[Area', Evolved_Area']