function [ Msub ] = createSubProblem( M,indSol,sol )
    Msub = M;
    [n,m]=size(Msub);
    for j=indSol
        s = sol(j);
        for i=1:n
            if (Msub(i,j)==s)
                Msub(i,m)=Msub(i,m)-1;
            end
            Msub(i,j)=-1;
        end
    end
end

