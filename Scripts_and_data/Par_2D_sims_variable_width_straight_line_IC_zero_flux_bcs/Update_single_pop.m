function Interactions=Update_single_pop(length,width)
Right=eye(length*width);
Left=eye(length*width);
Up=eye(length*width);
Down=eye(length*width);

Right(1:length,:)=[];
Left(length*width-length+1:length*width,:)=[];

for i=length*width:-1:1
    
    if mod(i,length)==0
        Up(i,:)=[];
    end
    
    
    if mod(i,length)==1
        Down(i,:)=[];
    end
end


Interactions=[Right;Left;Up;Down;zeros(1,length*width)];