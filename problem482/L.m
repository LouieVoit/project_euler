function [ res,IA,IB,IC,r,S ] = L(a,b,c)
    aC = acos((c^2-a^2-b^2)/(-2*a*b));
    aA = acos((a^2-c^2-b^2)/(-2*c*b));
    aB = acos((b^2-a^2-c^2)/(-2*a*c));
    S = a*b*sin(aC)/2;
    p = a+b+c;
    r=2*S/p;
    IA = 2*S/(p*sin(aA/2));
    IB = 2*S/(p*sin(aB/2));
    IC = 2*S/(p*sin(aC/2));
    res = p + IA + IB + IC;
end

