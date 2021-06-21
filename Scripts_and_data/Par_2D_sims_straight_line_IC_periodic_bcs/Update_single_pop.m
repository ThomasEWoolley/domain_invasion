function Interactions=Update_single_pop(n)
Right=eye(n^2);
Left=eye(n^2);
Up=eye(n^2);
Down=eye(n^2);

Right=[Right;Right(1:n,:)];
Right(1:n,:)=[];
% Left(n^2-n+1:n^2,:)=[];

for i=n^2:-1:1
    
    if mod(i,n)==0
        Up(i,:)=[];
    end
    
    
    if mod(i,n)==1
        Down(i,:)=[];
    end
end


Interactions=[Right;Left;Up;Down;zeros(1,n^2)];