function F = getFissures2(V,CL,sigma)

if (nargin < 4)
    sigma=1;
end

V=getByMask(V,CL);
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

F=~imbinarize(Lambda3,0);
s=size(F);
level_vessel=-400;
M=threshold(V,level_vessel, false, true);
F=M&F;
fprintf("Small object cutting. First stage...\n");
fprintf("Loop by x...\n");
for x=1:s(1)
    F(x,:,:)=bwareaopen(F(x,:,:),30);
end
fprintf("Loop by y...\n");
for y=1:s(2)
    F(:,y,:)=bwareaopen(F(:,y,:),15);
end
fprintf("Loop by z...\n");
for z=1:s(3)
    F(:,:,z)=bwareaopen(F(:,:,z),30);
end
M2=erode(CL,3);
F=F&M2;
F1=getMaxObject(F);
F=F-F1;
F2=getMaxObject(F);
F=F1|F2;
fprintf("Small object cutting. Second stage...\n");
fprintf("Loop by x...\n");
for x=1:s(1)
    F(x,:,:)=bwareaopen(F(x,:,:),30);
end
fprintf("Loop by y...\n");
for y=1:s(2)
    F(:,y,:)=bwareaopen(F(:,y,:),15);
end
fprintf("Loop by z...\n");
for z=1:s(3)
    F(:,:,z)=bwareaopen(F(:,:,z),30);
end

E=CL&(~erode(CL,3,1,'sphere'));
F=F|E;