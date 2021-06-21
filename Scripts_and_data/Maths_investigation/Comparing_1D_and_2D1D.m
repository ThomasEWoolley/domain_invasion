ccc
load('..\1D_sims\OneD_100_runs_r_1.mat')

Mean_pop=mean(p,3);
%%
T1=T;
close all
subplot(1,4,1)
pcolor(T1,1:100,Mean_pop')
shading interp

%%
load('..\Par_2D_sims_straight_line_IC\Processed_100_runs_2d_r_1.mat')
Mean_2D_pop=mean(Aligned_2d_pops,4);

subplot(1,4,3)
pcolor(T,1:100,squeeze(mean(Mean_2D_pop,2)))
shading interp



for i=1:length(T1)
    subplot(1,4,2)
    plot(Mean_pop(i,:))
    subplot(1,4,4)
    plot(mean(Mean_2D_pop(:,:,i),2))
    drawnow
end