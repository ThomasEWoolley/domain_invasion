ccc
Name='Ten_species_runs.mat';
% load OneD_100_runs_r_1.mat
load(Name)

T=0:0.5:max(t_vec{1});

for i=1:length(t_vec)
    for j=1:length(T)
        Index=find(t_vec{i}<=T(j),1,'last');
        p(j,:,i)=z_vec{i}(Index,:);
        Pop(j,i)=sum(z_vec{i}(Index,:));
    end
end

for i=1:n
Pop_prob(:,i)=mean((Pop==i),2);
Pop_sd(:,i)=std((Pop==i),0,2);
end
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
save(Name,'T','Pop','p'...
    ,'Pop_prob','Pop_sd','-append')