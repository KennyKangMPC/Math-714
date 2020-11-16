(* ::Package:: *)

N= [ 100, 200, 300 ];
maxE = [ 8.1239e-06, 5.2967e-07, 1.018e-07]; % This value are from running Cc_driver by changing N value above


figure(1); clf();
loglog(N,maxE,'o-', 'LineWidth', 2)
hold on; 
loglog(N, (1./N).^4, 'LineStyle', '-')

ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;

title('Error vs N','Interpreter','latex', 'FontSize', 24);
xlabel('number points N','Interpreter','latex', 'FontSize', 24)
ylabel('error relative to a very fine grid','Interpreter','latex', 'FontSize', 24)
legend('Spectral error', 'Comparison 4th order accuracy', 'Interpreter','latex', 'FontSize', 24)
