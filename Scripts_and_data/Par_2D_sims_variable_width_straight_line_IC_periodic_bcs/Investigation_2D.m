ccc

for j=1:2
    load(['Processed_100_runs_2d_r_1_width_',num2str(j),'.mat']);
    Mean_pops=squeeze(mean(mean(Aligned_2d_pops,4),2));
    
    Index=[];
    Times=[];
    for i=1:2:length(T)
        if max(Mean_pops(:,i))>0.6 & min(Mean_pops(:,i))<0.4
            Index(i)=find(Mean_pops(:,i)<0.5,1,'first');
            Times(i)=T(i);
            
        end
    end
    
    
    
    
    
    Times(Index==0)=[];
    Index(Index==0)=[];
    
%     subplot(2,5,j)
    [p,s] = polyfit(Times',Index',1)
    [f,delta] = polyval(p,Times,s);
    hold on
    
    plot(Times,Index)
    plot(Times,f,'--r')
end
