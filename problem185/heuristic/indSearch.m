function [ I ] = indSearch( M,n,ind )
    if (n<0)
        I={ind};
        if (~isempty(M))
            [nRow,nCol] = size(M);
            I1 = indSearch( M(2:nRow,:),n-M(1,nCol-1),[ind,M(1,nCol)]);
            I2 = indSearch( M(2:nRow,:),n,ind);
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
        I1 = indSearch( M(2:nRow,:),n-M(1,nCol-1),[ind,M(1,nCol)]);
        I2 = indSearch( M(2:nRow,:),n,ind);
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

