ccc
N=100;
z=IC(N,N);
X=[];
Y=[];
B=bwboundaries(z(101:200,:));
for k=1:length(B)
boundary = B{k};
x=boundary(:,2);
y=boundary(:,1);

y(x==1|x==N)=[];
x(x==1|x==N)=[];

x(y==1|y==N)=[];
y(y==1|y==N)=[];
X=[X;x];
Y=[Y;y];
end
plot(X,Y)
2*sqrt(pi*(100^2-sum(sum(1:100))))