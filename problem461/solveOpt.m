function [sol,valSol,valProblemEuler] = solveOpt(n)
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
percent = 0;
m = nbPaire;
for i=1:floor(nbPaire/2)
    if (i<m)
        aux = pi - arrPaire(i);
        while (m>1 && aux > arrPaire(m))
            m = m-1;
        end
        if ((m~=nbPaire) && (abs(aux-arrPaire(m))>=abs(aux-arrPaire(m+1))))
            m = m+1;
        end
        if (abs(aux - arrPaire(m)) < bestErr)
            bestErr = abs(aux - arrPaire(m));
            bestInd = [i,m];
        end
    end
    if (floor(i*200/nbPaire) > percent)
        percent = floor(i*200/nbPaire);
        fprintf('%d %% effectu?, courage et patience ma bite ...\n',percent);
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
fprintf('Elapsed time : %d s\n',time);
toc







