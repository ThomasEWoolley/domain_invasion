ccc
load ../Prism_data/tz_vec_data_100.mat
j=20;
for i=1:length(t_vec{j})
z=reshape(z_vec{j}(i,:),200,100);
p(i)=sum(sum(z(101:200,:)));
end

%% As though it were a circle
close all
A=p(1);
T=1001;
for i=1:T
v(i)=A;
    A=floor(A-2*pi*sqrt(A/pi)*0.1);

end

plot(0:T-1,v)
hold on
plot(t_vec{j}*10,p)
% As though it were a square
A=p(1);
for i=1:T
v(i)=A;
    A=floor(A-4*sqrt(A)*0.1);

end

plot(0:T-1,v,'--')


% As though it were eliminating total area
A=p(1);
for i=1:T
v(i)=A;
    A=floor(A*0.9);

end

plot(0:T-1,v,':')