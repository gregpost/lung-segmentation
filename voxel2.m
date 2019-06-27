function voxel(i,c)

x=[
  i(1)+[0 0 0 0 1 1 1 1];
  i(2)+[0 0 1 1 0 0 1 1];
  i(3)+[0 1 0 1 0 1 0 1]
];

for n=1:3
    if n==3
        x=sortrows(x,[3,1]);
    else
        x=sortrows(x,[n n+1]);
    end
    
    temp=x(3,:);
    x(3,:)=x(4,:);
    x(4,:)=temp;
    h=patch(x(1:4,1),x(1:4,2),x(1:4,3),c);
    set(h,'FaceAlpha',1);
    set(h,'EdgeColor','none');
    
    temp=x(7,:);
    x(7,:)=x(8,:);
    x(8,:)=temp;
    h=patch(x(5:8,1),x(5:8,2),x(5:8,3),c);
    set(h,'FaceAlpha',1);
    set(h,'EdgeColor','none');
end










x=sortrows(x,[1 2]);

temp=x(3,:);
x(3,:)=x(4,:);
x(4,:)=temp;
h=patch(x(1:4,1),x(1:4,2),x(1:4,3),c);
set(h,'FaceAlpha',1);
set(h,'EdgeColor','none');

temp=x(7,:);
x(7,:)=x(8,:);
x(8,:)=temp;
h=patch(x(5:8,1),x(5:8,2),x(5:8,3),c);
set(h,'FaceAlpha',1);
set(h,'EdgeColor','none');