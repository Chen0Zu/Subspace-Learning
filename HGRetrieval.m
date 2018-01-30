 fucntion  [mranklist, mrankdist]  = HGRetrieval(mDist, mQueryList, mGalleryList, mPara)
 %% HGClassify
 
 nMode = size(mDist,3);
 nObject = size(mDist, 1);
lambda = mPara.Lambda;
 kNN = mPara.kNN;

%% construct the hypergraph (the same one for all the queries)
nEdge = nObject;
H = zeros(nObject,nEdge);
mDistfusion = sum(mDist,3);
meanDist = sum(sum(mDistfusion))/nObject^2;
for iObject = 1:nObject
    vDist = mDistfusion(iObject, :);
    [values, orders] = sort(vDist, 'ascend');
    H(orders(1:kNN), iObject) = exp(-values(1:kNN).^2/meanD^2);
end

DV = diag(sum(H,2));
DE = diag(sum(H,1));
DV2 = diag(diag(DV).^(-0.5));
DV0 = diag(DV);
INVDE = diag(diag(DE).^(-1));
W = ones(nEdge,1);


ThetaH = DV2*H*diag(W)*INVDE*H'*DV2;
eta = 1/(1+lambda);
L2 = eye(nObject)-eta*ThetaH;
Delta =  (lambda/(1+lambda))*inv(L2);

Y = zeros(nObject);
tmpidx=find(mClass(mGalleryList)==1);
Y(mGalleryList(tmpidx))=1;
tmpidx=find(mClass(mGalleryList)==0);
Y(mGalleryList(tmpidx))=-1;

mQueryDist = -Delta(mGalleryList,mQueryList)';
[mrankdist, tmprankindex] = sort(mQueryDist, 2, 'ascend');
mranklist = mGallerylist(tmprankindex);