function [ inter,nbInter ] = interRows( M,ind )
    nbInter = 0;
    [~,m] = size(M);
    inter = -ones(1,m-1);
    Maux = M(ind,1:(m-1));
    [n,m] = size(Maux);
    for j=1:m
      nRow = 1;
      for i=1:n
          dupInd = find(Maux(:,j)==Maux(i,j)&(Maux(:,j)>=0));
          if (length(dupInd)>1)
              inter(nRow,j) = Maux(i,j);
              inter(nRow,j+1:m)=-1;
              Maux(dupInd,j)=-1;
              nRow = nRow + 1;
              nbInter = nbInter + 1;
          end
      end  
    end
end

