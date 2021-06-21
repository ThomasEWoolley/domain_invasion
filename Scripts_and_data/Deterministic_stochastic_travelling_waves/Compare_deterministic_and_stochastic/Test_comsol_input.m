ccc
z=load('Comsol_output_data.txt');
x=reshape(z(:,1),100,100);
y=reshape(z(:,2),100,100);
z(:,[1,2])=[];
imagesc(reshape(z(:,20),100,100))