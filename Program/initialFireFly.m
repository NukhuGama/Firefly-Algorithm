function [pop, BestSol] = initialFireFly(nPop, VarMin, VarMax, VarSize,CostFunction)
    %% Initialization
    % Empty Firefly Structure
    firefly.Position=[];
    firefly.Cost=[];
    % Initialize Best Solution Ever Found
    BestSol.Cost=inf;
    % Initialize Population Array
    pop=repmat(firefly,nPop,1);
    for i=1:nPop
       pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
       pop(i).Cost=CostFunction(pop(i).Position);

       if pop(i).Cost<=BestSol.Cost
           BestSol=pop(i);
       end
    end