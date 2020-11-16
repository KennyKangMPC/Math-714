N = 100;
thetas = (1/N)*pi*(0:N);
xs = cos(thetas); % these values go from -1 to 1. We need from 0 to 1
xs = (1/2)*xs + 0.5;
ys = xs';
dt = 6*(1/N)^2; % smaller than the CFL condition

fN = 600; % fine grid
fthetas = (1/fN)*pi*(0:fN);
fxs = cos(fthetas); % these values go from -1 to 1. We need from 0 to 1
fxs = (1/2)*fxs + 0.5;
fys = fxs';
fdt = 6*(1/fN)^2; % smaller than the CFL condition

vold = zeros(N+1,N+1);
vcurr = initialStep(vold, fx(ys)*fx(xs), dt);

fold = zeros(fN+1,fN+1);
fcurr = initialStep(fold, fx(fys)*fx(fxs), fdt);

fineRounds = round(dt / fdt);


for tmp=2:fineRounds
   [fcurr, fold] = Ca_step(fcurr, fold, fdt);
end

numRounds = round(0.1/dt);

error = max(0,maxError(fcurr, vcurr, fN / N));
disp(numRounds)
for rounds=2:numRounds

    if mod(rounds, 10) == 0
        disp(['Round ', num2str(rounds), ' out of ', num2str(numRounds)])
        disp(['Current error: ', num2str(error)]);
    end
    [vcurr, vold] = Ca_step(vcurr, vold, dt);
    
    for tmp=1:fineRounds
       %if mod(tmp, 10) == 0
       %    disp(['findIteration ', num2str(tmp), ' out of ', num2str(fineRounds)]);
       %end

       [fcurr, fold] = Ca_step(fcurr, fold, fdt);
    end
    
    error = max(error,maxError(fcurr, vcurr, fN / N));
    
end
disp(['Error for ', num2str(N), ' is ', num2str(error)]);

function [e] = maxError(A,B, diff)
sizeB = size(B,1) - 1;
index = 0:sizeB-1;
subsetA = [(diff * index) + 1, size(A,1)]; 

ErrorMatrix = abs(A(subsetA, subsetA) - B);
e = max(ErrorMatrix, [], 'all');

end