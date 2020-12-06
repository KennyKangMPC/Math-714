clear; close all; clc

N = 129;

dx = 1/N;
dt = 0.45*dx; 

xs = 0:dx:1;
avgs = (xs(1:N) + xs(2:N+1))/2;

Q = (3/2) + sin(2*pi*avgs);
iter = 0;

while 1
    iter = iter + dt;
    plot(avgs, Q, 'linewidth', 2);
    ylim([0,3]);
    title(strcat('Godunon Method Visualization at t =', num2str(iter)));
    xlabel('x');
    ylabel('u');
    Q = godunov(Q,dt,dx,1);
    pause(0.1);
end