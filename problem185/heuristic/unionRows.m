function possibleSol = unionRows(Mpos,Mzero,ind)
%% Find every possible solution from rows of indice ind in Mpos for the 
% initial problem. For one set of indice in ind, sum(Ki) = n.
%% Initisialization
possibleSol=[];
[n,m]=size(Mpos);
M=Mpos(ind,1:(m-1));
Ki = Mpos(:,m);
% Remove columns with only -1
interestingInd = find(M(1,:)~=-1);
M=M(:,interestingInd);
%%





end

function possibleSolAux = unionRec(M,Ki)

