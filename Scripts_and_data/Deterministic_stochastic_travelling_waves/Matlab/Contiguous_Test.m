function Test=Contiguous_Test(ss,L,W)
ToCheck=1;
Checked=[];
i=0;
while ~isempty(ToCheck)
    i=ToCheck(1);
    
    %up
    if mod(i,L)==1
        up=i+L-1;
    else
        up=i-1;
    end
    %Down
    if mod(i,L)==0
        Down=i-L+1;
    else
        Down=i+1;
    end
    
    
    if ss(up)==1 & ~ismember(up,Checked)& ~ismember(up,ToCheck)
        ToCheck=[ToCheck,up];
    end
    
    
    %Left
    if i>L
        if ss(i-L)==1 & ~ismember(i-L,Checked)& ~ismember(i-L,ToCheck)
            ToCheck=[ToCheck,i-L];
        end
    end
    
    %Down
    
    if ss(Down)==1 & ~ismember(Down,Checked)& ~ismember(Down,ToCheck)
        ToCheck=[ToCheck,Down];
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