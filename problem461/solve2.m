function [sol,valSol,valProblemEuler,fail] = solve2(n)
tic
valMax = floor(n*log(pi+4-3*exp(1/n)))+1

arrVal = valMax:-1:1;
arrVal = exp(arrVal./n);
arrVal = arrVal-(pi/4)-1;

maxJ = zeros(valMax,1);
maxJ(1) = 2;
minJ = ones(valMax,1)*Inf;
minJ(valMax) = valMax-1;
lastModG = [1,2];
lastModL = [valMax,valMax-1];
sumCurrent = arrVal(1)+arrVal(2)+arrVal(valMax)+arrVal(valMax-1);
min = abs(sumCurrent);
indMin = [lastModG,lastModL];
pQG = [2,2];
pQL = [valMax-1,valMax-1];
loop = 1;
iter = 0;
indTeste = [];
while (loop && iter <= 10^5)
    indQG = [];
    indQL = [];
    if (sumCurrent>0)
        sumLastMod = sum(arrVal(lastModG));
        sumCurrent = sumCurrent - sumLastMod;
        indQG = pQG(1,:);
        if (size(pQG,1)~=1)
            pQG = pQG(2:size(pQG,2),:);
        else
            pQG = [];
        end
        lastModG = indQG;
        sumGreater = sum(arrVal(indQG));
        sumCurrent = sumGreater + sumCurrent;
    else
        sumLastMod = sum(arrVal(lastModL));
        sumCurrent = sumCurrent - sumLastMod;
        indQL = pQL(1,:);
        if (size(pQL,1)~=1)
            pQL = pQL(2:size(pQL,2),:);
        else
            pQL = [];
        end
        lastModL = indQL;
        sumLesser = sum(arrVal(indQL));
        sumCurrent = sumLesser + sumCurrent;
    end    
    if (abs(sumCurrent)<min)
        indMin = [lastModG,lastModL];
        min = abs(sum(arrVal(indMin)));
    end
    if (sumCurrent == 0) 
        loop = 0;
        fail = 0;
    elseif (sumCurrent>0)
        indAdd=[];
        i = lastModG(1);
        j = lastModG(2);
        if ((i+1)<=j && j>maxJ(i+1) && i<valMax)
            maxJ(i+1) = j;
            indAdd=[indAdd;(i+1),j];
        end
        if ((j+1)>maxJ(i) && j<valMax)
            maxJ(i) = j+1;
            indAdd=[indAdd;i,j+1];
        end
        pQG = [pQG;indAdd];
    else
        indAdd=[];
        i = lastModL(1);
        j = lastModL(2);
        if ((i-1)>=j && j<minJ(i-1) && i>1)
            minJ(i-1)=j;
            indAdd=[indAdd;(i-1),j];
        end
        if ((j-1)<minJ(i) && j>1)
            minJ(i)=j-1;
            indAdd=[indAdd;i,j-1];
        end
        pQL = [pQL;indAdd];
    end
%     if (mod(iter,100) == 0)
%        abs(sum(arrVal(indMin)))
%        iter
%     end   
    iter = iter + 1;
    if (sumCurrent>0 && isempty(pQG))
        loop = 0;
    end
    if (sumCurrent<0 && isempty(pQL))
        loop = 0;
    end
    indTeste = [indTeste;lastModG,lastModL];
end
bool = 0;
for i=1:size(indTeste,1)
    bool = bool | (sort(indTeste(i,:)) == [6 75 89 226]);
end    
minJ
sol = indMin
valSol = abs(sum(arrVal(indMin)))
valProblemEuler = sum(indMin.^2)
toc





