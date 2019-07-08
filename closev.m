function O=closev(V,r,n,t)

if (nargin < 3)
    n=1;
end

if (nargin < 4)
    t='sphere';
end

O=dilate(V,r,n,t);
O=erode(O,r,n,t);