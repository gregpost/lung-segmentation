
addpath("C:\Users\GregP\Documents\MATLAB\lung-segmentation");
addpath("C:\Users\GregP\Documents\MATLAB\frangi_filter_version2a");
addpath("C:\Users\GregP\Documents\MATLAB\bwdistsc");
addpath("C:\Users\GregP\Documents\MATLAB\viewer3d_version12a\ReadData3D\dicom");
addpath("C:\Users\GregP\Documents\MATLAB\phi-max-skeleton3d-matlab-18c7dc3");

p1="C:\Users\GregP\Documents\MATLAB\binary\1_FISSIRES_KAZAKOVA"
F=loadVoxelVolumeFromBinaryFile(p1);

p2="D:\Tomograms\Chest_CT\PA000001\ST000001\SE000002";
L=getRespiratoryOrgansFromDicomFolder(p2);
E=dilate(L,3,1,'sphere')&~L;

F2=E|F;
DT=bwdist(F2);
DTM=getByMask(DT,L);

DTO=zeros(size(DTM),'int32');
s=size(DTO);
for x=1:s(1)
    fprintf("x=%d\n",x);
    for y=1:s(2)
        for z=1:s(3)
            v=DTM(x,y,z);
            if (v ~= 0)
                DTO(x,y,z)=v+300;
            end
        end
    end
end
fprintf("OK\n");

p3="C:\Users\GregP\Documents\MATLAB\dicom9";
saveVoxelVolumeToDicomFile(DTO, p2, p3);







p4="C:\Users\GregP\Documents\MATLAB\binary\KAZAKOVA\L1";
L1=loadVoxelVolumeFromBinaryFile(p4);