function out = Function1(x)

    result1=0; 
    result2=0; 
    
    for i=1:5
        result1 = result1 + i* (cosd( (i+1)*x(1) + 1));
    end;
    
    for j=1:5
         result2 = result2 + j* (cosd((j+1)*x(2) + 1));
    end;

    out = -result1 * result2;
end
