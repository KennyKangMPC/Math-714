function [ucurr, xs, ys, time] = FFT_spectralWave(N, T, B)
N = N-1;
thetas = (1/N)*pi*(0:N);
xs = cos(thetas); % these values go from -1 to 1. We need from 0 to 1
%xs = (1/2)*xs + 0.5;
ys = xs';
dt = 6*(1/N)^2;


uold = zeros(N+1,N+1);

% adjust for x,y in [-1,1] instead of [0,1] where they should be
derivAtZero = sin(B*pi*(ys*0.5 + 0.5))*sin(B*pi*(xs*0.5 + 0.5));
%derivAtZero = sin(B*pi*ys)*sin(B*pi*xs);
ucurr = initialStep(uold, derivAtZero, dt);

numRounds = round(T/dt);

for rounds=2:numRounds
    [ucurr, uold] = Ca_step(ucurr, uold, dt);
end
time = numRounds * dt;

end