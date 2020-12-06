%
clc; clear; close all

% This is the main driver of producing an animation of the upwind method
% as it evolves over time. Need stop the animation since the nIter setting
% is very large. nIter = 10000;


N = 128;
dx = 1/N;
dt = (0.5)*dx;
xs = 0:dx:1;

Q = (3/2) + sin(2*pi*xs); % IC
iter = 0;
nIter = 10000; 

for i = 1:nIter
    iter = iter + dt;
    plot(xs, Q, 'linewidth', 2);
    ylim([-.5,3])
    title(strcat('Upwind Visualization at t =', num2str(iter)));
    xlabel('x');
    ylabel('u')
    Q = upwind(Q, dt, dx, 1);
    pause(0.1);
end

