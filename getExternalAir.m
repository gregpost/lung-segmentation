function EA = getExternalAir(EAL)
%{

Returns the volume which is connected with the edge surfaces of
the voxel scene (except the top surface, because lungs can have
a connection with the top surface).

EAL = eroded lung-and-air binarized volume.

%}

fprintf("Computing of label connected components...\n");

V=bwlabeln(EAL);

fprintf("Measure properties of objects...\n");

R=regionprops3(V,'BoundingBox','VoxelList');

fprintf("External air segmentation...\n");

n=height(R);
s=size(EAL);
EA=zeros(s,'logical');
for i=1:n
    x0=R(i,1).BoundingBox(1);
    y0=R(i,1).BoundingBox(2);
    x1=x0+R(i,1).BoundingBox(4);
    y1=y0+R(i,1).BoundingBox(5);
    if (x0 < 1 || x1 > s(1)-1 || y0 < 1 || y1 > s(2)-1)
        mat=cell2mat(R(i,2).VoxelList);
        ms=size(mat);
        for j=1:ms(1)
            % This is not a mistake: 2,1,3 is the correct order.
            x=mat(j,2);
            y=mat(j,1);
            z=mat(j,3);
            EA(x,y,z)=1;
        end
    end
end