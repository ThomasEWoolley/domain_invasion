ccc
load('Test_Data_L_2_W_3.mat')


%%
tic
for k=1:length(GoodA)
    
    
        if mod(k,1000)==1
            k
        end
    a=GoodA{k};
    eval(['syms y',num2str(a),'(t)';])
    S=0;

    l=1;
    for i=1:L*WW
        if mod(i,WW)~=1
            
            if str2double(a(i))==1
                b=a;
                b(i)='0';
                if max(ismember(ContigA,b))
                    
                    
                    if max(ismember(GoodA,b))
                        GoodString=GoodA{ismember(GoodA,b)};
                    else
                        GoodString=FindwhichsymmtryisinGoodA(b,GoodA,L,WW);
                    end
                    CP=CalculatePartners(b,i,L,WW);
                    
                    S=S+eval(['CP*y',GoodString]);
                end
                
            else
                CP=CalculatePartners(a,i,L,WW);
                if CP>0
                    S=S+eval(['-CP*y',a]);
                end
            end
        end
    end
    
    eval(['eqn=diff(y',num2str(a),',t)==S;']);
    if k==1
        eval(['cond = y',num2str(a),'(0)==1;']);
    else
        eval(['cond = y',num2str(a),'(0)==0;']);
    end
    eval(['y',num2str(a),'(t)=dsolve(eqn,cond);'])
end
toc
% save('AllData.mat','Alldata','L','WW')
n=length(GoodA);
save(['DEsolves_L_',num2str(L),'_W_',num2str(WW),'.mat'])

function n=CalculatePartners(a,i,L,W)
up=mod(i-W,L*W);
if up==0
    up=L*W;
end
right=i+1;
left=i-1;
down=mod(i+W,L*W);
if down==0
    down=L*W;
end

if mod(i,W)==1
    n=str2double(a(up))+str2double(a(down))+str2double(a(right));
elseif mod(i,W)==0
    n=str2double(a(up))+str2double(a(down))+str2double(a(left));
else
    n=str2double(a(up))+str2double(a(down))+str2double(a(right))+str2double(a(left));
    
end


end

function [GoodString,checker]=FindwhichsymmtryisinGoodA(s,GoodA,L,W)
checker=0;

for k=1:L
    
    if checker==0
        flipped_s=[];
        for kk=L*W:-W:1
            flipped_s=[flipped_s s(kk-W+1:kk)];
        end
        
        if max(ismember(GoodA,flipped_s))
            GoodString=GoodA{ismember(GoodA,flipped_s)};
            checker=1;
        end
        
    end
    
    if checker==0
        s=[s(W-1+2:end) s(1:W)];
        if max(ismember(GoodA,s))
            GoodString=GoodA{ismember(GoodA,s)};
            checker=1;
        end
    end
    
    
end


end