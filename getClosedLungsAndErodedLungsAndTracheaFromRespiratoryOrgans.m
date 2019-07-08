function [CL,EL1,EL2,T] = getClosedLungsAndErodedLungsAndTracheaFromRespiratoryOrgans(CRO,V)

Vd=double(V);
A=~imbinarize(Vd,-900);
LA=~imbinarize(Vd,-300);

r1=5;
ERO=erode(CRO,r1,8);
EL1=getMaxObject(ERO);
EL2=ERO&(~EL1);
EL2=getMaxObject(EL2);
DL1=dilate(EL1,25,8);
DL2=dilate(EL2,25,8);
I=DL2&DL1;
%A=~imbinarize(V,-900);
ORO=dilate(ERO,r1,8);
T=A&CRO&I&(~ORO);
T=erode(T,3);
[Tm,m]=getMaxObject(T);
lvl=round(m/32);
T=bwareaopen(T, lvl);
for i=1:4
    T=dilate(T,8);
    T=T&A;
end
T=getMaxObject(T);
DT=dilate(T,4);
%LA=~imbinarize(V,-300);
T=DT&LA;
CL=CRO&(DL1|DL2)&~DT;
[Lm,m]=getMaxObject(CL);
lvl=round(m/10);
CL=bwareaopen(CL, lvl);

