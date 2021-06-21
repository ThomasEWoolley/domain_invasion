function [Interactions,z]=Matrices_with_IC(n,z)
x=ones(n,n);
% [z,x]=IC(n);
z=reshape(z,1,2*n^2);
Right=nan(n^2-n,2*n^2,'double');
Left=nan(n^2-n,2*n^2,'double');
Up=nan(n^2-n,2*n^2,'double');
Down=nan(n^2-n,2*n^2,'double');
l1=1;l2=1;l3=1;l4=1;
for i=1:n^2
    
    if i>n
    R=0*x;
    R(i)=1;
    R=[R;-R];
    R=reshape(R,1,2*n^2);
    Right(l1,:)=R;
    l1=l1+1;
    end
    
    if i<=n^2-n
        R=0*x;
    R(i)=1;
    R=[R;-R];
    R=reshape(R,1,2*n^2);
    Left(l2,:)=R;
    l2=l2+1;
    end
    if mod(i,n)~=0
        R=0*x;
        R(i)=1;
        R=[R;-R];
        R=reshape(R,1,2*n^2);
        Up(l3,:)=R;
        l3=l3+1;
    end
    if mod(i,n)~=1
        R=0*x;
        R(i)=1;
        R=[R;-R];
        R=reshape(R,1,2*n^2);
        Down(l4,:)=R;
        l4=l4+1;
    end
end
Interactions=[Right;Left;Up;Down;0*R];