function O = enlarge(V, vSize, of)

if (islogical(V))
    O=zeros(vSize,'logical');
else
    O=int32(zeros(vSize));
end
vs=size(V);
for x=1:vs(1)
    for y=1:vs(2)
        for z=1:vs(3)
            ox=of(1)+x;
            oy=of(2)+y;
            oz=of(3)+z;
            O(ox,oy,oz)=V(x,y,z);
        end
    end
end