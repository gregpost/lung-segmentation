function nifti2dicom(niftiFilePath, dicomFolderPath)
% Converts .nii file to a group of .dcm files.
% Input data example:
%niftiFilePath="C:\Users\GregP\Documents\MATLAB\lung_001.nii";
%dicomFolderPath="C:\Users\GregP\Documents\MATLAB\dicom3";

% For example, convert:
% PixelDimensions: [0.6934 0.6934 1]
% to
% PixelDimensions: [1 1 1.4422]
In=niftiinfo(niftiFilePath);
d=In.PixelDimensions;
for i=1:2
    if (d(1) ~= 1)
        k=1/d(1);
        d(1)=1;
        d(2)=d(2)*k;
        d(3)=d(3)*k;
    end
end

% Add "/" to the end of file path.
if (~endsWith(dicomFolderPath, ["/", "\"]))
    dicomFolderPath = dicomFolderPath + "/";
end

% Create dicom files.
load('info','I');
V=niftiread(niftiFilePath);
Vu=uint16(V+1024);
zsize=In.ImageSize(3);
I.SliceLocation=408;
I.ImagePositionPatient(3) = I.SliceLocation;
for z=1:zsize
    str_z="000"+z;
    if (z >= 10 && z < 100)
        str_z="00"+z;
    end
    if (z >= 100)
        str_z="0"+z;
    end
    dicomFilePath=dicomFolderPath + "IM-0001-"+str_z+"-0001.dcm";
    I.Filename=dicomFilePath;
    I.InstanceNumber=z;
    r=round(rand(1)*10000);
    I.SOPInstanceUID="1.3.6.1.4.1.9590.100.1.2.7182821551160378910080939147200927"+r;
    dicomwrite(Vu(:,:,z), dicomFilePath, I);
    I.SliceLocation = I.SliceLocation + 1;
    I.ImagePositionPatient(3) = I.SliceLocation;
end