ccc
GoodA_size_calc(1)=0;
GoodA_size_calc(2)=1;
for i=2:5
    
    load(['Test_Data_L_5_W_',num2str(i),'.mat']);
    
    Domain_width(i)=i;
    All_size(i)=2^(3*(i-1));
    ContigA_size(i)=length(ContigA);
    GoodA_size(i)=length(GoodA);
    
%     try
%         GoodA_size_rem(i)=GoodA_size(i)-2*GoodA_size(i-1)-GoodA_size(i-2)-3+i;
%     end
%     try
%         GoodA_size_calc(i)=2*GoodA_size(i-1)+GoodA_size(i-2)+3-i;
%     end
    
end
% f1=@(n)(1/4)*(2-sqrt(2))*(1-sqrt(2)).^n-1+(1/4)*(1+sqrt(2)).^n*(2+sqrt(2));
% f2=@(n)(1/8)*(2-sqrt(2))*(1-sqrt(2)).^n+(1/8)*(1+sqrt(2)).^n*(2+sqrt(2))+(1/2).*n-1/2;

% figure('position',[0 0 1/2 1/2])
Domain_width(1)=1;
All_size(1)=1;
semilogy(Domain_width,All_size,'bo')
hold on
ContigA_size(1)=1;
plot(Domain_width,ContigA_size,'ro')
GoodA_size(1)=1;
plot(Domain_width,GoodA_size,'ko')
% plot(Domain_width,f1(Domain_width),'r')
% plot(Domain_width,f2(Domain_width),'k')
xlabel('$n_w$')
legend('Number of all states','Number of contiguous states',['Number of contiguous states' newline 'after symmetries removed'],'Algebraic $C(n_w)$','Algebraic, $U(n_w)$','location','eo')
axis tight
set(gca,'fontsize',15)
% export_fig('..\..\..\..\..\..\Pictures\Number_of_eqns_fig.png','-r300')
