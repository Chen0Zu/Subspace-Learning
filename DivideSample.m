function DivideSample(tarID, atlID, tarpath, atlpath, outpath, imsize, datatype, labelID, num)

num_atl = length(atlID);
lab_atl = zeros([imsize, num_atl],'uint8');
lab_tar = zeros(imsize,'int16');
for i = 1:num_atl
    atlfilename=fullfile(atlpath,['na', num2str(tarID)], ['na', num2str(atlID(i)), '_label.img']);
    lab_atl(:,:,:,i)= loadImage(atlfilename, imsize, 'uint8');
end
for m = 1:imsize(1)
    for n = 1:imsize(2)
        for q = 1:imsize(3)
            lab_atl_pix = squeeze(lab_atl(m,n,q,:));
            hisgram_label = zeros(1,1+length(labelID));
            hisgram_label(1) = num_atl;
            for labInd = 1:length(labelID)
                hisgram_label(1+labInd) = length(find(lab_atl_pix==labelID(labInd)));
                hisgram_label(1) = hisgram_label(1) - hisgram_label(1+labInd);
            end
            index = find(hisgram_label==num_atl,1);
            if ~isempty(index)
                if index==1
                    lab_tar(m,n,q)=0;
                    [m,n,q,lab_tar(m,n,q)]
                else
                    lab_tar(m,n,q)=labelID(index-1);
                    [m,n,q,lab_tar(m,n,q)]
                end
            else
                lab_tar(m,n,q)=-1;
            end
        end
    end
end

ind = find(lab_tar==-1);
sub0=zeros(length(ind),3);
[sub0(:,1),sub0(:,2),sub0(:,3)] = ind2sub(imsize,ind);

n = floor(length(ind)/num);
for i = 1:n
    sub = sub0((i-1)*num+1:i*num,:);
    filename = fullfile(outpath, ['na',num2str(tarID),'_test',num2str(i),'_sub.mat']);
    save(filename, 'sub');
end
if (n*num<length(ind))
    sub = sub0(i*num+1:end,:);
    filename = fullfile(outpath, ['na',num2str(tarID),'_test',num2str(n+1),'_sub.mat']);
    save(filename, 'sub');
end
for i = 1:length(labelID)
    ind = find(lab_tar==labelID(i));
    sub=zeros(length(ind),3);
    [sub(:,1),sub(:,2),sub(:,3)] = ind2sub(imsize,ind);
    filename=fullfile(outpath,['na',num2str(tarID),'_ROI',num2str(labelID(i)),'_sub.mat']);
    save(filename,'sub');
end

