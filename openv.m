function O=openv(V,r,n,t)

O=erode(V,r,n,t);
O=dilate(O,r,n,t);