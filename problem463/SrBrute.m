function [ res ] = SrBrute( n )
if (n==1)
    res = 1;
elseif (n==2)
    res = 2;
elseif (n==3)
    res = 5;
elseif (n<=0)
    res =0;
elseif(mod(n,4) == 0)
    q = n/4;
    res = -1 + 6*SrBrute(2*q-1) - 9*SrBrute(q-1)+ SrBrute(q);
elseif (mod(n-1,4) == 0)
    q = (n-1)/4;
    res = -1 - 6*SrBrute(q-1) +2*SrBrute(2*q+1) +4*SrBrute(2*q-1) -2*SrBrute(q);
elseif (mod(n-2,4) == 0)
    q=(n-2)/4;
    res = -1- 3*SrBrute(q) +3*SrBrute(2*q+1) +3*SrBrute(2*q-1) -5*SrBrute(q-1);
elseif (mod(n-3,4) == 0)
    q = (n-3)/4;
    res = -1 + 6*SrBrute(2*q+1) -8*SrBrute(q);
end
end


