ccc
load Single_pop_1_r_1.mat
%%

for i=1:10:length(t_vec{1})
    pcolor(reshape(z_vec{1}(i,:),n,n))
    pop(i)=sum(z_vec{1}(i,:));
    drawnow
end
%%
close all
t=t_vec{1};
p=pop;
t(p==0)=[];
p(p==0)=[];
plot(t,p)