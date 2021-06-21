% ccc
clear
close all
clc
x=[10000 2000 1000 500 350 250 200]
y=[0 1 2 3 4 5 6]


loglog(x,y,'*')
hold on
xx=linspace(200,1e4);

loglog(xx,282.8./xx.^0.7284)

%%
figure
semilogx(x,y,'*')
hold on
semilogy(xx,316.7./xx.^0.7487)