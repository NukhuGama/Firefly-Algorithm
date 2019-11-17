function [BestSol, newpop] = fireflyMove(nPop, pop, scale, beta0, alpha, gamma, delta, xMin, xMax, VarSize,func,BestSol)
%     rij = 0;
    for i=1:nPop
        newpop(i).Cost = inf;
        for j=1:nPop 
            if pop(j).Cost < pop(i).Cost
%                 rij=  (sqrt((pop(i).Position - pop(j).Position).^2));
                rij=norm(pop(i).Position - pop(j).Position)/scale;
                
                beta=beta0*exp(-gamma*rij.^2);
                e=delta*unifrnd(-1,+1,VarSize);
                %e=delta*randn(VarSize);
                
                newsol.Position = pop(i).Position + beta.*rand(VarSize).*(pop(j).Position - pop(i).Position) + alpha*e;
                
                newsol.Position=max(newsol.Position,xMin); 
                newsol.Position=min(newsol.Position,xMax);
                
                newsol.Cost=func(newsol.Position);
                
                %% Change Generation 
                if newsol.Cost <= newpop(i).Cost
                    newpop(i).Cost = newsol.Cost;
                    newpop(i).Position = newsol.Position;
                    if newpop(i).Cost<=BestSol.Cost
                        BestSol=newpop(i);
                    end
                end
                
            end
        end
    end