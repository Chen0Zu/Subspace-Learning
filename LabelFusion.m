function lab_tar = LabelFusion(patch_tar, patch_atl, label_atl, labelID, nn, sigma)

Dist = EuDist2(patch_tar',patch_atl');
[value,index] = sort(Dist, 'ascend');
numatl = size(patch_atl,2);



if nargin == 6
    % non-local fusion method
    num = floor(sigma*numatl);
    if num==0
        weight = ones(1,numatl);
    else
        Dist = Dist-min(Dist);
        thre = value(num);
        weight = exp(-Dist./thre);
    end
    hisgram_lab = zeros(1,length(labelID)+1);
    hisgram_lab(1) = sum(weight);
    for labelInd = 1:length(labelID)
        hisgram_lab(labelInd+1) = sum(weight(label_atl==labelID(labelInd)));
        hisgram_lab(1) = hisgram_lab(1)-hisgram_lab(labelInd+1);
    end
else
    % K-NN classifier
    label_atl = label_atl(index(1:nn));
    hisgram_lab = zeros(1,length(labelID)+1);
    hisgram_lab(1) = length(label_atl);
    for labelInd = 1:length(labelID)
        hisgram_lab(labelInd+1) = length(find(label_atl==labelID(labelInd)));
        hisgram_lab(1) = hisgram_lab(1)-hisgram_lab(labelInd+1);
    end
end



[~,index] = max(hisgram_lab);

if index == 1
    lab_tar = 0;
else
    lab_tar = labelID(index-1);
end
