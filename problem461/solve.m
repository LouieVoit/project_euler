function [sol,valSol,valProblemEuler] = solve(n)
valMax = floor(n*log(pi+4-3*exp(1/n)))+1
nbPaire = valMax*(valMax+1)/2

arrVal = 1:valMax;
arrVal = exp(arrVal./n);

arrPaire = zeros(nbPaire,1);

k=1;
for i=1:valMax
    for j=i:valMax
        arrPaire(k) = arrVal(i) + arrVal(j);
        k = k+1;
    end
end

[arrPaire] = sort(arrPaire,'descend');

bestErr = Inf; 
for i=1:nbPaire
    aux = pi+4-arrPaire(i);
    if (aux>0)
        min = 1;
        max = nbPaire;
        while (max>=min)
            mid = floor((max+min)/2);
            if (aux<arrPaire(mid))
                min = mid+1;
            else
                max = mid-1;
            end
        end
        err = abs(aux-arrPaire(mid));
        if (err<bestErr)
            bestErr = err;
            indBest = [i,mid];
        end
    end
    if (mod(i,10000)==0)
        fprintf('%d %% effectué, courage et patience ...\n',(floor(i*100/nbPaire)));
    end
end

k=1;
for i=1:valMax
    for j=i:valMax
        ind1 = indBest(1);
        ind2 = indBest(2);
        if (arrPaire(ind1) == arrVal(i) + arrVal(j))
            a=i;
            b=j;
        end
        if (arrPaire(ind2) == arrVal(i) + arrVal(j))
            c=i;
            d=j;
        end
        k = k + 1;
    end
end
    
sol = sort([a,b,c,d]);
valSol = bestErr;
valProblemEuler = sum(sol.^2);

%     while ((m<=nbPaire)&&(aux < arrPaire(m,1)))
%         m=m+1;
%     end
%     if ((m-1)==nbPaire)
%         m = nbPaire;
%     elseif (m~=1)
%         if (abs(aux-arrPaire(m-1,1))<abs(aux-arrPaire(m,1)))
%             m = m-1;
%         end
%     end
%     arrPaire(i,2) = m ;
%     if (mod(i,100)==0)
%         fprintf('Iteration #%d\n',i);
%     end

% for i=1:nbPaire
%     iaux = perm(i);
%     m = perm(arrPaire(i,2));
%     indPremierePaire = [min(valMax,floor(m./valMax)+1),max([1,mod(m,valMax)])];
%     indSecondePaire = [min(valMax,floor(iaux./valMax)+1),max([1,mod(iaux,valMax)])];
%     arrPaire(i,1) = abs(sum(arrVal([indPremierePaire,indSecondePaire]))-pi-4);
% end
% 
% [valSol,ind]=min(arrPaire(:,1));
% iaux = perm(ind);
% m = perm(arrPaire(ind,2));
% indPremierePaire = [min(valMax,floor(m./valMax)+1),max([1,mod(m,valMax)])];
% indSecondePaire = [min(valMax,floor(iaux./valMax)+1),max([1,mod(iaux,valMax)])];
% sol = sort([indPremierePaire,indSecondePaire]);
% valProblemEuler = sum(sol.^2);






