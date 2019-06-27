DTG1=-imgaussian(DTM1,3);
DTG2=-imgaussian(DTM2,3);
[DTB1,of1]=getBox(DTG1);
[DTB2,of2]=getBox(DTG2);
c=conndef(ndims(DTG1),'maximal');
WS1=watershed(DTB1,c);
WS2=watershed(DTB2,c);
WSE1=enlarge(WS1,size(V),of1);
WSE2=enlarge(WS2,size(V),of2);
WSM1=getByMask(WSE1,L1);
WSM2=getByMask(WSE2,L2);







MO1=getMaxObject(WSM1);
MO2=getMaxObject(WSM1&~MO1);
MO3=getMaxObject(WSM1&~MO1&~MO2);
MO4=getMaxObject(WSM2);
MO5=getMaxObject(WSM2&~MO4);
saveVoxelVolumeToBinaryFileGroup(MO1,"C:/Users/GregP/Documents/MATLAB/binary/lobe1/");
saveVoxelVolumeToBinaryFileGroup(MO2,"C:/Users/GregP/Documents/MATLAB/binary/lobe2/");
saveVoxelVolumeToBinaryFileGroup(MO3,"C:/Users/GregP/Documents/MATLAB/binary/lobe3/");
saveVoxelVolumeToBinaryFileGroup(MO4,"C:/Users/GregP/Documents/MATLAB/binary/lobe4/");
saveVoxelVolumeToBinaryFileGroup(MO5,"C:/Users/GregP/Documents/MATLAB/binary/lobe5/");