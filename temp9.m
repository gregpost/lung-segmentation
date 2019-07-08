> F3=erode(dilate(F,5),3);

srcDicomFolderPath="J:\Tomography\Chest_CT\PA000002\ST000001\SE000002";
[V,L]=getRespiratoryOrgansFromDicomFolder(srcDicomFolderPath);
F=getFissures2(V,L);

srcDicomFolderPath="J:\Tomography\Chest_CT\PA000003\ST000001\SE000002";
[V,L]=getRespiratoryOrgansFromDicomFolder(srcDicomFolderPath);
F=getFissures2(V,L);

srcDicomFolderPath="J:\Tomography\Chest_CT\PA000004\ST000001\SE000002";
[V,L]=getRespiratoryOrgansFromDicomFolder(srcDicomFolderPath);
F=getFissures2(V,L);

srcDicomFolderPath="J:\Tomography\Chest_CT\PA000005\ST000001\SE000002";
[V,L]=getRespiratoryOrgansFromDicomFolder(srcDicomFolderPath);
F=getFissures2(V,L);