function CT = loadImage(path, size, datatype)

fileCT = fopen(path,'rb');
CT = fread(fileCT, datatype);
CT = uint8(reshape(CT,size));
fclose(fileCT);
end