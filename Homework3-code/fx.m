function [y] = fx(x)
%Fx: Calculates f(x) as defined in Homework 2 Problem B/C
y = exp(-400*((0.5*x+0.5)-0.5).^2);
end