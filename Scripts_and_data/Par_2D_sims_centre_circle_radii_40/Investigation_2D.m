ccc

load('Processed_100_runs_2d_r_1.mat')
%%
clc
Pops=mean(Aligned_2d_pops,4);
[~,~,l]=size(Pops);
Zr=[];R=[];
for i=1:l
    pcolor(Pops(:,:,i))
    [Zr(:,i), R(:,i)]=radialavg(Pops(:,:,i),100);
    drawnow
end

%%
close
clc

for i=1:l
plot(R(:,1)*50,Zr(:,i))

title(num2str(T(i)))
drawnow
end
%%

clc
close
Index=[];
for i=1:l
    if max(Zr(:,i))>0.6 & min(Zr(:,i))<0.4
        Index(i)=find(Zr(:,i)<0.5,1,'first');
        Times(i)=T(i);
%     else
%         T(i)
%         i
    end
end

Times(Index==0)=[];
Index(Index==0)=[];

plot(Times,R(Index,1)*50)
p = polyfit(Times',R(Index,1)*50,1)
f = polyval(p,Times);
hold on
plot(Times,f,'--r')

