%Example 1. Show sphere with R=100 points.
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
    showPointCloud(example_array, 10);
%}

%Example 2 (show only 50th x-slice of sphere with R=30 points)
%{
    array_size=100;
    r=30;
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
	vSize = size(example_array);
    regionOfInterest=[50 50 1 vSize(2) 1 vSize(3)];
    showPointCloud(example_array, 70, regionOfInterest);
%}

% V - 3-demensional array of integers. Color of point
% depends on integer volue. For example if V(1,1,1) == 1,
% then the color of this point will be different from point which
% equals to 2 etc. If V(x,y,z) == 0 then it will be invisible point.
% radius - point radius. For big volumes is better to use
% radius=3..5. if you want to make some transparent effect
% then decrease radius.
% roi - Region of Interest. This is a vector of 6 values.
% For example, roi = [1 10 1 10 1 10] will show 1000 voxels.
% isInternalVoxelsNeedToBeCutted - flag which allows to see internal
% points of object. This is useful, for example, when you need to see
% all slices of Voronoi diagram. You can do this using scrolling and
% and changing scale of 3-d diagram.
function showPointCloud(V, radius, roi, isInternalVoxelsNeedToBeCutted)

% Maximal point count which can be outputed. Without this the program can
% executes too long.
MAX_POINT_COUNT=1000000;

close all;
clc;

%Optional parameters.

if (nargin < 4)
    isInternalVoxelsNeedToBeCutted = true;
end

if (nargin < 3)
    vSize = size(V);
    roi = [1 vSize(1) 1 vSize(2) 1 vSize(3)];
end

if (nargin < 2)
    radius = 3;
end

%Cut internal voxels.

internalVolume=V;

if isInternalVoxelsNeedToBeCutted
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

xArray=zeros(MAX_POINT_COUNT,1);
yArray=zeros(MAX_POINT_COUNT,1);
zArray=zeros(MAX_POINT_COUNT,1);
colorArray=zeros(MAX_POINT_COUNT,1);

i=1;
for x=roi(1):roi(2)
    for y=roi(3):roi(4)
        for z=roi(5):roi(6)
            if internalVolume(x,y,z)
                xArray(i)=x;
                yArray(i)=y;
                zArray(i)=z;
                colorArray(i)=internalVolume(x,y,z);
                i=i+1;

                %Validation.
                if i > MAX_POINT_COUNT
                    error('Number of points must be less then 1000000 because processing time may be too long.');
                end
            end
        end
    end
end

%Output.

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