function O=dilate(V,r,n,t)

if (nargin < 3)
    n=1;
end

if (nargin < 4)
    t='cube';
end

O=V;
SE=strel(t,r);
for i=1:n
    O=imdilate(O,SE);
end