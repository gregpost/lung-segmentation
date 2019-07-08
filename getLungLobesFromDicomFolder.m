function LL = getLungLobesFromDicomFolder(srcDicomFolderPath)

[V,L]=getRespiratoryOrgansFromDicomFolder(srcDicomFolderPath);
F=getFissures2(V,L);
E=L&(~erode(L,3));
FE=F|E;
DT=dt(FE,L);
DT=imgaussian(DT,9);
LL=watershed(-DT);
LL=getByMask(LL,L);
O=getByMask(LL,~F)+uint8(F)*111;
