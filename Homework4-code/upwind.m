function [Unext] = upwind(U, dt, dx, nSteps)

N = length(U);
Unext = U;

% periodic BC
back = [N, 1:N-1];
forward = [2:N, 1];

for i = 1:nSteps
    Uforward = U(forward) - U;
    Uback = U - U(back);
    Uplus = U > 0;
    Uminus = U < 0;
    Unext = U - (dt/dx).*U.*(Uplus.*Uback + Uminus.*Uforward);
    
    U = Unext;
end

end

