clear; close all; clc

% plots the error of coarse scale grid by compaing to a very fine grid at a
% specified time.

fN = 512; % a very fine grid
fdx = 1/fN;
fxs = 0:fdx:1;
fdt = (0.4)*fdx;

T = 1;
Ns = [32 64 128 256 ];%512 1024];
err = zeros(1, length(Ns));

for i = 1:length(Ns)
    N = Ns(i);
    dx = 1./N;
    xs = 0:dx:1;
    Q = (3/2) + sin(2*pi*xs);
    dt = 0.4*dx;
    
    fQ = (3/2) + sin(2*pi*fxs);
    diff = fN/N;
    
    numRounds = round(T/dt);
    
    for j=1:numRounds
        fQ = upwind(fQ,fdt,fdx,diff);
        Q = upwind(Q,dt,dx,1);
        err(i) = max(maxErrorCal(fQ,Q, diff),err(i));
    end
end

plot(log(Ns), log(err), 'o-', 'linewidth', 2);
title(strcat("UpWind Error vs Grid Size at time T=", num2str(T)));
xlabel("log of number of points")
ylabel("log of absolute error")
ax = gca;
ax.FontSize = 14;