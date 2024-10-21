     function [X W r]   =   WNNMs(Y,nSig ,m, Par)
[U0,S0,V0]    =   svd(full(Y),'econ');
S0            =   diag(S0);
Sigma0          =S0;
thr               =  nSig * sqrt(2 * log(length(Sigma0)));
S                 =   thre(Sigma0, thr);
U                 =   U0;
V                 =   V0;
X                 =   U*diag(S)*V';
wei = CalculateWei(Y, Par);
X                 =   (X).*wei;
X                 =   X + m;
return;
