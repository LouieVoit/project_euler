function [ sol ] = solve( Mp )
    M = Mp;
    [~,m] = size(M);
    sizeSol = m-1;
    sol = zeros(1,sizeSol);
    loop = 1;
    while loop
        %% Zero extraction
        [n,m]=size(M);
        indZero = find(M(:,m)==0);
        Mzero = M(indZero,:);
        Mpos=[];
        for i=1:n
            if ~ismember(i,indZero)
                Mpos = [Mpos;M(i,:)];
            end
        end
        %% Indice search in M such as sum(Ki) > n
        indSCell = indSearch(Mpos,sizeSol);
        if (~isempty(indSCell))
            %% We found ind such as sum(Ki) > n, we now have to find ind such as there is
            %  only one digit in the intersection
            indSFound = [];
            for indCell=indSCell
                ind=indCell{:};
                [inter,nb] = interRows(Mpos,Mzero,ind);
                if (nb==1)
                    indaux = find(inter~=-1);
                    indSFound = [indSFound,indaux];
                    sol(indaux) = inter(indaux);
                end
            end   
             if (~isempty(indSFound))   
                M = createSubProblem(M,indSFound,sol);
             else
                 loop = 0;
             end
        else
            %% We didnt found ind such as sum(Ki) > n 
            
        end    
    end
end

