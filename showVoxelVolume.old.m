%Example 1. 
%{
    example_array = randi(10,10,10,10);
    showVoxelVolume(example_array);
%}

%Example 2 (show only 2nd and 3rd z-slices)
%{
    example_array = randi(10,10,10,10);
	vSize = size(example_array);
    regionOfInterest=[1 vSize(1) 1 vSize(2) 2 3];
	showVoxelVolume(example_array, regionOfInterest);
%}

% V - 3-demensional array of integers. Color of voxel
% depends on integer volue. For example if V(1,1,1) == 1,
% then the color of this voxel will be different from voxel which
% equals to 2 etc. If V(x,y,z) == 0 then it will be some color too
% because I was lazy to implement invisible voxels.
% roi - Region of Interest. This is a vector of 6 values.
% For example, roi = [1 10 1 10 1 10] will show 1000 voxels.
function showVoxelVolume(V, roi)

totalVoxelCount=numel(V);

if totalVoxelCount > 30000
    error(strcat('Number of voxels must be less then 30000 because processing time may be too long. Current number of voxels: ', num2str(totalVoxelCount)));
end

close all;
clc;

if (nargin < 2)    
    vSize = size(V);
    roi = [1 vSize(1) 1 vSize(2) 1 vSize(3)];
end

axis([roi(1) roi(2)+1 roi(3) roi(4)+1 roi(5) roi(6)+1]);
daspect([1 1 1]);
grid on;
view(3);
xticks(roi(1)-1:1:roi(2));
yticks(roi(3)-1:1:roi(4));
zticks(roi(5)-1:1:roi(6));

z=roi(5);
for x=roi(1):roi(2)
    for y=roi(3):roi(4)
        h=patch([x,x+1,x+1,x],[y,y,y+1,y+1],[z,z,z,z],V(x,y,z));
        set(h,'EdgeColor','none');
    end
end

z=roi(6);
z1=z+1;
for x=roi(1):roi(2)
    for y=roi(3):roi(4)
        h=patch([x,x+1,x+1,x],[y,y,y+1,y+1],[z1,z1,z1,z1],V(x,y,z));
        set(h,'EdgeColor','none');
    end
end

y=roi(3);
for x=roi(1):roi(2)
    for z=roi(5):roi(6)
        h=patch([x,x+1,x+1,x],[y,y,y,y],[z,z,z+1,z+1],V(x,y,z));
        set(h,'EdgeColor','none');
    end
end

y=roi(4);
y1=y+1;
for x=roi(1):roi(2)
    for z=roi(5):roi(6)
        h=patch([x,x+1,x+1,x],[y1,y1,y1,y1],[z,z,z+1,z+1],V(x,y,z));
        set(h,'EdgeColor','none');
    end
end

x=roi(1);
for y=roi(3):roi(4)
    for z=roi(5):roi(6)
        h=patch([x,x,x,x],[y,y+1,y+1,y],[z,z,z+1,z+1],V(x,y,z));
        set(h,'EdgeColor','none');
    end
end

x=roi(2);
x1=x+1;
for y=roi(3):roi(4)
    for z=roi(5):roi(6)        
        h=patch([x1,x1,x1,x1],[y,y+1,y+1,y],[z,z,z+1,z+1],V(x,y,z));
        set(h,'EdgeColor','none');
    end
end

