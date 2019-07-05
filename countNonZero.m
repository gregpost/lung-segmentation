function c=countNonZero(V)

[nx, ny, nz] = size(V);
c=0;
for x=1:nx
    for y=1:ny
        for z=1:nz
            if (V(x,y,z) ~= 0)
                %fprintf("%d, %d, %d, %d \n",V(x,y,z),x,y,z);
                c=c+1;
            end
        end
    end
end