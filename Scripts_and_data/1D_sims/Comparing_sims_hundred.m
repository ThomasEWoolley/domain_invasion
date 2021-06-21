ccc

r=1;
t=linspace(0,10,100);
l=1;
for i=1:2:10
    Anal_p(:,i)=(r*t).^(i-1)/factorial(i-1).*exp(-r*t);
    l=l+1;
end

figure('position',[0 0 1/2 1/3])
plot(t,Anal_p)
% hold on
% plot(t,w(:,4),'r')
% plot(t,w(:,6),'b')
% plot(t,w(:,8),'k')
% 
% t=linspace(0,5,10);
% u100 = exp(-t);
% u110 = t.*exp(-t);
% u111 = 1-t.*exp(-t)-exp(-t);
% plot(t,u100,'rd')
% plot(t,u110,'bd')
% plot(t,u111,'kd')
% 
% load('../Three_species_runs.mat')
% errorbar(T,Pop1_prob,Pop1_sd/sqrt(length(t_vec)),'r--')
% errorbar(T,Pop2_prob,Pop2_sd/sqrt(length(t_vec)),'b--')
% errorbar(T,Pop3_prob,Pop3_sd/sqrt(length(t_vec)),'k--')
% legend('$\mathcal{P}(1,0,0)$','$\mathcal{P}(1,1,0)$','$\mathcal{P}(1,1,1)$','location','best')
% xlabel('Time, $t$')
% xlim([0 5])
% export_fig('../../../Pictures/Three_species_sims')
% 
% 
% 
% function dwdt=ODE_fun(t,w,r)
% dwdt=r*[0;
%         -w(2);
%         -2*w(3);
%         -w(4);
%         w(2)-w(5)+w(3);
%         w(4)-w(6)+w(3);
%         -2*w(7);
%         w(5)+w(6)+2*w(7)];
% end