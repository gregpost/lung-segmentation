function V = getRescaledDicomVolume(dicomFolderPath)
%{
Returns a voxel volume with the correct z-scale. In most cases the
scale by z axis of DICOM volume is different from x and y axis scale.
A gap between different slices is about 2-3mm, when a gap between
voxels by x and y axis is about 1-1.5mm. This function helps to get
he voxel volume with the correct scale in each axis.

dicomFolderPath="C:/Dicom files/CT01";
%}

fprintf("Reading voxel volume and scale information...\n");
[V,spatial]=dicomreadVolume(dicomFolderPath);

% Convert 4D to 3D volume.
V = permute(V,[1,2,4,3]);

fprintf("Rescale DICOM volume...\n");
[nx,ny,nz]=size(V);
xs=mean(spatial.PixelSpacings(:,1));
ys=mean(spatial.PixelSpacings(:,2));
zs=abs(spatial.PatientPositions(nz,3)-spatial.PatientPositions(1,3))/(nz-1);
ms=max([xs ys zs]);
kx=xs/ms;
ky=ys/ms;
kz=zs/ms;
V=imresize3(V,[nx*kx ny*ky nz*kz]);

% Check existatnce of '/' symbol in the end of the folder path.
dicomFolderPath=isSlashInTheEndOfFolderPathExists(dicomFolderPath);

% Make RescaleIntercept and RescaleSlope transformation.
fp=dicomFolderPath;
fl=dir(fp);
fn=fl(3).name; % 3 becasue fl(1).name='.' and fl(2).name='..'
I=dicominfo(dicomFolderPath+fn);
ri=I.RescaleIntercept;
rs=I.RescaleSlope;
V=int32(V);
V=rs*V+ri;

fprintf("DICOM volume reading and rescaling completed.\n\n");