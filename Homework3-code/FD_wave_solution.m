function [u,x,y] = FD_wave_solution(N, T, dt, B)
% Hw2 code from github, slightly changes include: initial condition,
% remove plotting and relevant variables.

% initial condition
ut = @(x,y)(sin(B*pi*x).*sin(B*pi*y));

% number of iterations
Nit = ceil(T/dt);
% we suppose that both dimension have the same number of points
M = N;

% grid spacing
dx = 1/(N-1);
dy = 1/(M-1);

% grids in each dimension
x = 0:dx:1;
y = 0:dy:1;

% printing the CFL number
fprintf("CFL number is %.4f \n", dt/dx )

% 2D grids
[X, Y] = meshgrid(x,y);

% defining the parameter alpha
alpha = dt^2/2;

% initial guess
u0 = zeros(M, N);
% initialization using the initial speed
u1 = u0 + dt*ut(X,Y);
% the n+1 field
u =  zeros(M, N);

for i = 1:Nit
    
    % u^{n+1} = -u^{n-1} + [dt^2(D_{c,x} + D_{c,y}) + 2]u^{n}
    u = -u0 + 2*Ah(u1, dx, dy, alpha);
    % update u^{n} and u^{n-1}
    u0 = u1;
    u1 = u;
end

end
