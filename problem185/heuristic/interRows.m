function [ inter,nbInter ] = interRows( Mpos,Mzero,ind )
    nbInter = 0;
    [~,m] = size(Mpos);
    inter = -ones(1,m-1);
    Maux = Mpos(ind,1:(m-1));
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
    % Mask Mzero
    [n,m] = size(inter);
    for j=1:m
        for i=1:n
            if (ismember(inter(i,j),Mzero(:,j)))
                inter(i,j)=-1;
            end
        end
    end       
end

