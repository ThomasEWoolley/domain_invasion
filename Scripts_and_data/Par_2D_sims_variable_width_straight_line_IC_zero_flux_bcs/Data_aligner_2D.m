ccc

load('./Data/Single_pop_2_r_1_Width_10.mat')
T=0:1:t_vec{1}(end);
for jj=5
    l=1;
    Aligned_2d_pops=[];
    for k=1:5
        load(['./Data/Single_pop_',num2str(k),'_r_1_width_',num2str(jj),'.mat'])
        for i=1:length(t_vec)
            Aligned_2d=[];
            parfor j=1:length(T)
                I=find(t_vec{i}<=T(j),1,'last');
                Aligned_2d(:,:,j)=reshape(z_vec{i}(I,:),Length,Width);
            end
            Aligned_2d_pops(:,:,:,l)=Aligned_2d;
            l=l+1;
        end
        
    end

    save(['Processed_100_runs_2d_r_1_width_',num2str(jj),'.mat'],'t_vec','T','Aligned_2d_pops','Length','Width','-v7.3')
end

