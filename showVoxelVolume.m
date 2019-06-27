function showVoxelVolume(V, radius, isInternalVoxelsNeedToBeCutted)
% V - 3-demensional array of integers. Color of point
% depends on integer volue. For example if V(1,1,1) == 1,
% then the color of this point will be different from point which
% equals to 2 etc. If V(x,y,z) == 0 then it will be invisible point.
% radius - point radius. For big volumes is better to use
% radius=1..5. If you want to make some transparent effect
% then decrease the radius.
% isInternalVoxelsNeedToBeCutted - flag which allows to see internal
% points of an object.
%}

% Example. Show sphere with R=100 points.

%{

array_size=300;
r=100;
c=array_size/2;
example_array = zeros(array_size,array_size,array_size);
for x=1:array_size
    for y=1:array_size
        for z=1:array_size
            if (x-c)*(x-c)+(y-c)*(y-c)+(z-c)*(z-c) < r*r
                example_array(x,y,z)=randi(10);
            end
        end
    end
end
showVoxelVolume(example_array, 10);

%}

% Optional parameters.

if (nargin < 3)
    isInternalVoxelsNeedToBeCutted = true;
end

if (nargin < 2)
    radius = 2;
end

fprintf("\nVoxel volume vizualization...\n");

% Maximal point count which can be outputed. Without this the
% program can executes too long.
MAX_POINT_COUNT=10000000;

% Resize volume if it too big.
[nX, nY, nZ]=size(V);
vc=nX*nY*nZ;
k=nthroot(MAX_POINT_COUNT/vc,3);
if (k < 1)
    fprintf("Resizing voxel volume with a coefficient: %.3f\n",k);
    if (islogical(V))
        V=logical(imresize3(int32(V),k));
    else
        V=imresize3(V,k);
    end
end

vSize = size(V);
roi = [1 vSize(1) 1 vSize(2) 1 vSize(3)];

close all;
    
% Colorization of binary volume to make the volume more perceptible.
if (islogical(V))    
    fprintf("Colorization of binary volume...\n");
    V=int32(V);
    for x=roi(1)+1:roi(2)-1
        for y=roi(3)+1:roi(4)-1
            for z=roi(5)+1:roi(6)-1
                V(x,y,z)=V(x,y,z)*abs((x-nX/2)*(y-nY/2)*(z-nZ/2)+1);
            end
        end
    end
end

%Cut internal voxels.

internalVolume=V;

if isInternalVoxelsNeedToBeCutted
    fprintf("Cutting internal voxels...\n");
    for x=roi(1)+1:roi(2)-1
        for y=roi(3)+1:roi(4)-1
            for z=roi(5)+1:roi(6)-1
                if (V(x,y,z) ~= 0) && (V(x-1,y,z) ~=0) && (V(x+1,y,z) ~=0) && (V(x,y-1,z) ~=0) && (V(x,y+1,z) ~=0) && (V(x,y,z-1) ~=0) && (V(x,y,z+1) ~=0)
                    internalVolume(x,y,z)=0;
                end
            end
        end
    end
end

%Create arrays with point coordinates and colors.

xArray=zeros(vc,1);
yArray=zeros(vc,1);
zArray=zeros(vc,1);
colorArray=zeros(vc,1);

fprintf("Creating arrays with coordinates and colors...\n");
   
i=1;
j=0;
for z=roi(5):roi(6)
    if (j > 100)
        fprintf("Slices processed: %d%%\n",round(z/roi(6)*100));
        j=0;
    end
    j=j+1;
    for y=roi(3):roi(4)
        for x=roi(1):roi(2)
            if internalVolume(x,y,z)
                xArray(i)=x;
                yArray(i)=y;
                zArray(i)=z;
                colorArray(i)=internalVolume(x,y,z);
                i=i+1;
            end
        end
    end
end

%Output.

fprintf("Drawing...\n");

scatter3(xArray(1:i),yArray(1:i),zArray(1:i),radius,colorArray(1:i),'filled');
    
xSize=roi(2)-roi(1);
ySize=roi(4)-roi(3);
zSize=roi(6)-roi(5);

axis([roi(1) roi(2)+1 roi(3) roi(4)+1 roi(5) roi(6)+1]);
daspect([1 1 1]);
grid on;
view(3);
xticks(roi(1)-1:xSize/10:roi(2));
yticks(roi(3)-1:ySize/10:roi(4));
zticks(roi(5)-1:zSize/10:roi(6));

fprintf("Voxel volume visualization completed.\n\n");