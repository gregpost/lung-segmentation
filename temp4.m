









addpath(pwd+"/frangi_filter_version2a");

%dp="D:\Tomograms\Anonimous - 1516125\Pet Petct_Wholebody_Routine (Adult)\CT WB 1.5 B30f - 4";
%dp="D:\Tomograms\Chest_CT\PA000001\ST000001\SE000002";
srcDicomSeriesFolderPath="D:\Tomograms\Chest_CT\PA000003\ST000001\SE000002";
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










sigma=1;
V2=V;
V=CROs;

V=single(V);

%V=niftiread('lung_001.nii');
%roi=[300,400,200,300,1,300];
%V=copyRoi(V,roi);s
%sigma = 1;
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












T=~imbinarize(Lambda3,-5);
s=size(T);
F9=T;
for x=1:s(1)
    F9(x,:,:)=bwareaopen(T(x,:,:),100);
end
for y=1:s(2)
    F9(:,y,:)=bwareaopen(T(:,y,:),30);
end
for z=1:s(3)
    F9(:,:,z)=bwareaopen(T(:,:,z),100);
end
level_vessel=-400;
M=threshold(V,level_vessel, false, true);
F10=M&F9;
M2=erode(CRO,3);
F11=F10&M2;
F12=erode(F11,2,1,'cube');
F13=dilate(F12,3,1,'cube');
F14=getMaxObject(F13);
F15=F13-F14;
F16=getMaxObject(F15);
F17=F14|F16;









F=F17;











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
newDicomSeriesFolderPath3="C:\Users\GregP\Documents\MATLAB\dicom11";
saveVoxelVolumeToDicomFile(DTO1, srcDicomSeriesFolderPath, newDicomSeriesFolderPath1);
saveVoxelVolumeToDicomFile(DTO2, srcDicomSeriesFolderPath, newDicomSeriesFolderPath2);
saveVoxelVolumeToDicomFile(F*1024, srcDicomSeriesFolderPath, newDicomSeriesFolderPath3);