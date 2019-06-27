function O=closev(V,r,n,t)

O=dilate(V,r,n,t);
O=erode(O,r,n,t);