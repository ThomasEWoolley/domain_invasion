ccc

load OneD_100_runs_r_1.mat

T=0:0.1:max(t_vec{1});

for i=1:length(t_vec)
    for j=1:length(T)
        Index=find(t_vec{i}<=T(j),1,'last');
        p(j,:,i)=z_vec{i}(Index,:);
        Pop(j,i)=sum(z_vec{i}(Index,:));
    end
end

%%
close all
P=mean(p,3);

pcolor(T,1:100,P')
shading interp
caxis([0,1])

plot(T,Pop,'k')
hold on
plot(T,mean(Pop,2),'b')
close all
plot(diff(mean(Pop,2))./diff(T))
save('OneD_100_runs_r_1.mat','T','Pop','p','-append')