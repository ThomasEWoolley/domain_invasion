ccc
% col=['r','b'];
Widths=[1:10 20:10:100];
l=1;
for j=Widths
    load(['Processed_100_runs_2d_r_1_width_',num2str(j),'.mat']);
    Mean_pops=mean(mean(Aligned_2d_pops,4),2);
    
    Mean_pops=squeeze(Mean_pops(:,1,:));
%     if j<50
%     Mean_pops=Mean_pops(:,1:10:end);
%     T=T(1:10:end);
%     end
    
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
    hold on
    Times_vec{l}=Times;
    Index_vec{l}=Index;
    
            [p,g]=fit(Times',Index','poly1');
            ci=confint(p,0.95);
            pm(l)=diff(ci(:,1))/2;
    c(l)=p.p1;
    l=l+1;
end

%%
close all
hold on
for i=1:length(Times_vec)
    plot(Times_vec{i},Index_vec{i},'color',[0  0.9-i/length(Times_vec)*0.9 i/length(Times_vec)*0.9]);
end
   


xlabel('Time, $t$')
ylabel('Domain width')
% legend(plo,'$n_l=3$','$n_l=4$','$n_l=5$','location','best')
set(gca,'fontsize',15)
export_fig('..\..\..\..\..\Pictures\Sim_wavespeed_1_10.png','-r300')


%%
figure
hold on
for i=1:length(Times_vec)
    plo(1)=plot(Widths(i),c(i),'o','color',[0  0.9-i/length(Times_vec)*0.9 i/length(Times_vec)*0.9]);
end
% [p,g]=fit(Widths',c',fittype('a+b*log(c*x)'), 'StartPoint', [1 1 1] );
% plot(Widths,p(Widths))
% 
% [p,g]=fit(Widths',c',fittype('a-b*exp(-c*x)'), 'StartPoint', [1 1 1] );
% plot(Widths,p(Widths))

[pp,gg]=fit(Widths',c',fittype('b*x^a1/(c+x^a2)'), 'StartPoint', [1 1 1 1] );
[p,g]=fit(Widths',c',fittype('b*x^a1/(c+x^a1)'), 'StartPoint', [1 1 1] );
plo(2)=plot(Widths,p(Widths));
ylabel('$c$')
xlabel('$n_l$')
legend(plo,'Stochastically generated data','Fitted Hill function','location','best')
set(gca,'fontsize',15)

export_fig('..\..\..\..\..\Pictures\Limiting_wavespeed.png','-r300')