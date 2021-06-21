ccc
r=1;

T=linspace(0,100,50);
for i=1:100
    l=1;
    for t=T
        s=0;
        for j=1:i-1            
            s=s+(r*t)^(j-1)/factorial(j-1);
        end
        W(i,l)=1-exp(-r*t)*s;
        l=l+1;
    end
end

imagesc(T,1:100,W)
xlim([0 100])
xlabel('Time, $t$')
ylabel('Compartment')
colorbar
set(gca, 'YDir','normal')
export_fig('../../Pictures/Travelling_wave_1D_anal.png','-r300')