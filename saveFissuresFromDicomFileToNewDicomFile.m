function saveFissuresFromDicomFileToNewDicomFile(srcDicomFolderPath,newDicomFolderPath)
%srcDicomFolderPath="D:\Tomograms\Chest_CT\PA000002\ST000001\SE000002";
%newDicomFolderPath="C:\Users\GregP\Documents\MATLAB\dicom2";

addpath("C:\Users\GregP\Documents\MATLAB\lung-segmentation");
addpath("C:\Users\GregP\Documents\MATLAB\frangi_filter_version2a");
addpath("C:\Users\GregP\Documents\MATLAB\bwdistsc");
addpath("C:\Users\GregP\Documents\MATLAB\viewer3d_version12a\ReadData3D\dicom");


%dp="D:\Tomograms\Anonimous - 1516125\Pet Petct_Wholebody_Routine (Adult)\CT WB 1.5 B30f - 4";
%dp="D:\Tomograms\Chest_CT\PA000001\ST000001\SE000002";

V=getRescaledDicomVolume(srcDicomFolderPath);

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










sigma=1;
V2=V;
V=CROs;

V=single(V);

fprintf("Hessian3D\n");
[Dxx, Dyy, Dzz, Dxy, Dxz, Dyz] = Hessian3D(V,sigma);
fprintf("eig3volume\n");
[Lambda1,Lambda2,Lambda3]=eig3volume(Dxx,Dxy,Dxz,Dyy,Dyz,Dzz);

fprintf("Lambda sorting\n");
vSize = size(V);
for x=1:vSize(1)
    fprintf(x+"\n");
    for y=1:vSize(2)
        for z=1:vSize(3)
            if ((V(x,y,z) > -1000) && (V(x,y,z) < -400))
                LL = [ Lambda1(x,y,z), Lambda2(x,y,z), Lambda3(x,y,z)];
                [~,idx] = sort(abs(LL));
                LLs = LL(idx);
                Lambda1(x,y,z) = LLs(1);
                Lambda2(x,y,z) = LLs(2);
                Lambda3(x,y,z) = LLs(3);
            end
        end
    end
end












F1=~imbinarize(Lambda3,0);
s=size(F1);
level_vessel=-400;
M=threshold(V,level_vessel, false, true);
F2=M&F1;
fprintf("Small object cutting. First stage...\n");
fprintf("Loop by x...\n");
for x=1:s(1)
    F2(x,:,:)=bwareaopen(F2(x,:,:),30);
end
fprintf("Loop by y...\n");
for y=1:s(2)
    F2(:,y,:)=bwareaopen(F2(:,y,:),15);
end
fprintf("Loop by z...\n");
for z=1:s(3)
    F2(:,:,z)=bwareaopen(F2(:,:,z),30);
end
M2=erode(CRO,3);
F3=F2&M2;
F4=F3;%erode(F3,2,1,'cube');
F5=F4;%dilate(F4,5,1,'cube');
F6=getMaxObject(F5);
F7=F5-F6;
F8=getMaxObject(F7);
F9=F6|F8;
fprintf("Small object cutting. Second stage...\n");
fprintf("Loop by x...\n");
for x=1:s(1)
    F9(x,:,:)=bwareaopen(F9(x,:,:),30);
end
fprintf("Loop by y...\n");
for y=1:s(2)
    F9(:,y,:)=bwareaopen(F9(:,y,:),15);
end
fprintf("Loop by z...\n");
for z=1:s(3)
    F9(:,:,z)=bwareaopen(F9(:,:,z),30);
end
%F10=erode(F9,3,1,'sphere');



A=int32(F9);






F=F9;











E1=L1&(~erode(L1,3,1,'sphere'));
E2=L2&(~erode(L2,3,1,'sphere'));
F01=F&L1|E1;
F02=F&L2|E2;
DT1=bwdist(F01);
DT2=bwdist(F02);
DTM1=getByMask(DT1,L1);
DTM2=getByMask(DT2,L2);
DTM=DTM1+DTM2;






DTO=zeros(size(DTM),'int32');
s=size(DTO);
for x=1:s(1)
    fprintf("x=%d\n",x);
    for y=1:s(2)
        for z=1:s(3)
            v1=DTM(x,y,z);
            if (v1 ~= 0)
                DTO(x,y,z)=v1+300;
            end
        end
    end
end
fprintf("OK\n");











saveVoxelVolumeToDicomFile(DTO, srcDicomFolderPath, newDicomFolderPath);