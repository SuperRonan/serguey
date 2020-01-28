function demo_fminunc()
    options = optimoptions('fminunc','Algorithm','trust-region','SpecifyObjectiveGradient',true);
    x0 = [1,1];
    [x,fval] = fminunc(@myfun,x0,options);
    disp(['xfinal = ' num2str(x) ' (valeur de f = ' num2str(fval) ')'])
    
    function [f,g] = myfun(x)
        f = 3*x(1)^2 + 2*x(1)*x(2) + x(2)^2;
        if nargout > 1
            g(1) = 6*x(1)+2*x(2);
            g(2) = 2*x(1)+2*x(2);
        end
        
    end
end