%% divide voxels to be labeled into several subset

tarID=1;
atlID=2:10;
tarpath=[];
atlpath='./';
outpath='./';
imsize = [124,96,96];
datatype = [];
labelID=[254 255];
num=200;
DivideSample(tarID, atlID, tarpath, atlpath, outpath, imsize, datatype, labelID, num)