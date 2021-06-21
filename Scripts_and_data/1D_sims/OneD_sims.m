function [t_vec,z_vec] =OneD_sims()
clc
% Simulate a two-state model of gene expression
import Gillespie.*
p=[];
tspan = [0, 80]; %seconds
n=100;
l=1;
pfun = @(x,p)propensities_2state(x,p,n);
% iter=100;
% for i=1:5
r=1;
for l=1:102
    l
    
    x0=zeros(1,n);
    x0(1)=1;
    SM=stoich_matrix(n);
    
    
    [t,z] = directMethod(SM, pfun, tspan, x0, r);
    t_vec{l}=t;
    z_vec{l}=z;
    
end

    save(['OneD_100_runs_r_1.mat'],'t_vec','z_vec','n','r')
% save('tz_vec_data_100_runs_faster_load.mat','t_vec','z_vec')
% end
end


function a = propensities_2state(x,r,n)
% Return reaction propensities given current state x
R=x(1:n-1).*(1-x(2:n));
L=x(2:n).*(1-x(1:n-1));
a=r*[R';L';eps];
end

function SM=stoich_matrix(n)
I=eye(n);
R=I(2:n,:);
L=I(1:n-1,:);

SM=[R;L;zeros(1,n)];
end
