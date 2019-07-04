












addpath("C:\Users\GregP\Documents\MATLAB\lung-segmentation");
addpath("C:\Users\GregP\Documents\MATLAB\frangi_filter_version2a");
addpath("C:\Users\GregP\Documents\MATLAB\bwdistsc");
addpath("C:\Users\GregP\Documents\MATLAB\viewer3d_version12a\ReadData3D\dicom");


%dp="D:\Tomograms\Anonimous - 1516125\Pet Petct_Wholebody_Routine (Adult)\CT WB 1.5 B30f - 4";
%dp="D:\Tomograms\Chest_CT\PA000001\ST000001\SE000002";
srcDicomSeriesFolderPath="D:\Tomograms\Chest_CT\PA000001\ST000001\SE000002";
V=getRescaledDicomVolume(srcDicomSeriesFolderPath);

% Reduce the volume to accelerate computing.
%k=nthroot(50000000/numel(V),3);
%if (k<1)
%    fprintf("The volume is too large for computing. Reducing the volume...\n");
%    fprintf("Volume reducing coefficient: "+k+"\n");
%    Vr=imresize3(V,k);
%    fprintf("New voxel count: "+numel(Vr)+"\n");
%end

CRO=getRespiratoryOrgans(V);


%saveVoxelVolumeToBinaryFileGroup(F,"C:/Users/GregP/Documents/MATLAB/binary/fissures/");




Vd=double(V);
A=~imbinarize(Vd,-900);
LA=~imbinarize(Vd,-300);
[T,CL,EL1,EL2]=getTracheaFromRespiratoryOrgans(CRO,A,LA);

DT1=bwdist(EL1);
DT2=bwdist(EL2);
NNT=DT1<DT2;
L1=CL&NNT;
L2=CL&(~NNT);








CROs=getByMask(V,CRO);
F=getFissures(CROs,1);







E1=L1&(~erode(L1,3,1,'sphere'));
E2=L2&(~erode(L2,3,1,'sphere'));
F1=F&L1|E1;
F2=F&L2|E2;
DT1=bwdist(F1);
DT2=bwdist(F2);
DTM1=getByMask(DT1,L1);
DTM2=getByMask(DT2,L2);


















DTO1=zeros(size(DTM1),'int32');
s=size(DTO1);
for x=1:s(1)
    fprintf("x=%d\n",x);
    for y=1:s(2)
        for z=1:s(3)
            v1=DTM1(x,y,z);
            if (v1 ~= 0)
                DTO1(x,y,z)=v1+300;
            end
            %if (F1(x,y,z) ~= 0)
            %    DTO1(x,y,z)=1524;
            %end
        end
    end
end
fprintf("OK\n");














DTO2=zeros(size(DTM2),'int32');
s=size(DTO2);
for x=1:s(1)
    fprintf("x=%d\n",x);
    for y=1:s(2)
        for z=1:s(3)
            v1=DTM2(x,y,z);
            if (v1 ~= 0)
                DTO2(x,y,z)=v1+300;
            end
            %if (F2(x,y,z) ~= 0)
            %    DTO2(x,y,z)=1524;
            %end
        end
    end
end
fprintf("OK\n");






newDicomSeriesFolderPath1="C:\Users\GregP\Documents\MATLAB\dicom9";
newDicomSeriesFolderPath2="C:\Users\GregP\Documents\MATLAB\dicom10";
saveVoxelVolumeToDicomFile(DTO1, srcDicomSeriesFolderPath, newDicomSeriesFolderPath1);
saveVoxelVolumeToDicomFile(DTO2, srcDicomSeriesFolderPath, newDicomSeriesFolderPath2);