function [O,m] = getMaxObject(V)
%Returns the largest object in the voxel volume.

fprintf("Maximal object segmentation...\n");
fprintf("Computing of label connected components...\n");
V=bwlabeln(V);
fprintf("Measure properties of objects...\n");
R=regionprops3(V,'Volume','VoxelList');
fprintf("Generating voxel map with largest object...\n");
v=R(:,1).Volume;
[m,i]=max(v);
[nx, ny, nz] = size(V);
O=logical(zeros(nx,ny,nz));
mat=cell2mat(R(i,2).VoxelList);
ms=size(mat);
for j=1:ms(1)
    % This is not a mistake: 2,1,3 is the correct order.
    x=mat(j,2);
    y=mat(j,1);
    z=mat(j,3);
    O(x,y,z)=1;
end