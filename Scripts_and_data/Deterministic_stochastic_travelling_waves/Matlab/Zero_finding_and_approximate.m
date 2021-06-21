ccc
tt=linspace(0,10);
f1=@(t)(403/1152.*t-5/24.*(t.^2)+60277/110592).*exp(-10.*t)+(5/4.*(t.^2)+41/48.*t-125/192).*exp(-8.*t)+(9/2.*(t.^3)+99/32.*(t.^2)+1239/256.*t+3745/1024).*exp(-6.*t)+(1503/32.*(t.^2)+6103/32.*t+27/8.*(t.^3)+26993/108).*exp(-4.*t)+(-27/4.*(t.^4)+423/8.*(t.^3)-11343/64.*(t.^2)+488741/1536.*t-3114841/12288).*exp(-2.*t);
f2=@(t)(1503/32.*(t.^2)+6103/32.*t+27/8.*(t.^3)+26993/108).*exp(-4.*t)+(-27/4.*(t.^4)+423/8.*(t.^3)-11343/64.*(t.^2)+488741/1536.*t-3114841/12288).*exp(-2.*t);

figure('position',[0 0 .75 .4])
plot(tt,f1(tt),'b')
hold on
plot(tt,f2(tt),'k')
plot(2.738,0,'ro')
axis([0 10 -1e-1 1e-1])
xlabel('Time, $t$')
legend('$\dot{\mathcal{P}}\left(\begin{array}{ccccccc}1&1&1&1&0&\dots&0\\1&1&1&1&0&\dots&0\end{array}\right)$','First two exponential terms of $\dot{\mathcal{P}}\left(\begin{array}{ccccccc}1&1&1&1&0&\dots&0\\1&1&1&1&0&\dots&0\end{array}\right)$')
set(gca,'fontsize',15)
export_fig('..\..\..\..\..\Pictures\Full_approximate_solution.png','-r300')