% number of refinements
Np = 4;
% arrays to store the error and mesh size
err = zeros(Np,1);
h = zeros(Np,1);
dt = 0.1;
T = 5; % number of time points

% fine grid as solution
p = 2^5;
M = 10*p;

dx = 1/M;
r = dt^2/dx^2;

x = 0:dx:1;
y = 0:dx:1;

% Building matrix A
e = ones((M-1)^2,1);
A = spdiags([r*e r*e (2-4*r)*e r*e r*e], [-M+1 -1 0 1 M-1], (M-1)^2, (M-1)^2);

% Assembling the final matrix
Wave = kron(spdiags([ones(T+1,1) [2;ones(T,1)]], [-1 1], T+1, T+1), speye((M-1)^2)) - kron(speye(T+1),A);
Wave(T*(M-1)^2+1:end,T*(M-1)^2+1:end) = Wave(T*(M-1)^2+1:end,T*(M-1)^2+1:end) + speye((M-1)^2);

% writing the source term
f = exp(-400*(x-0.5).^2)'*exp(-400*(y-0.5).^2);
ff = reshape(f(2:M,2:M),[(M-1)^2,1]);
e_1 = zeros(T+1,1);   e_1(1) = 1;
F = kron(e_1, 2*dt*ff);

% solving the system using a sparse solver for reference
sol = Wave\F;
sol = reshape(sol,[M-1,M-1,T+1]);

for idxRef = 1:Np

    p = 2^idxRef;
    M = 10*p;

    dx = 1/M;
    r = dt^2/dx^2;

    x = 0:dx:1;
    y = 0:dx:1;
    
    % Building matrix A
    e = ones((M-1)^2,1);
    A = spdiags([r*e r*e (2-4*r)*e r*e r*e], [-M+1 -1 0 1 M-1], (M-1)^2, (M-1)^2);
    
    % Assembling the final matrix
    Wave = kron(spdiags([ones(T+1,1) [2;ones(T,1)]], [-1 1], T+1, T+1), speye((M-1)^2)) - kron(speye(T+1),A);
    Wave(T*(M-1)^2+1:end,T*(M-1)^2+1:end) = Wave(T*(M-1)^2+1:end,T*(M-1)^2+1:end) + speye((M-1)^2);
    
    % writing the source term
    f = exp(-400*(x-0.5).^2)'*exp(-400*(y-0.5).^2);
    ff = reshape(f(2:M,2:M),[(M-1)^2,1]);
    e_1 = zeros(T+1,1);   e_1(1) = 1;
    F = kron(e_1, 2*dt*ff);
    
    % solving the system using a sparse solver for reference
    U = Wave\F;
    U = reshape(U,[M-1,M-1,T+1]);
    
    % computing the relative l^2 error
    err(idxRef) = norm(reshape(sol(2^(5-idxRef):2^(5-idxRef):(end-1),2^(5-idxRef):2^(5-idxRef):(end-1),:) - U(:,:,:),[(M-1)^2*(T+1),1]))/norm(sol(:));
    % saving the step size
    h(idxRef) = dx;

end

% Plotting the results 
figure(1); clf();
loglog(h,err,'o-', 'LineWidth', 2)
hold on; 
loglog(h, h.^2, 'LineStyle', '-')

ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;

title('Error', 'FontSize', 24);
xlabel('$h$','Interpreter','latex', 'FontSize', 24)
ylabel('relative $\ell^2$ error','Interpreter','latex', 'FontSize', 24)


lgd = legend("error", "$\mathcal{O}(h^2)$",'FontSize', 24,...
       'Interpreter','latex');
lgd.Location = 'northwest';