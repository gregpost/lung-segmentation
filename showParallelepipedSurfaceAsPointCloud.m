%Example 1. Show only those points of parallelepiped which lie on its
%surface.
%{
    array_size=100;
    r=30;
    c=array_size/2;
    example_array = zeros(array_size,array_size,array_size);
    for x=1:array_size
        for y=1:array_size
            for z=1:array_size
                example_array(x,y,z)=randi(10);
            end
        end
    end
    showParallelepipedSurfaceAsPointCloud(example_array, 3);
%}

%Example 2 (show only y-slices from 45 to 55)
%{
    array_size=100;
    r=30;
    c=array_size/2;
    example_array = zeros(array_size,array_size,array_size);
    for x=1:array_size
        for y=1:array_size
            for z=1:array_size
                example_array(x,y,z)=randi(10);
            end
        end
    end
	vSize = size(example_array);
    regionOfInterest=[1 vSize(1) 45 55 1 vSize(3)];
    showParallelepipedSurfaceAsPointCloud(example_array, 70, regionOfInterest);
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
function showParallelepipedSurfaceAsPointCloud(V, radius, roi)

% Maximal point count which can be outputed. Without this the program can
% executes too long.
MAX_POINT_COUNT=1000000;

% Error message which outputs when point count is too large.
ERROR_MESSAGE = 'Number of points must be less then 1000000 because processing time may be too long.';

close all;
clc;

if (nargin < 3)
    vSize = size(V);
    roi = [1 vSize(1) 1 vSize(2) 1 vSize(3)];
end

if (nargin < 2)
    radius = 3;
end

xArray=zeros(MAX_POINT_COUNT,1);
yArray=zeros(MAX_POINT_COUNT,1);
zArray=zeros(MAX_POINT_COUNT,1);
colorArray=zeros(MAX_POINT_COUNT,1);

i=1;

z=roi(5);
for x=roi(1):roi(2)
    for y=roi(3):roi(4)
        xArray(i)=x;
        yArray(i)=y;
        zArray(i)=z;
        colorArray(i)=V(x,y,z);
        i=i+1;
    end
end

%Validation.
if i > MAX_POINT_COUNT
    error(ERROR_MESSAGE);
end

z=roi(6);
for x=roi(1):roi(2)
    for y=roi(3):roi(4)
        xArray(i)=x;
        yArray(i)=y;
        zArray(i)=z;
        colorArray(i)=V(x,y,z);
        i=i+1;
    end
end

%Validation.
if i > MAX_POINT_COUNT
    error(ERROR_MESSAGE);
end

y=roi(3);
for x=roi(1):roi(2)
    for z=roi(5):roi(6)
        xArray(i)=x;
        yArray(i)=y;
        zArray(i)=z;
        colorArray(i)=V(x,y,z);
        i=i+1;
    end
end

%Validation.
if i > MAX_POINT_COUNT
    error(ERROR_MESSAGE);
end

y=roi(4);
for x=roi(1):roi(2)
    for z=roi(5):roi(6)
        xArray(i)=x;
        yArray(i)=y;
        zArray(i)=z;
        colorArray(i)=V(x,y,z);
        i=i+1;
    end
end

%Validation.
if i > MAX_POINT_COUNT
    error(ERROR_MESSAGE);
end

x=roi(1);
for y=roi(3):roi(4)
    for z=roi(5):roi(6)
        xArray(i)=x;
        yArray(i)=y;
        zArray(i)=z;
        colorArray(i)=V(x,y,z);
        i=i+1;
    end
end

%Validation.
if i > MAX_POINT_COUNT
    error(ERROR_MESSAGE);
end

x=roi(2);
for y=roi(3):roi(4)
    for z=roi(5):roi(6)
        xArray(i)=x;
        yArray(i)=y;
        zArray(i)=z;
        colorArray(i)=V(x,y,z);
        i=i+1;
    end
end

%Validation.
if i > MAX_POINT_COUNT
    error(ERROR_MESSAGE);
end
                
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