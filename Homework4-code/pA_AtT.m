clear; close all; clc 

% This function plots the upwind method for varying number of grid points
% at a approximate time. 

Ns = 128;
Nstring = string(Ns);
T = 0.3;

for i=1:length(Ns)
    N = Ns(i);

    dx = 1/N;
    dt = (0.5)*dx;

    xs = 0:dx:1;
    Q = (3/2) + sin(2*pi*xs);
    
    numIters = round(T/dt);
    Q = upwind(Q,dt,dx,numIters);
    
    hold on
    plot(xs, Q, 'r');
    hold off
    
end

ylim([0, 3])
title(strcat('Visualization at around time = ', num2str(T)));
ax = gca;
ax.FontSize = 13;