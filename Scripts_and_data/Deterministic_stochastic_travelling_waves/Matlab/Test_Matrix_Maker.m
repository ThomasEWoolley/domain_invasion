ccc
s='100000001110001110000001110001000000111000000111'
ss=Matrix_Maker(s,6,8)

tic
Contiguous_Test(ss,6,8)
toc

tic
BW=bwconncomp(ss,4);
if BW.NumObjects>1
    0
else
    1
end
toc

function ss=Matrix_Maker(s,L,W)
ss=[];
for i=1:length(s)
    ss=[ss,s(i),' '];
end
ss=reshape(str2num(ss),W,L)';
end

function Test=Contiguous_Test(ss,L,W)
ToCheck=1;
Checked=[];
i=0;
while ~isempty(ToCheck)
    i=ToCheck(1);
    
    %up
    if i>1
        if ss(i-1)==1 & ~ismember(i-1,Checked)& ~ismember(i-1,ToCheck)
            ToCheck=[ToCheck,i-1];
        end
    end
    
    %up
    if i>L
        if ss(i-L)==1 & ~ismember(i-L,Checked)& ~ismember(i-L,ToCheck)
            ToCheck=[ToCheck,i-L];
        end
    end
    
    %Down
    if i<L*W
        if ss(i+1)==1 & ~ismember(i+1,Checked)& ~ismember(i+1,ToCheck)
            ToCheck=[ToCheck,i+1];
        end
    end
    
    %Right
    if i<L*W-L+1
        if ss(i+L)==1 & ~ismember(i+L,Checked)& ~ismember(i+L,ToCheck)
            ToCheck=[ToCheck,i+L];
        end
    end
    Checked=[Checked,ToCheck(1)];
    ToCheck(1)=[];
end

if sum(ss(:))==numel(Checked)
    Test=1;
else
    Test=0;
end

end
