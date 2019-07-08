function O=dilate(V,r,t,n)

if (nargin < 4)
    n=1;
end

if (nargin < 3)
    t='sphere';
end

O=V;
SE=strel(t,r);
for i=1:n
    O=imdilate(O,SE);
end