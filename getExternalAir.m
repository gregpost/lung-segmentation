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

oc=height(R);
s=size(EAL);
EA=logical(zeros(s(1),s(2),s(3)));
for i=1:oc
    x0=R(i,1).BoundingBox(1);
    y0=R(i,1).BoundingBox(2);
    z0=R(i,1).BoundingBox(3);
    x1=x0+R(i,1).BoundingBox(4);
    y1=y0+R(i,1).BoundingBox(5);
    if (x0 < 1 || x1 > s(1)-1 || y0 < 1 || y1 > s(2)-1 || z0 < 1)
        mat=cell2mat(R(i,2).VoxelList);
        ms=size(mat);
        for j=1:ms(1)
            x=mat(j,2);
            y=mat(j,1); %this is not a mistake: y=1,x=2
            z=mat(j,3);
            EA(x,y,z)=1;
        end
    end
end