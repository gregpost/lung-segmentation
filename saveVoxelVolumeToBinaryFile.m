function saveVoxelVolumeToBinaryFile(V, filePath)
%filePath="C:/Users/GregP/Documents/MATLAB/binary/fissures";

fileID = fopen(filePath,'w');

% Write dimensions of the voxel volume to the file.
s=size(V);
fwrite(fileID,s,'int32');

% Write the voxel volume to the file.
fwrite(fileID,V,'int32');

% Close the file.
fclose(fileID);