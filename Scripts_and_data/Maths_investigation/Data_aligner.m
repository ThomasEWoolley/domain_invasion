ccc
% load ../Outputs_size_coverage/tz_vec_data_100_runs.mat
load tz_vec_data_100.mat

%%
clc
close all
if ~exist('t_vec')
%     load ../Outputs_size_coverage/tz_vec_data_100_runs.mat
    load tz_vec_data_100.mat
end


for i=1:length(t_vec)
    p=[];
    for j=1:length(t_vec{i})
        z=reshape(z_vec{i}(j,:),200,100);
        p(j)=sum(sum(z(1:100,:)));
    end
    Pops{i}=p;
    
end

%% Aligner
T=0:0.1:t_vec{1}(end);

for i=1:length(t_vec)
    Aligned_p=[];
    for j=1:length(T)
        I=find(t_vec{i}<=T(j),1,'last');
        z=reshape(z_vec{i}(I,:),200,100);
        Aligned_p(j)=sum(sum(z(1:100,:)));
    end
    Aligned_pops(:,i)=Aligned_p;
end

%% 2D Aligner
T=0:0.1:40;

for i=1:length(t_vec)
    Aligned_2d=[];
    for j=1:length(T)
        I=find(t_vec{i}<=T(j),1,'last');
        z=reshape(z_vec{i}(I,:),200,100);
        Aligned_2d(:,:,j)=z(1:100,:);
    end
    Aligned_2d_pops(:,:,:,i)=Aligned_2d;
end

%%
close all
for i=1:length(t_vec)
    plot(T,Aligned_pops,'b')
    hold on
end
plot(T,mean(Aligned_pops,2),'k')
%%
save('Processed_100_runs_r_1.mat','t_vec','T','Pops','Aligned_pops','Aligned_2d_pops','n','-v7.3')
%
% hold on
