function O = threshold(V, level, isAllThatLessThanLevelMustBeZero, isOutputMustBeBinarized)

fprintf("Threshold transform...\n");

vsize=size(V);
if (isOutputMustBeBinarized)
    O=logical(zeros(vsize(1),vsize(2),vsize(3)));
else
    O=zeros(vsize(1),vsize(2),vsize(3));
end
for x=1:vsize(1)
    for y=1:vsize(2)
        for z=1:vsize(3)
            if (isAllThatLessThanLevelMustBeZero)
                if (V(x,y,z) >= level)
                    if (isOutputMustBeBinarized)
                        O(x,y,z)=1;
                    else
                        O(x,y,z)=V(x,y,z);
                    end
                end
            else
                if (V(x,y,z) < level)
                    if (isOutputMustBeBinarized)
                        O(x,y,z)=1;
                    else
                        O(x,y,z)=V(x,y,z);
                    end
                end
            end
        end
    end
end