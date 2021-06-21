ccc
load('Ten_species_runs.mat')
r=1;
cols={'r','b','g','y','m','k'};
% t=linspace(0,10,100);
l=1;
for i=1:9
    Anal_p(:,i)=(r*T).^(i-1)/factorial(i-1).*exp(-r*T);
    l=l+1;
end

figure('position',[0 0 1/2 1/3])
l=1;
hold on
for i=1:2:10
plot(T,Anal_p(:,i),cols{l})
l=l+1;
end
plot(T,1-sum(Anal_p,2),cols{end})

l=1;
for i=[1:2:10,10]
    errorbar(T,Pop_prob(:,i),Pop_sd(:,i)/sqrt(length(t_vec)),'--','color',cols{l})
    l=l+1;
end


legend('$\mathcal{P}_1$','$\mathcal{P}_3$'...
    ,'$\mathcal{P}_5$','$\mathcal{P}_7$'...
    ,'$\mathcal{P}_9$','$\mathcal{P}_{10}$','location','best')
xlabel('Time, $t$')
xlim([0 15])
export_fig('../../Pictures/Ten_species_sims.png','-r300')


