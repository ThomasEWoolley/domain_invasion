ccc

for i=1:10
    load(['Processed_100_runs_2d_r_1_width_',num2str(i),'.mat']);
    Mean_pops{i}=mean(Aligned_2d_pops,4);
end
%%

close all
for i=1:10:length(T)
    for j=1:10
        subplot(2,5,j)
        pcolor([Mean_pops{j}(:,:,i),zeros(Length,1)])
        %         shading interp
        caxis([0 1])
    end
    drawnow
    
end
%%
close all
for j=1:10
    MeanMean_pops(:,:,j)=mean(Mean_pops{j},2);
end

for i=1:10:length(T)
    for j=1:10
        subplot(2,5,j)
        
        plot(MeanMean_pops(:,i,j))
        ylim([0 1])
        %         shading interp
        %         caxis([0 1])
    end
    
    drawnow
end

