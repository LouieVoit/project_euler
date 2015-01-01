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

lastmod = zeros(1,m-1);
loop = 1;
i = 1;
nNzero = length(indnzero);
iter=0;
while (loop)
    i
    v
    pause
    iter=iter+1;
    nbPossible = M(i,m);
    jPossible = [];
    for j=1:m-1
       if (v(M(i,j)+1,j) >=0 && v(11,j)==-1 || v(11,j)==M(i,j))
           jPossible = [jPossible,j];
       end
    end
    jPossible
    if (length(jPossible)<nbPossible) 
        i = i-1;
        indlastmod = find(lastmod==1);
        for k=1:10
            for j=1:m-1
                if (v(k,j) < -(i+1))
                    v(k,j) = 0;
                end
            end
        end
        for j=indlastmod
            v(M(i,j)+1,j) = -(i+1)*(i>1)+-1*(i==1);
            v(11,j) = -1;
        end
        lastmod = lastmod - 1;
        lastmod(find(lastmod<0)) = 0;
    else
        goodPick=0;
        while ~goodPick
            rndchoice = randi(length(jPossible),1,nbPossible);
            rndchoice=sort(rndchoice,'ascend');
            bool=1;
            for j=1:length(rndchoice)-1
                bool=bool&&(rndchoice(j)<rndchoice(j+1));
            end
            goodPick = bool;
        end
        jchoice = jPossible(rndchoice);
        v(11,jchoice)=M(i,jchoice);
        indzero = find(lastmod==0);
        lastmod = lastmod + 1;
        lastmod(indzero) = 0;
        lastmod(jchoice) = 1;
        i = i+1;
        if (i == nNzero+1)
            loop = 0;
        end
    end
end
res = v(11,:);
end

