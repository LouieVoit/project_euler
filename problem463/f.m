function [res] = f(n)
if (n==1 || n==3)
    res = n;
elseif (mod(n,2)==0)
    res = f(n/2);
elseif (mod(n-1,4) == 0)
    res = 2*f((n-1)/2+1)-f((n-1)/4);
elseif (mod(n-3,4)==0)
    res = 3*f((n-3)/2 +1)-2*f((n-3)/4);
end
end

