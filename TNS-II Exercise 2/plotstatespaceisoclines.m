function plotisoclines(X0,Xi,A,B)
%Extract taken from provided code in function LinearOrder2

% A is the interaction matrix size(2,2)
% B is the constant input vector size(2,1)
% X0 is the initial conditions of trajectory

%% input
statesize = 20; % statesize is the size of the illustrated part of statespace
tend = 3; % tend is final time of trajectory evaluation (in multiples of tau)

%%
fs = 14; % fontsize for legends

%% solve for steady-state
% steady-state condition is 0 = dv/dt = A dot Xss + B or, equivalently, Xss = A^(-1) dot (-B)
Xss = A \ (-B);

%% obtain eigenvectors and eigenvalues
[V, D] = eig( A );

%% alternative variable names
a11=A(1,1);
a12=A(1,2);
a21=A(2,1);
a22=A(2,2);

b1 = B(1);
b2 = B(2);

xss = Xss(1);
yss = Xss(2);

lambda1  = D(1,1) ; % eigenvalues
lambda2  = D(2,2) ;

E1  = V(:,1) ; % eigenvectors
E2  = V(:,2) ;

%% x-range over which nullclines are evaluated (choose symmetrically around initial condition)
xmin = floor(xss - 0.5*statesize);
xmax = ceil(xss + 0.5*statesize);

%% nullclines dot x = 0 and dot y = 0
xi = linspace(xmin, xmax, 100);
ydx0i = -(a11*xi +b1)/a12;
ydy0i = -(a21*xi +b2)/a22;

%% resulting y-range (choose samre range as for x, to ensure uniform plotting)
ymin = floor(min([ydx0i ydy0i]));
ymax = ceil(max([ydx0i ydy0i]));

%% gradient vectors [dot x, dot y]'
nv = 10;

xv = linspace(xmin, xmax, nv );
yv = linspace(ymin, ymax, nv );

[XV, YV] = meshgrid( xv, yv );

DXV = ( a11*XV + a12*YV + b1);
DYV = ( a21*XV + a22*YV + b2);

%% initial conditions
X0;
Xss;

C  = V \ (X0 - Xss);  % obtain coefficients from X0 = E1*c1 + E2*c2 + Xxx

c1 = C(1);
c2 = C(2);

%% plot trajectories in state-space
figure;
hold on;

plot( xi, ydx0i, 'r', 'LineWidth', 2);   % nullclines
plot( xi, ydy0i, 'b', 'LineWidth', 2);
plot( Xi(1,:), Xi(2,:), 'g');%, 'LineWidth', 4 );      % trajectory
 
quiver( XV, YV, DXV, DYV, 'k', 'LineWidth', 1 );   % gradients

plot( xss, yss, 'k+', 'MarkerSize', 10, 'LineWidth', 2 );   % steady-state
plot( 0, 0, 'ko', 'MarkerSize', 5, 'LineWidth', 1 );   % coordinate origin
plot( [xmin xmax], [0 0], 'k:', 'LineWidth', 2);    % coordinate axes
plot( [0 0], [ymin ymax], 'k:', 'LineWidth', 2);
plot( X0(1), X0(2), 'g+', 'MarkerSize', 10, 'LineWidth', 2 ); % initial condition

hold off;
axis 'square';
axis([xmin xmax ymin ymax]);
xlabel( 'x', 'FontSize', fs );
ylabel( 'y', 'FontSize', fs );
title('Trajectory for initial value [11;9] with isoclines')
h=legend( 'dx/dt=0', 'dy/dt=0', 'X(t)');
set(h,'FontSize', fs );

return;