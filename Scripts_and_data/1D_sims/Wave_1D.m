ccc
load('Hundred_species_runs.mat')
M=mean(p,3);
imagesc(T,1:100,M')
set(gca, 'YDir','normal')
xlim([0 100])
xlabel('Time, $t$')
ylabel('Compartment')
colorbar
hold on
for i=1:length(T)
[~,Index]=find(M(i,:)>0.5,1,'last');
Position(i)=Index;
end
plot(T,Position,'k')
export_fig('../../Pictures/Travelling_wave_1D.png','-r300')


figure

plot(T(1:end-1),diff(Position)./diff(T))
xlim([0 100])
xlabel('Time, $t$')
ylabel('Approximate wave speed')
export_fig('../../Pictures/Wave_speed_1D.png','-r300')
