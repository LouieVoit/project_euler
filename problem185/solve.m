function [ res ] = solve( M_create )
M = M_create;
[n,m] = size(M);
res = zeros(m-1);
v = zeros(11,m-1);
indnzero = [];
for i=1:n
    if (M(i,m) == 0)
        for j=1:m-1
            v(M(i,j)+1,j) = -1;
        end
    else
        indnzero = [indnzero,i];
    end
end
v(11,:)=-ones(1,m-1);
M = M(indnzero,:);

lastMod = zeros(m-1);
loop = 1;
i = 1;
while (loop)
    nbPossible = M(i,m);
    jPossible = [];
    for j=1:m-1
       if (v(M(i,j)+1,j) >=0 && v(11,j)==-1 || v(11,j)==M(i,j))
           jPossible = [jPossible,j];
       end
    end
    if (isempty(jPossible) && i>1) 
        i = i-1;
        indlastmod = find(lastmod==1);
        for j=indlastmod
            v(M(i,j)+1,j) = -2;
            v(11,j) = -1;
        end
        lastmod = lastmod - 1;
        indNeg = find(lastmod<0);
        lastmod(indNeg)=zeros(length(indNeg));
    elseif (isempty(jPossible) && i==1)
        indBad = find(lastmod);
        for j=indBad
            v(M(i,j)+1,j) = -1;
            v(11,j) = -1;
        end
        for i=1:10
            for j=1:m-1
                if (v(i,j) == -2)
                    v(i,j) = 0;
                end
            end
        end
    elseif (i==n)
        loop = 0;
    else        
        rndchoice = randi(length(jPossible),1,nbPossible);
        jchoice = jPossible(rndchoice);
        v(11,jchoice)=M(i,jchoice);
        indzero = find(lastmod==0);
        lastmod = lastmod + 1;
        lastmod(jchoice) = 1;
        lastmod(indzero) = 0;
        i = i+1;
    end
end
res = v(11,:);
end

