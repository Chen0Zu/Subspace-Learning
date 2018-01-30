function [vec, Sigma] = MFA(X, ind, k1, k2)
X = double(X);
NS = length(ind);
S = zeros(NS);
SP = zeros(NS);
M = X'*X;
Dis = EuDist2(X',[],0);

for i = 1:NS
    wloc = find(ind == ind(i));
    wloc(wloc == i) = [];
    wdis = Dis(i,wloc);
    [wdis, wind] = sort(wdis, 'ascend');
    if length(wdis) >= k1
        wloc = wloc(wind(1:k1));
    end
    bloc = find(ind ~= ind(i));
    bdis = Dis(i, bloc);
    [bdis, bind] = sort(bdis, 'ascend');
    if length(bdis) >= k2
        bloc = bloc(bind(1:k2));
    end
    S(i,wloc) = 1;
    S(wloc,i) = 1;
    SP(i, bloc) = 1;
    SP(bloc, i) = 1;
end


L  = diag(sum(S,  2)) - S;
LP = diag(sum(SP, 2)) - SP;
Sw = X * L * X';
Sb = X * LP * X';

[Psi, Lamda] = eig(Sw);
Lamda = diag(Lamda);
Lamda = diag(Lamda.^(-0.5));

temp = Lamda * Psi' * Sb * Psi * Lamda;
for i = 1:size(temp, 1)
    for j = i:size(temp,2)
        temp(i,j) = temp(j,i);
    end
end
[Phi, Sigma] = eig(temp);
Sigma = diag(Sigma);
[Sigma, IX] = sort(Sigma, 'descend');
Phi = Phi(:,IX);
vec = Psi * Lamda * Phi;
for i = 1:size(vec, 2)
    vec(:,i) = vec(:,i) / sqrt(sum(vec(:,i).^2));
end
