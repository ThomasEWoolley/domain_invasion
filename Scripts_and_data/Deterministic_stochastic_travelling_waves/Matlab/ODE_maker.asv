clear
close all
clc

load('Test_Data_L_5_W_5.mat')

tic
Coeffdata=cell(1,length(GoodA));
Stringdata=cell(1,length(GoodA));
parfor k=1:length(GoodA)
    
%     if mod(k,100)==1
%         k
%     end
    a=GoodA{k};
    %     a
    Strings=[];
    Coeffs=[];
    %     Matrix_Maker(a,L,WW)
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
                    Strings{l}={GoodString};
                    l=l+1;
                    Coeffs=[Coeffs;CalculatePartners(b,i,L,WW)];
                end
                
            else
                CP=CalculatePartners(a,i,L,WW);
                if CP>0
                    Strings{l}={a};
                    l=l+1;
                    Coeffs=[Coeffs;-CP];
                end
            end
        end
    end
%     Alldata(:,k)={GoodA{k} Coeffs Strings};
%     Alldata(:,k)={GoodA{k};Coeffs;Strings};
    Coeffdata(k)={Coeffs};
    Stringdata(k)={Strings};
end
toc
% save('AllData.mat','Alldata','L','WW')
n=length(GoodA);
save(['Test_AllData_L_',num2str(L),'_W_',num2str(WW),'.mat'],'GoodA','Stringdata','Coeffdata','L','WW','n')
% save(['Test_AllData_L_',num2str(L),'_W_',num2str(WW),'.mat'],'GoodA','L','WW','n')
% save(['Test_CoeffData_L_',num2str(L),'_W_',num2str(WW),'.mat'],'Coeffdata')
% save(['Test_StringData_L_',num2str(L),'_W_',num2str(WW),'.mat'],'Stringdata')

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