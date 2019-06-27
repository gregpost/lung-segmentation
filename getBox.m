function [Vb, of] = getBox(V)

[nX,nY,nZ] = size(V);
xmin=0;
xmax=0;
ymin=0;
ymax=0;
zmin=0;
zmax=0;

for z=1:nZ
    for y=1:nY
        for x=1:nX
            if (V(x,y,z) ~= 0)
                zmin=z;
                break
            end
        end
        if (zmin ~= 0)
            break;
        end
    end
    if (zmin ~= 0)
        break;
    end
end

for z=nZ:-1:1
    for y=1:nY
        for x=1:nX
            if (V(x,y,z) ~= 0)
                zmax=z;
                break
            end
        end
        if (zmax ~= 0)
            break;
        end
    end    
    if (zmax ~= 0)
        break;
    end
end

for y=1:nY
    for z=1:nZ
        for x=1:nX
            if (V(x,y,z) ~= 0)
                ymin=y;
                break
            end
        end
        if (ymin ~= 0)
            break;
        end
    end
    if (ymin ~= 0)
        break;
    end
end

for y=nY:-1:1
    for z=1:nZ
        for x=1:nX
            if (V(x,y,z) ~= 0)
                ymax=y;
                break
            end
        end
        if (ymax ~= 0)
            break;
        end
    end
    if (ymax ~= 0)
        break;
    end
end

for x=1:nX
    for z=1:nZ
        for y=1:nY
            if (V(x,y,z) ~= 0)
                xmin=x;
                break
            end
        end
        if (xmin ~= 0)
            break;
        end
    end
    if (xmin ~= 0)
        break;
    end
end

for x=nX:-1:1
    for z=1:nZ
        for y=1:nY
            if (V(x,y,z) ~= 0)
                xmax=x;
                break
            end
        end
        if (xmax ~= 0)
            break;
        end
    end
    if (xmax ~= 0)
        break;
    end
end

bX=xmax-xmin;
bY=ymax-ymin;
bZ=zmax-zmin;

if (islogical(V))
    Vb=logical(zeros(bX,bY,bZ));
else
    Vb=int32(zeros(bX,bY,bZ));
end

for x=1:bX
    for y=1:bY
        for z=1:bZ
            Vb(x,y,z)=V(x+xmin,y+ymin,z+zmin);
        end
    end
end

of = [xmin ymin zmin];