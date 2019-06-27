function minv(V)

s=size(V);
m=2147483647;
for x=1:s(1)
    for y=1:s(2)
        for z=1:s(3)
            if (V(x,y,z) < m)
                m = V(x,y,z);
            end
        end
    end
end

fprintf("Minimal value: %.2f\n",minv);