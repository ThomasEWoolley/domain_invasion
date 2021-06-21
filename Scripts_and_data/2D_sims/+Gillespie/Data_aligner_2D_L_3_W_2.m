ccc

% load('./Data_300/Single_pop_2_r_1_Width_7.mat')
load('./Single_pop_2_L_3_W_2.mat')
T=0:0.01:3;
for jj=1:10
    l=1;
    Aligned_2d_pops=[];
    for k=1:10
        load(['./Single_pop_',num2str(k),'_L_',num2str(Length),'_W_',num2str(Width),'.mat'])
        for i=1:length(t_vec)
            Aligned_2d=[];
            for j=1:length(T)
                I=find(t_vec{i}<=T(j),1,'last');
                Aligned_2d(:,:,j)=reshape(z_vec{i}(I,:),Length,Width);
            end
            Aligned_2d_pops(:,:,:,l)=Aligned_2d;
            l=l+1;
        end
        
    end
    
    save(['Processed_L_3_W_2.mat'],'t_vec','T','Aligned_2d_pops','Length','Width','-v7.3')
end