function CombineSample(tarID,num, subpath,labpath,outpath,labelID,imsize)


lab_tar=zeros(imsize,'uint8');
for i =1:num
    filename = fullfile(subpath, ['na',num2str(tarID),'_test',num2str(i),'_sub.mat']);
    load(filename, 'sub')
    filename = fullfile(labpath, ['na',num2str(tarID),'_test',num2str(i),'_label.mat']);
    load(filename, 'label');
    for j = 1:size(sub,1)
        lab_tar(sub(j,1),sub(j,2),sub(j,3)) = label(j);
    end
end
for i = 1:length(labelID)
    filename=fullfile(subpath,['na',num2str(tarID),'_ROI',num2str(labelID(i)),'_sub.mat']);
    load(filename, 'sub');
    for j = 1:size(sub,1)
        lab_tar(sub(j,1),sub(j,2),sub(j,3)) = labelID(i);
    end
end
filename = fullfile(outpath,['na',num2str(tarID),'_estimated_label1.img']);
fid = fopen(filename, 'wb');
fwrite(fid, lab_tar, 'uint8');
fclose(fid);