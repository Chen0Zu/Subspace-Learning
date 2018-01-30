tarpath='./';
atlpath='./';
subpath='./';
outpath='./';
tarID=1;
atlID=2:10;
imsize=[124,96,96];
datatype='uint8';
labelID=[254,255];
subID=1:23;

mpara.k1=10;
mpara.k2=30;
mpara.nn=3;
mpara.windowsize=[5,5,5];
mpara.patchsize=[5,5,5];
mpara.threshold = 0.95;
mpara.sigma = 0.005;


performlabeling_subset(tarID, atlID, tarpath, atlpath, subID, subpath, outpath, imsize, datatype, labelID, mpara)