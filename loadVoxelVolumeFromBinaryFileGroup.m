function V = loadVoxelVolumeFromBinaryFileGroup(folderPath)
%folderPath="C:/Users/GregP/Documents/MATLAB/binary/fissures/";

%Read dimensions of the voxel volume from the file.
filePath=folderPath+"dimensions";
fileID = fopen(filePath,'r');
s=int32(fread(fileID,3,'int32'));
fclose(fileID);

%Read the voxel volume from the file.
xysize = s(1)*s(2);
V=int32(zeros(s(1), s(2), s(3)));
for z=1:s(3)
    fprintf("Reading the slice %d...\z",z);
    
    % Read the voxel volume.
    filePath=folderPath+"z"+z;
    fileID = fopen(filePath,'r');
    A = int32(fread(fileID,xysize,'int32'));
    fclose(fileID);
    
    %Convert 1-dimension to 3-dimension coordinates.
    for y=1:s(2)
        for x=1:s(1)
            index=(y-1)*s(1)+x;
            V(x,y,z)=A(index);
        end
    end
end

fprintf("Voxel volume loaded from the file.\n\n");