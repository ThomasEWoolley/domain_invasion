ccc
load Processed_100_runs_2d_r_1_width_10.mat
Mean_pops=squeeze(mean(Aligned_2d_pops,4));
%%

% for i=1:length(t_vec{1})
% %     pcolor(reshape(z_vec{1}(i,:),Length,n))
%     pop(i)=sum(z_vec{1}(i,:));
% %     drawnow
% end
close all
for i=1:length(T)
    pcolor(squeeze(Mean_pops(:,i,:)))
    shading interp
    caxis([0 1])
    drawnow
end
%%
% close all
% t=t_vec{1};
% p=pop;
% t(p==0)=[];
% p(p==0)=[];
% plot(t,p)