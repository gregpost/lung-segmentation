function saveFissuresFromDicomFileToNewDicomFile(srcDicomFolderPath,newDicomFolderPath)

V=getRescaledDicomVolume(srcDicomFolderPath);
CRO=getRespiratoryOrgans(V);
F=getFissures2(V,CRO);
DT=bwdist(F);
DT=getByMask(DT,CL);
saveVoxelVolumeToDicomFile(DT, srcDicomFolderPath, newDicomFolderPath);