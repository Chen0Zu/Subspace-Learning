%% combine the label results of all the subset to a 3-D label image

tarID=1;
num=23;
subpath='./';
labpath='./';
outpath='./';
labelID=[254,255];
imsize=[124,96,96];


CombineSample(tarID,num, subpath,labpath,outpath,labelID,imsize)