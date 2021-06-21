ccc

load('Processed_100_runs_2d_width_100.mat')
%%
clc
Pops=mean(Aligned_2d_pops,4);
[~,~,l]=size(Pops);
Zr=[];R=[];
for i=1:l
    pcolor(Pops(:,:,i))
    drawnow
end
%%
close all
Mean_pops=squeeze(mean(Pops,2));
for i=1:l
    
    plot(Mean_pops(:,i))
    title(num2str(T(i)))
    drawnow
end

%%

clc
close
Index=[];
for i=1:l
    if max(Mean_pops(:,i))>0.6 & min(Mean_pops(:,i))<0.4
        Index(i)=find(Mean_pops(:,i)<0.5,1,'first');
        Times(i)=T(i);
        %     else
        %         T(i)
        %         i
    end
end

Times(Index==0)=[];
Index(Index==0)=[];

plot(Times,Index)
p = polyfit(Times',Index',1)
f = polyval(p,Times);
hold on
plot(Times,f,'--r')

