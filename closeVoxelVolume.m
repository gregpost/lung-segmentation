function V2 = closeVoxelVolume(V,r,n)

fprintf("Morphological closing:\n");
V2=V;
SE=strel('sphere',r);
fprintf("- morphological dilation...\n");
for i=1:n
    V2=imdilate(V2,SE);
end
fprintf("- morphological erosion...\n");
for i=1:n
    V2=imerode(V2,SE);
end