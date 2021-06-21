ccc
load('DEsolves_L_2_W_3.mat')
tt=linspace(0,3);
% for i=1:length(GoodA)
%    p(:,i)=eval(['y',GoodA{i},'(tt)']);
% ['y',GoodA{i}];
%    
% end

p=[y100100(tt);y100110(tt);y100111(tt);y110110(tt);y101111(tt);y110111(tt);y111111(tt)]

plot(tt,p)

Names={'$\mathcal{P}_1$','$\mathcal{P}_2$','$\mathcal{P}_3$','$\mathcal{P}_4$','$\mathcal{P}_5$','$\mathcal{P}_6$','$\mathcal{P}_7$'};
legend(Names)
xlabel('Time, $t$')
ylabel('Probability')
export_fig('..\..\..\..\..\Pictures\Solutions_grid_2_3.png','-r300')


%%

ccc
load('DEsolves_L_2_W_3.mat')
tt=linspace(0,3);
hold on
plot(tt,tt.*exp(-tt),'b')
plot(tt,y110110(tt),'r')
plot([1 1],[0 exp(-1)],'--b')
tc=eval(solve(diff(y110110,t)==0));
plot([1 1]*tc,[0 y110110(tc)],'--r')

Names={'$\mathcal{P}(1,1,0)$','$\mathcal{P}\left(\begin{array}{ccc} 1 & 1 &0\\1 & 1 &0 \end{array}\right)$'};
legend(Names)
xlabel('Time, $t$')
ylabel('Probability')
export_fig('..\..\..\..\..\Pictures\Comparing_first_step.png','-r300')
