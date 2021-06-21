ccc
load Processed_L_3_W_2.mat
M=mean(Aligned_2d_pops,4);

for i=1:1:30
imagesc(M(:,:,i))
drawnow
end

%%
close all
M1D=squeeze(mean(M,2));
[~,t5]=min(abs(M1D(2,:)-0.5))
for i=t5
plot(M1D(:,i))
axis([1 3 0 1])
drawnow
end
T(t5)
%%
close all
plot(T,M1D(2,:))
hold on
E=-2*exp(-2*T)*(1/3)+exp(-4*T)+2*exp(-5*T)*(1/3)+2*exp(-4*T).*T+(2*(3*T-3/2)).*exp(-2*T)-6*exp(-2*T).*T+2;
plot(T,E/2)