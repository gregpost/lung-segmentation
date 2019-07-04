p1="C:\Users\GregP\Documents\MATLAB\binary\14_FISSURES_BOLDYREV";
F=loadVoxelVolumeFromBinaryFile(p1);

p2="D:\Tomograms\Chest_CT\PA000014\ST000001\SE000002";
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