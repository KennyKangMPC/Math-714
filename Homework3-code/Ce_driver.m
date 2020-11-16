close all; clear; clc;
N = 64; % value can also be 128
T = 0.75;

waveDt = (1/N)*(1/5);

Bs = 10:10:200;
errSp = zeros(length(Bs),1); % spectral error
errFd = zeros(length(Bs),1); % finite difference error

for i=1:length(Bs)
    B = Bs(i);
    disp(B);
    [spect, xs, ys, ts] = FFT_spectralWave(N, T, B);
    [fd, xf, yf] = FD_wave_solution(N, T, waveDt, B);
    
    % adjust for x,y in [-1,1] instead of [0,1]
    spectSolution = (1/(2*B*pi))*sin(B*pi*(0.5*ys+0.5))*sin(B*pi*(0.5*xs+0.5)).*sin(2*B*pi*ts);
    fdSolution = (1/(2*B*pi))*sin(B*pi*yf')*sin(B*pi*xf).*sin(2*B*pi*T);
    
    spectError = max(max(abs(spectSolution - spect)));
    fdError = max(max(abs(fdSolution - fd)));

    errSp(i) = log(spectError);
    errFd(i) = log(fdError);
end

hold on
plot(Bs, errSp, '-');

plot(Bs, errFd, '--');
legend('spectral FFT solver error','Finite Difference solver error','Interpreter','latex', 'FontSize', 24)
%plot(Bs, errFd2, '-');

ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;

title('Error vs B','Interpreter','latex', 'FontSize', 24);
xlabel('B','Interpreter','latex', 'FontSize', 18)
ylabel('Error at time 0.75','Interpreter','latex', 'FontSize', 18)
hold off