function [u1] = initialStep(u0,u0_t, dt)
% initiallize scheme: Based on Problem C(b)

% Input:  
%    u0  : initial grid at t = 0
%    u0_t : Derivative with respect to t of u0
%    dt  : grid spacing in time
% Output: 
%    u1  : grid at t=1

u1 = u0 + dt*u0_t + (1/2)*(dt^2)*Laplacian(u0) + (1/6)*(dt^3)*Laplacian(u0_t);

% Same BC as homework 2: homogeneous Dirichlet boundary condition
N = size(u0,1);
u1(1,:) = 0;
u1(N,:) = 0;
u1(:,1) = 0;
u1(:,N) = 0;

end
