function I = indSearch(M,n)
%% M is the matrice from the exemple, without modification.
% Find indice such as sum(Ki) > n where Ki = M(i,ncol), number of exact number
% in a row

%% 
    [nrow,ncol] = size(M);
    %n=ncol-1;
    M(:,ncol+1) = 1:nrow;
    ind =[];
    I = indSearchRec(M,n,ind);
end

function [ I ] = indSearchRec( M,n,ind )
    if (n<0)
        I={ind};
        if (~isempty(M))
            [nRow,nCol] = size(M);
            I1 = indSearchRec( M(2:nRow,:),n-M(1,nCol-1),[ind,M(1,nCol)]);
            I2 = indSearchRec( M(2:nRow,:),n,ind);
            if (isempty(I1))
                I=I2;
            elseif (isempty(I2))
                I=I1;
            elseif (isempty(I1) && isempty(I2))
                I={};
            else
                I={I1{:},I2{:}};
            end  
        end
    elseif (isempty(M))
        I={};
    else
        [nRow,nCol] = size(M);
        I1 = indSearchRec( M(2:nRow,:),n-M(1,nCol-1),[ind,M(1,nCol)]);
        I2 = indSearchRec( M(2:nRow,:),n,ind);
        if (isempty(I1))
            I={I2{:}};
        elseif (isempty(I2))
            I={I1{:}};
        elseif (isempty(I1) && isempty(I2))
            I={};
        else
            I={I1{:},I2{:}};
        end
    end
end


