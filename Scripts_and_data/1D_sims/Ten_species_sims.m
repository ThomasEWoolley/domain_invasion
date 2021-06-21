function [t_vec,z_vec] =OneD_sims()
clc
% Simulate a two-state model of gene expression
import Gillespie.*
p=[];
tspan = [0, 20]; %seconds
n=10;
l=1;
pfun = @(x,p)propensities_2state(x,p,n);
% iter=100;
% for i=1:5
r=1;
for l=1:1000
    
    x0=zeros(1,n);
    x0(1)=1;
    SM=stoich_matrix(n);
    
    
    [t,z] = directMethod(SM, pfun, tspan, x0, r);
    t_vec{l}=t;
    z_vec{l}=z;
    
end

    save(['Ten_species_runs.mat'],'t_vec','z_vec','n','r')
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
