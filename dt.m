function DT = dt(V,M)

DT=bwdist(V);
DT=getByMask(DT,M);