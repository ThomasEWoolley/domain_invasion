ccc
L=2;

for W=1:9 
tic
bb = fliplr(dec2bin(0:2^(L*W)-1,L*W));
A=num2str(ones(2^(L*W),1));
for i=1:W:(L)*W
    A=horzcat(A,bb(:,i:i+W-1),num2str(ones(2^(L*W),1)));
end
A(:,end)=[];
WW=W+1;

A=mat2cell(A,ones(length(A),1));

Bad_Index=zeros(size(A));
Non_contig_index=zeros(size(A));
Numbs=(1:length(A))';
length(A)

parfor i=1:length(A)
    if mod(i,100000)==1
        i
    end
    s1=A{i};
    %     for j=1:L-1
    
    CC = bwconncomp(Matrix_Maker(s1,L,WW));
    
    checker=0;
    if  checker==0 & ~Contiguous_Test(Matrix_Maker(s1,L,WW),L,WW)
        Bad_Index(i,1)=1;
        %         Non_contig_labels{i}=s1
        Non_contig_index(i,1)=1;
        checker=1;
    end
    
    s=s1;
    if checker==0
        for k=1:L
            
            
            if checker==0
                
                s=[s(WW-1+2:end) s(1:WW)];
                if find(contains(A,s),1)>i
                    Bad_Index(i,1)=1;
                    checker=1;
                end
            end
            
            if checker==0
                flipped_s=[];
                for k=L*WW:-WW:1
                    flipped_s=[flipped_s s(k-WW+1:k)];
                end
                
                if find(contains(A,flipped_s),1)>i
                    Bad_Index(i,1)=1;
                    checker=1;
                end
                
            end
        end
    end
    
    
    
    
end
Good_Indices=Numbs.*(~Bad_Index);
Good_Indices(Good_Indices==0)=[];

Contig_Indices=Numbs.*(~Non_contig_index);
Contig_Indices(Contig_Indices==0)=[];
%%
GoodA=A(Good_Indices);
ContigA=A(Contig_Indices);
Times(W)=toc;
save(['Test_Data_L_',num2str(L),'_W_',num2str(WW),'.mat'],'GoodA','ContigA','L','WW','Times')
end