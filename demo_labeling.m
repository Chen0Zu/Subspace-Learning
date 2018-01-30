tarpath='./';
atlpath='./';
tarID=1;
atlID=2:10;
imsize=[124,96,96];
datatype='uint8';
labelID=[245,255];


mpara.k1=2;
mpara.k2=15;
mpara.nn=5;
mpara.windowsize=[5,5,5];
mpara.patchsize=[5,5,5];



lab_tar = performlabeling(tarID, atlID, tarpath, atlpath, imsize, datatype, labelID,mpara);