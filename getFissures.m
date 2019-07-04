function O = getFissures(V, sigma)

%sigma=1;
%V2=V;
%V=CROs;

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

alpha = 50;
beta = 35;
gamma = 25;
Fstructure=zeros(vSize);
Fsheet=zeros(vSize);
F=zeros(vSize);

fprintf("Ffissure\n");
for x=1:vSize(1)
    fprintf("Fissure searching on the slice: "+x+"\n");
    for y=1:vSize(2)
        for z=1:vSize(3)
            if ((V(x,y,z) > -1000) && (V(x,y,z) < -400))
                if (Lambda3(x,y,z) >= 0)
                    Fstructure(x,y,z)=0;
                else
                    Fstructure(x,y,z)=-Lambda3(x,y,z)*exp(-power(Lambda3(x,y,z)-alpha,2)/power(beta,6));
                end
                Fsheet(x,y,z)=exp(-power(Lambda2(x,y,z),6)/power(gamma,6));
                F(x,y,z)=Fstructure(x,y,z)*Fsheet(x,y,z);
            end
        end
    end
end

infv(F);
level_vessel=-400;
B=threshold(F,1,true,true);
M=threshold(V,level_vessel, false, true);
M2=B&M;
SE=strel('sphere',1);
O=imerode(M2, SE);
O=bwareaopen(O, 1000);
SE=strel('sphere',1);
B2=threshold(F,20,true,true);
M3=B2&M;
for i=1:12
    O=imdilate(O,SE);
    O=O&M3;
end

fprintf("finished\n");
showVoxelVolume(O,2);

