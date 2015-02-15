function possibleSol = unionRows(Mpos,Mneg,ind)
possibleSol=[];
[n,m]=size(M);
for i=ind
    row=M(i,1:m-1);
    combRow=nchoosek(row,M(i,m));
    possibleSol=unionComb(possibleSol,combRow);
end