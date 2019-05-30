function CL = getRespiratoryOrgans(BV)
%{

Returns the whole respiratory organs volume:
lung and airway volume. 

Example:

load('volume','V');
L=getRespiratoryOrgans(V);

% Visualization.
showVoxelVolume(L,3);

%}

fprintf("\nRespiratory organs segmetnation...\n");

BV=imresize3(BV,0.5);
AL=~imbinarize(BV,-300);
SE=strel('sphere',3);
EAL=imerode(AL,SE);
EA=getExternalAir(EAL);
DEA=EA;
for i=1:4
    DEA=imdilate(DEA,SE);
    DEA=DEA & AL;
end
IAL=AL-DEA;
L=getMaxObject(IAL);
SE=strel('sphere',6);
CL=imclose(L,SE);
CL=logical(imresize3(int32(CL),2));

fprintf("Respiratory organs segmentation completed.\n\n");