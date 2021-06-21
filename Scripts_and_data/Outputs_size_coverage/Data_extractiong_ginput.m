clear
close all
clc
img = imread('Kras.png');
image('CData',flipud(img),'XData',[200 1e4],'YData',[0 10])
hold on
xlim([200 1e4])
ylim([0 10])
set(gca,'xscale','log')
% ginput
%%
clear
close all
clc


load tz_vec_data_100.mat
Control=   1.0e+03*[
    0.2025    0.0081
    0.2191    0.0076
    0.2502    0.0068
    0.3204    0.0052
    0.3831    0.0042
    0.4716    0.0035
    0.5751    0.0028
    0.6859    0.0025
    0.7680    0.0023
    0.8655    0.0020
    0.9653    0.0017
    1.1819    0.0014
    1.3374    0.0011
    1.5454    0.0011
    1.7281    0.0009
    1.9477    0.0009
    2.5669    0.0006];

Mutant=   1.0e+03 *[
    0.2015    0.0029
    0.2641    0.0024
    0.3281    0.0019
    0.3801    0.0016
    0.5023    0.0014
    0.5691    0.0013
    0.6707    0.0010
    0.7781    0.0009
    0.9653    0.0009
    1.1528    0.0007
    1.3533    0.0007
    1.7056    0.0005
    1.9554    0.0006];
%%
close all
clc
Cx=Control(:,1);
Cy=Control(:,2);
Mx=Mutant(:,1);
My=Mutant(:,2);
figure('position',[0 0 .3 .5])
lh1=semilogx(Control(:,1),Control(:,2),'b')
hold on
lh2=semilogy(Mutant(:,1),Mutant(:,2),'r')
lh1.Color=[0,0,1,0.25];
lh2.Color=[1,0,0,0.25];
% fo = fitoptions('Method','NonlinearLeastSquares',...
%                'Lower',[0,0],...
%                'Upper',[Inf,max(cdate)],...
%                'StartPoint',[1 1]);
ft = fittype('a*x^b');
[C,gofC] = fit(Cx,Cy,ft, 'StartPoint', [1663 -1]);
[M,gofM] = fit(Mx,My,ft, 'StartPoint', [200 -1]);
x=linspace(200, 1e4);
plot(x,C(x),'b--','linewidth',1)
plot(x,M(x),'r--','linewidth',1)

xlim([200 1e4])
ylim([0 10])



for i=1:length(z_vec)

    Reshaped_z=reshape(z_vec{i}(1,:),200,100);
    Mutant_image=Reshaped_z(101:200,1:100);
    Mut_pop_t1(i)=sum(Mutant_image(:));
end

How_many_data=C(Mut_pop_t1(1))*min(Mut_pop_t1)./Mut_pop_t1;
semilogx(Mut_pop_t1,How_many_data,'b*')
hold on
Decay_time=3.5;
for i=1:length(z_vec)
    [~,Index]=min(abs(t_vec{i}-Decay_time));
    Reshaped_z=reshape(z_vec{i}(Index,:),200,100);
    Mutant_image=Reshaped_z(101:200,1:100);
    Mut_pop_td(i)=sum(Mutant_image(:));
end

semilogx(Mut_pop_td,How_many_data,'r*')
xlabel('Cluster size ($\mu$m$^2$)')
ylabel('Cluster density (mm$^{-2}$)')

legend('KrasG12D 7 days','KrasG12D 35 days','Power law fit 7 days','Power law fit 35 days','7 day distribution used as initial condition','Modelling prediction 35 days')

export_fig('Size_density_plot.tiff','-r300')
