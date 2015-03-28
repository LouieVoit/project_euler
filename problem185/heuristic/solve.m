function [ sol ] = solve( Mproblem )
    M = Mproblem;
    [~,m] = size(M);
    sizeSol = m-1;
    sol = zeros(1,sizeSol);
    loop = 1;
    while loop
        % Zero extraction
        [n,m]=size(M);
        indZero = find(M(:,m)==0);
        Mzero = M(indZero,:);
        Mpos=[];
        for i=1:n
            if ~ismember(i,indZero)
                Mpos = [Mpos;M(i,:)];
            end
        end
        % Indice search in M such as sum(Ki) > n
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
                % Then we keep looking for the solution of the subproblem 
                M = createSubProblem(M,indSFound,sol);
                sizeSol = sizeSol - length(indSFound);
             else
                 loop = 0;
             end
        else
            %% We haven't found ind such as sum(Ki) > n 
            % Let's hope that there exists ind such as sum(Ki) == n,
            % otherwise, that's bad
            indSCell = indSearch(Mpos,sizeSol-1);
            % Seek every possible solutions
            possibleSol=[];
            for indCell=indSCell
                ind=indCell{:}
                possibleSol = [possibleSol;unionRows(Mpos,Mzero,ind)]
            end          
            % Remove impossible solution
           
        end    
        M
        sol
        pause
    end
end

