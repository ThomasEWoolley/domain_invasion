ccc
load('Test_data.mat')

tic
for k=1%:310
    l=1;
    a=Matrix_Maker(GoodA{123},L,WW);
    for i=1:L
        for j=2:WW
            b=a;
            b(i,j)=0;
            h1(l,1)=Contiguous_Test(b,L,WW);
            l=l+1;
        end
    end
end
toc

tic
for k=1%:310
    l=1;
    a=GoodA{123};
    for i=1:L*WW
        if mod(i,WW)~=1
            b=a;
            b(i)='0';
            h2(l,1)=max(ismember(ContigA,b));
            l=l+1;
        end
    end
end
toc