clear;

N = 400;

dx = 1/N;
dt = 0.4*dx;

xs = 0:dx:1;
avgs = (xs(1:N) + xs(2:N+1))/2;

G = (3/2) + sin(2*pi*avgs);
U = (3/2) + sin(2*pi*xs);

iter = -dt;

T = 0.7; % compare the difference at T = 0.7, can be set to any nonzero value

while 1
    iter = iter + dt;
    plot(xs, U, 'linewidth', 2);
    hold on
    plot(avgs, G, 'linewidth', 2);
    hold off
    ylim([-1,3])
    
    title(strcat("Upwind vs. Godunov at time T=", num2str(iter)));
    legend(["Upwind", "Godunov"])
    ax = gca;
    ax.FontSize = 14;
    xlabel('x');
    ylabel('u');
    U = upwind(U,dt,dx,1);
    G = godunov(G, dt, dx, 1);
    
    if iter > T
        break;
    end
    pause(0.1);
end

title(strcat("Upwind vs. Godunov at time T=", num2str(T)));
legend(["Upwind", "Godunov"])
ax = gca;
ax.FontSize = 14;
xlabel('x');
ylabel('u');