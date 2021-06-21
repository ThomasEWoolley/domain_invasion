ccc
load Single_pop_1_r_1

%%
clc
close all
if ~exist('t_vec')
    load Single_pop_1_r_1
end


for i=1:length(t_vec)
    p=[];
    for j=1:length(t_vec{i})
        z=reshape(z_vec{i}(j,:),n,n);
        p(j)=sum(sum(z(1:100,:)));
    end
    Pops{i}=p;
    
end

%% Aligner
T=0:0.1:40;

for i=1:length(t_vec)
    Aligned_p=[];
    for j=1:length(T)
        I=find(t_vec{i}<=T(j),1,'last');
        z=reshape(z_vec{i}(I,:),n,n);
        Aligned_p(j)=sum(z(:));
    end
    Aligned_pops(:,i)=Aligned_p;
end

%% 2D Aligner
T=0:0.1:40;

for i=1:length(t_vec)
    Aligned_2d=[];
    for j=1:length(T)
        I=find(t_vec{i}<=T(j),1,'last');
        z=reshape(z_vec{i}(I,:),n,n);
        Aligned_2d(:,:,j)=z;
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
save('Single_pop_1_r_1_aligned.mat','t_vec','T','Pops','Aligned_pops','Aligned_2d_pops','n','-v7.3')
%
% hold on
