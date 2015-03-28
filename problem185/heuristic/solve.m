function [ sol ] = solve( Mproblem )
    M = Mproblem;
    [~,m] = size(M);
    sizeSol = m-1;
    sol = zeros(1,sizeSol)-1;
    loop = 1;
    while loop>0
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
        indSFound = [];
        if (~isempty(indSCell))
            %% We found ind such as sum(Ki) > n, we now have to find ind such as there is
            %  only one digit in the intersection
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
             elseif (isempty(find(sol==-1)))
                 loop = 0;
             else
                 loop = -1;
             end
        else
            %% We haven't found ind such as sum(Ki) > n
            % Let's hope that there exists ind such as sum(Ki) == n,
            % otherwise, that's bad
            indSCell = indSearch(Mpos,sizeSol-1);
            % Let's eliminate digits with the zero rows
            [n,m] = size(Mpos);
            for i=1:n
                for j=1:(m-1)
                    if (ismember(Mpos(i,j),Mzero(:,j)))
                        Mpos(i,j)=-1;
                    end
                end
            end
            % Let's hope a row contains only one digit
            % Frak, it's a wild guess
            wildGuess = 0;
            [~,m] = size(Mpos);
            for i=1:n
                indAux = find(Mpos(i,1:(m-1))~=-1);
                if (length(indAux)==1)
                    % We found one!
                    wildGuess = 1;
                    indWildGuess = [i,indAux];
                end
            end
            if wildGuess
                indSFound = [indSFound,indWildGuess(2)];
                sol(indWildGuess(2)) = Mpos(indWildGuess(1),indWildGuess(2));
                M = createSubProblem(M,indSFound,sol);
                if (isempty(find(sol==-1)))
                 loop = 0;
                end
            else
                loop = -2;
            end
        end    
        M
        sol
        pause
    end
end

