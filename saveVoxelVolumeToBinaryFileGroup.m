function saveVoxelVolumeToBinaryFileGroup(V, folderPath)
%folderPath="C:\Users\GregP\Documents\MATLAB\binary\fissures\";

% Write dimensions of the voxel volume to the file.
filePath=folderPath+"dimensions";
fileID = fopen(filePath,'w');
s=size(V);
fwrite(fileID,s,'int32');
fclose(fileID);
    
for z=1:s(3)
    fprintf("Writing the slice "+z+"...\n");
    
    % Write voxel volume to the file.
    filePath=folderPath+"z"+z;
    fileID = fopen(filePath,'w');    
    for x=1:s(1)
        fwrite(fileID,V(x,:,z),'int32');
    end
    
    % Close the file.
    fclose(fileID);
end

fprintf("Voxel volume saved to the file.\n\n");



