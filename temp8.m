%X1=DT(:,100:103,:);
X1=DT(:,40:180,:);
r=10;
X2=erode(X1,r);
X3=imreconstruct(X2,X1);
X4=dilate(X3,r);
X5=imreconstruct(imcomplement(X4),imcomplement(X3));
X6=imcomplement(X5);
B1=imregionalmax(X6);
r=3;
B2=closev(B1,r,1,'cube');
B3=erode(B1,r,1,'cube');
B4=bwareaopen(B3,20);
B5=~imbinarize(X6, mean(mean(mean(X6))));
X7=-bwdist(B5);
X8=imgaussian(X7,31);
X9=watershed(X8);