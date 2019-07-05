function [V,RO] = getRespiratoryOrgansFromDicomFolder(dicomFolderPath,cr,ci)
%{

% Returns the whole respiratory organs volume (lung and airway volume)
% without separating of the left and right lung.

%dicomFolderPath = a folder where a chest or whole body study
% are stored.
% cr = radius of vessels morphological closing.
% ci = iteration count of vessels morphological closing (f.e. 3-times
% make dilation and after that 3-times make erosion.

Example (input data from dicom folder): 

dicomFolderPath = pwd+"/test_volumes/dicom";
RO=getRespiratoryOrgansFromDicomFolder(dicomFolderPath,0);

% Visualization.
showVoxelVolume(RO);

%}

% Optional parameters.
if (nargin < 2)
    cr=3;
end
if (nargin < 3)
    ci=2;
end

% Get Hounsfield unit 3d matrix.
V=getRescaledDicomVolume(dicomFolderPath);

s=size(V);

% Reduce the volume to accelerate computing.
%k=nthroot(50000000/numel(V),3);

%if (k<1)
%    fprintf("The volume is too large for computing. Reducing the volume...\n");
%    fprintf("Volume reducing coefficient: "+k+"\n");
%    V=imresize3(V,k);
%    fprintf("New voxel count: "+numel(V)+"\n");
%end

% Segment respiratory ograns.
RO=getRespiratoryOrgans(V,cr,ci);

% Restore the volume after the resizing.
RO=logical(imresize3(uint32(RO),s));