function [sol,valSol,valProblemEuler] = solve(n)
tic
valMax = floor(n*log(pi+4-3*exp(1/n)))+1

arrVal = 1:valMax;
arrVal = exp(arrVal./n);

arrPaire = zeros(valMax^2,3);
for i=1:valMax
    for j=1:valMax
        arrPaire((i-1)*valMax+j,1) = arrVal(i) + arrVal(j);
    end
end
[arrPaire(:,1)] = sort(arrPaire(:,1),'descend');
for i=1:valMax^2
    aux = pi+4-arrPaire(i,1);
    m=1;
    tic
    while ((m<=valMax^2)&&(aux < arrPaire(m,1)))
        m=m+1;
    end
    toc
    if ((m-1)==valMax^2)
        m = valMax^2;
    elseif (m~=1)
        if (abs(aux-arrPaire(m-1))<abs(aux-arrPaire(m)))
            m = m-1;
        end
    end
    arrPaire(i,2) = m ;
    arrPaire(i,3) = abs(arrPaire(i,1)+arrPaire(m,1)-pi-4);
        if (mod(i,100)==0)
        i
    end
end
[~,ind]=min(arrPaire(:,3));
indPremierePaire = [floor(arrPaire(ind,2)./valMax)+1,max([1,mod(arrPaire(ind,2),valMax)])];
indSecondePaire = [floor(ind./valMax)+1,max([1,mod(ind,valMax)])];
sol=[indPremierePaire,indSecondePaire];
valSol = arrPaire(ind,3);
valProblemEuler = sum(sol.^2);
save lol
toc





