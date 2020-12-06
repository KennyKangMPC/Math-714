clear;
%figure;

fN = 512; % fine scale
fdx = 1/fN;
fxs = 0:fdx:1;
fdt = (0.4)*fdx;

T = 1;
Ns = [32 64 128 256];
err = zeros(1, length(Ns));

for i = 1:length(Ns)
    N = Ns(i);
    dx = 1./N;
    xs = 0:dx:1;
    Q = ItGod(xs,dx);
    dt = 0.4*dx;
    
    fQ = ItGod(fxs,fdx);
    diff = fN/N;
    
    numRounds = round(T/dt);
    
    for j=1:numRounds
        fQ = godunov(fQ,fdt,fdx,diff);
        Q = godunov(Q,dt,dx,1);
        err(i) = max(maxErrorGod(fQ,Q, diff),err(i));
    end
end

plot(log(Ns), log(err), 'o-');
title(strcat("Godnuov Error vs Grid Size at time T=", num2str(T)))
xlabel("log of number of points (2^x grid points)")
ylabel("log of absolute error")
ax = gca;
ax.FontSize = 14;

function [e] = maxErrorGod(A,B, diff)
% calculate the max error between a fine and coarse vector.

indexs = [];
for i=1:length(B)
    indexs = [indexs i*ones(1,diff)];
end

errorVector = abs(A - B(indexs));
e = max(errorVector);

end

  
function [Q0] = ItGod(xs,dx)

b = 2:length(xs);
a = 1:(length(xs) - 1);

Q0 = (1/dx)*((3/2)*(xs(b)-xs(a)) + ...
             (1/(2*pi))*( cos(2*pi*xs(a)) - cos(2*pi*xs(b))));
end