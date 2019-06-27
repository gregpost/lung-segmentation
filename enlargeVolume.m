% so - [sizex sizey sizez] of an output volume
% of - [xoff yoff zoff]
function Vo = enlargeVolume(Vi,so,of)

Vo=int32(zeros(so));

si=size(Vi);
for x=1:si(1)
    for y=1:si(2)
        for z=1:si(3)
            Vo(x+of(1),y+of(2),z+of(3))=Vi(x,y,z);
        end
    end
end