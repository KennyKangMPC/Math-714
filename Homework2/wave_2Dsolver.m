%% Kangqi Fu Math 714 HW2-Problem C
close all;clear;clc
% Solver of 2D wave equation with homogeneour Dirichlet boundary conditions
% Set up
ng = [90,90]; % number of grid points in x or y direction
H = 1./(ng-1); % space stencil

% a very fine grid and use it as the analytical solution of this PDE


dt = 0.5*H; %time step
T_max=10;

for k = 1:length(ng)
    xy = ng(k); 
    h=H(k);
    times = [0:dt(k):T_max];
    tt=length(times) ;
    x = [0:h:1] ;  y = [0:h:1] ;
    [X,Y] = meshgrid(x,y);
    u = zeros(xy,xy,tt) ; % initialize space for x,y,z meshes
    % first generate initial value for grid
    for i = 2:xy-1 % x position
        for j = 2:xy-1 % y position
            u(i,j,2) = dt(k)*init((i-1)*h)*init((j-1)*h) ; % IC
        end
    end
    
    % update for the rest of the grids
    for n = 3:tt
        for i = 2:xy-1 % x_position
            for j = 2:xy-1 % y_position 
                % 5-point Laplacian
                u(i,j,n) = (dt(k)./h).^2 *( u(i+1,j,n-1) + u(i-1,j,n-1) + u(i,j+1,n-1) + ... 
                       u(i,j-1,n-1)+ (2*(h./dt(k)).^2-4)*u(i,j,n-1) ) - u(i,j,n-2) ;
            end
        end
    end
    
    %add this plotting after discussing with classmates
    Z_max = max(abs(u(:)));
    for n=1:tt
        s=surf(X,Y,u(:,:,n));
        colorbar
        zlim([-Z_max,Z_max]);
        pause(0.1);
    end
end






