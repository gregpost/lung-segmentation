function Vo = getByMask(V, M)

[nx, ny, nz] = size(V);
Vo=V;
for x=1:nx
    for y=1:ny
        for z=1:nz
            if (M(x,y,z) == 0)
                Vo(x,y,z)=0;
            end
        end
    end
end