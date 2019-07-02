T=~imbinarize(Lambda3,-5);
s=size(T);
F9=T;
for x=1:s(1)
    F9(x,:,:)=bwareaopen(T(x,:,:),100);
end
for y=1:s(2)
    F9(:,y,:)=bwareaopen(T(:,y,:),30);
end
for z=1:s(3)
    F9(:,:,z)=bwareaopen(T(:,:,z),100);
end
level_vessel=-400;
M=threshold(V,level_vessel, false, true);
F10=M&F9;
M2=erode(CRO,3);
F11=F10&M2;
F12=erode(F11,2,1,'cube');
F13=dilate(F12,3,1,'cube');
F14=getMaxObject(F13);
F15=F13-F14;
F16=getMaxObject(F15);
F17=F14|F16;