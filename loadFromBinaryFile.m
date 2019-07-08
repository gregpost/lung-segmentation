function V = loadFromBinaryFile(filePath)
%filePath="C:/Users/GregP/Documents/MATLAB/binary/voxel-map";
%filePath="C:/Users/GregP/Documents/MATLAB/binary/base-volume";

fprintf("Loading voxel volume from file...\n");

fileID = fopen(filePath);

% Read dimensions of a voxel volume.
sizeV = int32(fread(fileID,3,'int32'));
xsize=sizeV(1);
ysize=sizeV(2);
zsize=sizeV(3);

% Read the voxel volume.
S = xsize*ysize*zsize;
A = int32(fread(fileID,S,'int32'));
fclose(fileID);

fprintf("Converting 1-dimension to 3-dimension coordinates...\n");

% Convert 1-dimension to 3-dimension coordinates.
xysize=xsize*ysize;
V=zeros(ysize, xsize, zsize);
for z=1:zsize
    %fprintf("z= " + z + "\n");
    zoffset=(z-1)*xysize;
    for y=1:ysize
        zyoffset=zoffset+(y-1)*xsize;
        for x=1:xsize            
            index=zyoffset+x;
            V(y,x,z)=A(index);
        end
    end
end

fprintf("Voxel volume loaded.\n");