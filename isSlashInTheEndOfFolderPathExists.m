function fp2 = isSlashInTheEndOfFolderPathExists(fp)
% Check existatnce of '/' symbol in the end of the folder path.

len=length(fp);
fp2=char(fp);
if (fp2(len) ~= '/' || fp2(len) ~= '\')
    fp2=fp2+"/";
end