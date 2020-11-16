function [utNew,utCurr] = Ca_step(utCurr,utPrev, dt)
%CA_STEP Discretized grid value update for the next step based on 
% 4th order accuracy scheme developed in C.a
% Input:
%   utCurr: current time step grid value
%   utPrev: previous time step grid value
%   dt    : size of time step
% Output:
%   utNew : next time step grid value
%   vvCurr: matrix at current time step (same as input)

LapU = Laplacian(utCurr); 
LapSquareU = Laplacian(LapU);

utNew = -utPrev + 2*utCurr + ((dt)^2)*LapU + (1/12)*((dt)^4)*LapSquareU;

%BC
N = size(utCurr,1);

utNew(1,:) = 0;
utNew(N,:) = 0;

utNew(:,1) = 0;
utNew(:,N) = 0;
end

