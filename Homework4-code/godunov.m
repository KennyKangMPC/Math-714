function [Q] = godunov(Q, dt, dx, nSteps)

% This is the function implementing godunov scheme
N = length(Q);

for i=1:nSteps
    
    F = Flux(Q,0); 
    
    Q = Q - (dt/dx)*(F(2:N+1) - F(1:N)); % with peroidic BC
    
end

end