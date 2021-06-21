ccc

% load OneD_100_runs_r_1.mat
load('Three_species_runs.mat')

T=0:0.1:max(t_vec{1});

for i=1:length(t_vec)
    for j=1:length(T)
        Index=find(t_vec{i}<=T(j),1,'last');
        p(j,:,i)=z_vec{i}(Index,:);
        Pop(j,i)=sum(z_vec{i}(Index,:));
    end
end
Pop1_prob=mean((Pop==1),2);
Pop1_sd=std((Pop==1),0,2);
Pop2_prob=mean((Pop==2),2);
Pop2_sd=std((Pop==2),0,2);
Pop3_prob=mean((Pop==3),2);
Pop3_sd=std((Pop==3),0,2);
%%
close all
P=mean(p,3);

imagesc(T,1:3,P')
shading interp
caxis([0,1])
figure
plot(T,Pop,'k')
hold on
plot(T,mean(Pop,2),'b')

figure
plot(diff(mean(Pop,2))./diff(T))
% save('OneD_100_runs_r_1.mat','T','Pop','p','-append')
save('Three_species_runs.mat','T','Pop','p'...
    ,'Pop1_prob','Pop2_prob','Pop3_prob'...
    ,'Pop1_sd','Pop2_sd','Pop3_sd','-append')