function O = getMaxObject(V)
%Returns the largest object in the voxel volume.

fprintf("Maximal object volume segmentation...\n");

V=bwlabeln(V);
R=regionprops3(V,'Volume');
v=R(:,1).Volume;
[m,i]=max(v);
[nx, ny, nz] = size(V);
O=logical(zeros(nx,ny,nz));
for x=1:nx
    for y=1:ny
        for z=1:nz
            if (V(x,y,z) == i)
                O(x,y,z)=1;
            end
        end
    end
end