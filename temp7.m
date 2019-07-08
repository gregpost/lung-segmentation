X1=DT(:,100:103,:);
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
X7=-bwdist(B4);
X8=watershed(X7);
%B6=(X8==0);
B6=F(:,100:103,:);
X9=single(B6)*250;
B7=B6|B4;
X10=imimposemin(X9, B7);
X11=watershed(X10);