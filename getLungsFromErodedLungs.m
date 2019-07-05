function [L1,L2] = getLungsFromErodedLungs(EL1,EL2,CL)

DT1=bwdist(EL1);
DT2=bwdist(EL2);
NNT=DT1<DT2;
L1=CL&NNT;
L2=CL&(~NNT);


