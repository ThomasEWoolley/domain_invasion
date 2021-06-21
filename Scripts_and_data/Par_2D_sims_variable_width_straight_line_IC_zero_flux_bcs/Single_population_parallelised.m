function [t_vec,z_vec] =Single_population()
clc
poolobj = gcp('nocreate'); % If pool, do not create new one.

if isempty(poolobj)
    parpool(8);
end
% Simulate a two-state model of gene expression
import Gillespie.*
p=[];
tspan = [0, 100]; %seconds


for Width=5;
    Length=100;
        pfun = @(x,p)propensities_2state(x,p,Length,Width);
        x0=IC_single_pop(Length,Width);
        x0reshape=reshape(x0,1,Length*Width);
    
    for i=1:5
        fprintf('\t Completion: ');
        showTimeToCompletion; startTime=tic;
        pp = parfor_progress(20);
        t_vec={};
        z_vec={};
        parfor l=1:20
            [t,z] = directMethod(Update_single_pop(Length,Width), pfun, tspan,x0reshape, p);
            t_vec{l}=t;
            z_vec{l}=z;
            pp = parfor_progress;
            showTimeToCompletion( pp/100, [], [], startTime );
        end
        save(['Single_pop_',num2str(i),'_r_1_Width_',num2str(Width),'.mat'],'t_vec','z_vec','Width','Length','-v7.3')
    end
    
end




end


function a = propensities_2state(x,p,Length,Width)
% Return reaction propensities given current state x
W=reshape(x,Length,Width);

R=[];L=[];U=[];D=[];

for i=1:Length*Width
    if i<Length*Width-Length+1%Plus 1 because strict inequality.
        R = [R;W(i)*(1-W(i+Length))];
        L = [L;W(i+Length)*(1-W(i))];
    end
    if mod(i,Length)~=0
        U = [U;W(i+1)*(1-W(i))];
    end
    if mod(i,Length)~=1
        D = [D;W(i-1)*(1-W(i))];
    end
    
end

a=[R;L;U;D;eps];
end