function LL = getLungLobesFromDicomFolder(srcDicomFolderPath)

[V,CRO]=getRespiratoryOrgansFromDicomFolder(srcDicomFolderPath);
F=getFissures2(V,CRO);
DT=bwdist(F);
DT=getByMask(DT,CRO);
LL=mwatershed(DT);