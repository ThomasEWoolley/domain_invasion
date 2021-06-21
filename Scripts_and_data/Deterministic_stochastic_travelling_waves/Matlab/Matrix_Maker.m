function ss=Matrix_Maker(s,L,W)
ss=[];
for i=1:length(s)
    ss=[ss,s(i),' '];
end
ss=reshape(str2num(ss),W,L)';
end