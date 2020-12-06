function [F] = Flux(Q, qs)

    N = length(Q);
    F = zeros(1, N+1);
    
    for i=1:(N+1)
        
        if i == N+1 %BC
            a = Q(1);
        else
            a = Q(i);
        end
        
        if i == 1 %BC
            b = Q(N);
        else
            b=Q(i-1);
        end
    
        if f(a) == f(b)
            F(i) = f(b); 
            continue;
        end
    
        S = (f(a) - f(b))/(a-b);
    
        if (b > qs) && S > 0
            F(i) = f(b);
        elseif (a < qs) && (S < 0)
            F(i) = f(a);
        elseif (b < qs) && (qs < a)
            F(i) = f(qs);
        else
            disp("Issues!"); % we shouldn't reach this point!
        end

    end

end

function y = f(x)
    y = 0.5*(x.^2);
end