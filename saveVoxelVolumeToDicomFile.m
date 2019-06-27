function saveVoxelVolumeToDicomFile(V, srcDicomSeriesFolderPath, newDicomSeriesFolderPath)

% Add "/" to the end of file path.
if (~endsWith(srcDicomSeriesFolderPath, ["/", "\"]))
    srcDicomSeriesFolderPath = srcDicomSeriesFolderPath + "/";
end
if (~endsWith(newDicomSeriesFolderPath, ["/", "\"]))
    newDicomSeriesFolderPath = newDicomSeriesFolderPath + "/";
end

% Define the dicom slice count.
files = dir(fullfile(srcDicomSeriesFolderPath,'*') );
len=length(files);
n=len-2;  % exclude "." and "..'

% Resize volume by Z axis depending on the source DICOM series slices count.
fprintf("Volume resizing...\n");
s=size(V);
Vr=imresize3(V,[s(1) s(2) n]);

%SeriesInstanceUID=char("1.2.840.113704.1.111.4976."+int32(rand()*10000000000)+".8");
V16=int16(Vr);
for i=3:len
    fprintf("Slice %d is processing...\n",i-2);
    I=dicominfo(srcDicomSeriesFolderPath+files(i).name);
    %I.SeriesInstanceUID=SeriesInstanceUID;
    dicomwrite(V16(:,:,i-2),newDicomSeriesFolderPath+files(i).name,I);
end

fprintf("Finished.\n");