function RO = getRespiratoryOrgans(V,cr,ci)
%{

% Returns the whole respiratory organs volume (lung and airway volume)
% without separating of the left and right lung.

% V = base volume with radiodensity data in Hounsfield units.
% cr = radius of vessels morphological closing.
% ci = iteration count of vessels morphological closing (f.e. 3-times
% make dilation and after that 3-times make erosion.

% Example (input data from .mat file):

matFilePath=pwd+"/test_volumes/volume.mat";
load(matFilePath,'V');
RO=getRespiratoryOrgans(V);

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

fprintf("\nRespiratory organs segmetnation...\n");

V=double(V);
AL=~imbinarize(V,-300);
SE=strel('sphere',3);
EAL=imerode(AL,SE);
EA=getExternalAir(EAL);
DEA=EA;
for i=1:4
    DEA=imdilate(DEA,SE);
    DEA=DEA&AL;
end
IAL=AL-DEA;
RO=getMaxObject(IAL);
if (cr > 0)
    RO=closeVoxelVolume(RO,cr,ci);
end

fprintf("Respiratory organs segmentation completed.\n\n");