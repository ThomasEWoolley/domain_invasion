ccc

c=[0 1.255000975, 1.495823777, 1.563133997, 1.579015864, 1.582804904, 1.584045930, 1.584633143, 1.584974638];
xv=1:length(c);
plot(xv,c,'--ob')
hold on
yline(1.6)
xlabel('$i$')
ylabel('$c$')
set(gca,'fontsize',15)
axis([1 9 0 1.7])
% axis tight
export_fig('..\..\..\..\..\Pictures\Wavespeed_over_domain.png','-r300')
%%
ccc
fig=figure('position',[0 0 .25 .45])
for j=1:2
    load(['Processed_100_runs_2d_r_1_width_',num2str(j),'.mat']);
    [~,index]=min(abs(T-50));
    Meaned_pops=mean(Aligned_2d_pops,4);
    if j==1
        subplot(8,1,[1:2])
    else
        subplot(8,1,[4:7])
        
    end
    imagesc(Meaned_pops(:,:,index)')
    if j==1
        title('$n_l=1$')
        axis([0 100 0.5 1.5])
        yticks([1])
        xticks('')
    else
        title('$n_l=2$')
        axis([0 100 0.5 2.5])
        yticks([1 2])
        yline(1.5)
        xlabel('Domain width')
        %         colormap on
    end
    
    set(gca,'fontsize',15)
end
han=axes(fig,'visible','off');
han.YLabel.Visible='on';
ylabel(han,'Domain length')
set(gca,'fontsize',15)
export_fig('..\..\..\..\..\Pictures\ThreeD_sims.png','-r300')
%%
ccc
% fig=figure('position',[0 0 .25 .45])
col=['r','b'];
for j=1:2
    load(['Processed_100_runs_2d_r_1_width_',num2str(j),'.mat']);
    [~,index]=min(abs(T-50));
    Meaned_pops=mean(Aligned_2d_pops,4);
    plot(1:100,mean(Meaned_pops(:,:,index),2),'color',col(j));
    hold on
end
xlabel('Domain width')
ylabel('$\langle W \rangle$')
set(gca,'fontsize',15)
legend('$n_l=1$','$n_l=2$','location','best')
export_fig('..\..\..\..\..\Pictures\TwoD_sims.png','-r300')

%%
ccc
col=['r','b'];
for j=1:2
    load(['Processed_100_runs_2d_r_1_width_',num2str(j),'.mat']);
    Mean_pops=mean(mean(Aligned_2d_pops,4),2);
    
    Mean_pops=squeeze(Mean_pops(:,1,:));
    Mean_pops=Mean_pops(:,1:10:end);
    T=T(1:10:end);
    
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
    [p,g]=fit(Times',Index','poly1');
    hold on
    
    if j==1
        plo(j)=plot(Times,Index,'color',[1,0,0]);
        plot(Times,p(Times),'--','color',[1 0.6 0.6])
        ht = text(25,p(25)+5,['Gradient = ',num2str(round(p.p1,1)),'.0']);
        set(ht,'Rotation',40,'fontsize',12)
    else
        plo(j)=plot(Times,Index,'color',[0,0,1]);
        plot(Times,p(Times),'--','color',[0.6 0.6 1])
        ht = text(25,p(25)+10,['Gradient = ',num2str(round(p.p1,1))]);
        set(ht,'Rotation',50,'fontsize',12)
    end
    
end

xlabel('Time, $t$')
ylabel('Domain width')
legend(plo,'$n_l=1$','$n_l=2$','location','best')
set(gca,'fontsize',15)
export_fig('..\..\..\..\..\Pictures\Sim_wavespeed.png','-r300')