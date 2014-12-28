function [ res ] = solve( p )
c = 1;
res = 0;
nbTriangle = 0;
while (c<p/2)
    for a=1:c
        for b=1:a
            if (a+b>c && a+b+c<p)
                [l,IA,IB,IC,r] = L(a,b,c);
                if ((IA - floor(IA) == 0) && (IB - floor(IB) == 0) && (IC - floor(IC) == 0))
                    res = res + l;
                    nbTriangle = nbTriangle + 1;
                    a
                    b
                    c
                    r
                    r*(a+b+c)/2
                    a*r/2
                    sqrt(IC^2-r^2)
                    sqrt(IB^2-r^2)
                    sqrt(IA^2-r^2)
                end
            end
        end
    end
    c = c+1;
end
nbTriangle    
end

