ccc

c3=[0 1.282219995, 1.628396244, 1.774863417, 1.827519943, 1.844472507, 1.850321050];
c4=[0 1.282225875, 1.654859477, 1.845385079, 1.934196320];
c5=[0 1.281305800, 1.656559799, 1.862779059];

hold on
col=['r','b','k'];
for i=3:5
    cc=eval(['c',num2str(i)]);
x=1:length(cc);
xx=linspace(1,10);
hh = fittype('a*(1-exp(-b*(x-1)))');
[p,g]=fit(x',cc',hh);
ci = confint(p,0.95)
plot(x,cc,'o','color',col(i-2))
plo(i-2)=plot(xx,p(xx),col(i-2))
if i==5
plo(i-1)=plot(xx,ci(2,1)*(1-exp(-ci(1,2)*(xx-1))),'--','color',col(i-2))
else

end
% plot(xx,ci(1,1)*(1-exp(-ci(2,2)*(xx-1))),'-','color',col(i-2))
end
yline(1.8706,'r');
yline(1.9696,'b');
yline(2.0946,'k');
legend(plo,'$n_l=3$','$n_l=4$','$n_l=5$','$n_l=5$ upper limit','location','best')
xlabel('$i$')
ylabel('$c$')
set(gca,'fontsize',15)
axis([2 8 1.2 2.2])
% axis tight
export_fig('..\..\..\..\..\Pictures\Wavespeed_over_domain_345.png','-r300')
%%
ccc
fig=figure('position',[0 0.1 .25 .45])
for j=3:5
    load(['Processed_100_runs_2d_r_1_width_',num2str(j),'.mat']);
    [~,index]=min(abs(T-25));
    Meaned_pops=mean(Aligned_2d_pops,4);
    if j==3
        subplot(13,1,[1:3])
    elseif j==4
        subplot(13,1,[4:7])
    elseif j==5
        subplot(13,1,[8:12])
    end
    imagesc(Meaned_pops(:,:,index)')
    
%     title(['$n_l= $',num2str(j)])
    for ii=1:j
        yline(ii-0.5)
        yticks(1:j)
    end
    xticks('')
%     if j==1
%         title('$n_l=1$')
%         axis([0 100 0.5 1.5])
%         yticks([1])
%         xticks('')
%     else
%         title('$n_l=2$')
%         axis([0 100 0.5 2.5])
%         yticks([1 2])
%         yline(1.5)
%         xlabel('Domain width')
%         %         colormap on
%     end
%     
    set(gca,'fontsize',15)
end
xticks(0:10:100)
xlabel('Domain width')
han=axes(fig,'visible','off');
han.YLabel.Visible='on';
ylabel(han,'Domain length')
set(gca,'fontsize',15)
export_fig('..\..\..\..\..\Pictures\ThreeD_sims_345.png','-r300')
%%
ccc
% fig=figure('position',[0 0 .25 .45])
col=['r','b','k'];
for j=3:5
    load(['Processed_100_runs_2d_r_1_width_',num2str(j),'.mat']);
    [~,index]=min(abs(T-25));
    Meaned_pops=mean(Aligned_2d_pops,4);
    plot(1:100,mean(Meaned_pops(:,:,index),2),'color',col(j-2));
    hold on
end
xlabel('Domain width')
ylabel('$\langle W \rangle$')
set(gca,'fontsize',15)
legend('$n_l=3$','$n_l=4$','$n_l=5$','location','best')
export_fig('..\..\..\..\..\Pictures\TwoD_sims_345.png','-r300')

%%
ccc
col=['r','b'];
for j=3:5
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
    p.p1
    hold on
    
    if j==3
        plo(j-2)=plot(Times,Index,'color',[1,0,0]);
        plot(Times,p(Times),'--','color',[1 0.6 0.6])
%         ht = text(25,p(25)+5,['Gradient = ',num2str(round(p.p1,1)),'.0']);
%         set(ht,'Rotation',40,'fontsize',12)
    elseif j==4
        plo(j-2)=plot(Times,Index,'color',[0,0,1]);
        plot(Times,p(Times),'--','color',[0.6 0.6 1])
    elseif j==5
        plo(j-2)=plot(Times,Index,'color',[0,0,0]);
        plot(Times,p(Times),'--','color',0.6*[1 1 1])
%         ht = text(25,p(25)+10,['Gradient = ',num2str(round(p.p1,1))]);
%         set(ht,'Rotation',50,'fontsize',12)
    end
    
end

xlabel('Time, $t$')
ylabel('Domain width')
legend(plo,'$n_l=3$','$n_l=4$','$n_l=5$','location','best')
set(gca,'fontsize',15)
export_fig('..\..\..\..\..\Pictures\Sim_wavespeed_345.png','-r300')