function [sol,valSol,valProblemEuler] = solveOptOpt(n)
tic
valMax = floor(n*log(pi+4-3*exp(1/n)))+1

arrVal = 1:valMax;
arrVal = exp(arrVal./n)-1;
arrPaire = zeros(1,valMax*(valMax+1)/2);

fprintf('Creation tableau des paires\n');
k=1;
for i=1:valMax
    for j=i:valMax
        arrPaire(k) = arrVal(i) + arrVal(j);
        k = k+1;
    end
end
fprintf('Fin creation tableau des paires\n');

fprintf('Tri tableau des paires\n');
I = (arrPaire<pi);
arrPaire=arrPaire(I);
[arrPaire] = sort(arrPaire,'descend');
fprintf('Fin tri tableau des paires\n');

fprintf('Recherche des meilleurs couple de paire \n');
nbPaire = length(arrPaire);
bestErr = Inf;
lowInd = 1;
upInd = nbPaire;
while (lowInd < upInd)
    aux = arrPaire(upInd) + arrPaire(lowInd) - pi;
    if abs(aux) < bestErr
        bestErr = abs(aux);
        bestInd = [lowInd,upInd];
    end
    if aux>0
        lowInd = lowInd + 1;
    else
        upInd =  upInd - 1;
    end
end
fprintf('Fin recherche des meilleurs couple de paire \n');
k=1;
for i=1:valMax
    for j=i:valMax
        ind1 = bestInd(1);
        ind2 = bestInd(2);
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
toc







