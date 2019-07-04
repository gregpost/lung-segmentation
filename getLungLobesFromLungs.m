function [LL1,LL2] = getLungLobesFromLungs(L1, L2)

F1=getFissures(L1,1);
F2=getFissures(L2,1);
E1=L1&(~erode(L1,3,1,'sphere'));
E2=L2&(~erode(L2,3,1,'sphere'));
F1=F1|E1;
F2=F2|E2;
DT1=bwdist(F1);
DT2=bwdist(F2);
DTM1=getByMask(DT1,L1);
DTM2=getByMask(DT2,L2);
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