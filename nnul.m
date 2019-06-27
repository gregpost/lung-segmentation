function nnul(V)

s=size(V);
for x=1:s(1)
    for y=1:s(2)
        for z=1:s(3)
            if (V(x,y,z) ~= 0)
                fprintf("%.2f\n",V(x,y,z));
            end
        end
    end
end