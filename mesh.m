function mesh(V)

[nX,nY,nZ] = size(V); 
[X,Y,Z] = meshgrid(1:nX,1:nY,1:nZ); 
isosurface(X,Y,Z,V,1e-5);