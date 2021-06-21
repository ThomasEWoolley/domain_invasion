function [t_vec,z_vec] =Single_population()
clc


poolobj = gcp('nocreate'); % If pool, do not create new one.

if isempty(poolobj)
    parpool(10);
end
% Simulate a two-state model of gene expression
import Gillespie.*
p=[];
tspan = [0, 40]; %seconds
n=100;
pfun = @(x,p)propensities_2state(x,p,n);
iter=90;
x0=IC_single_pop(n,iter);
x0reshape=reshape(x0,1,n^2);

for i=1:5
    fprintf('\t Completion: ');
    showTimeToCompletion; startTime=tic;
    pp = parfor_progress(20);
    t_vec={};
    z_vec={};
    parfor l=1:20
        [t,z] = directMethod(Update_single_pop(n), pfun, tspan,x0reshape, p);
        t_vec{l}=t;
        z_vec{l}=z;
        pp = parfor_progress;
        showTimeToCompletion( pp/100, [], [], startTime );
        
    end
    save(['Single_pop_',num2str(i),'_r_1.mat'],'t_vec','z_vec','n','-v7.3')
end

end


function a = propensities_2state(x,p,n)
% Return reaction propensities given current state x
W=reshape(x,n,n);

R=[];L=[];U=[];D=[];
for i=1:n^2
    if i<n^2-n+1%Plus 1 because strict inequality.
        R = [R;W(i)*(1-W(i+n))];
        L = [L;W(i+n)*(1-W(i))];
    end
    if mod(i,n)~=0
        U = [U;W(i+1)*(1-W(i))];
    end
    if mod(i,n)~=1
        D = [D;W(i-1)*(1-W(i))];
    end
    
end
a=[R;L;U;D;eps];
end