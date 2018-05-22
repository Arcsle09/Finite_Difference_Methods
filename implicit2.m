close all;
clear all;
clc;
format compact

l = input('Enter the length of rod:');
dx = input('Enter the step size for x-axis:');
x = 0:dx:l;
m = length(x);

ub = input('Enter the upper bound time step:');
dt = input('Enter the step size of t-axis:');
t = 0:dt:ub;
n = length(t);

k = input('Enter the thermal density:');
rho = input('Enter the density:');
c = input('Enter thermal conductivity:');
alpha = k/(rho*c);
lembda = (alpha*dt)/(dx*dx);


T = zeros(m,n);
T(:,1) = sin(pi*x); % Initial Condition
T(1,:) = 0; % Left boundary condition
T(m,:) = 0;  % Right boundary condition
rot90(T)

%Construction of M
M1(1:m-2) = 1 +2*lembda;
M2(1:m-3) = -lembda;
M3(1:m-3) = -lembda;
M = diag(M1,0) + diag(M2,1) + diag(M3,-1)

for j = 1:n-1
    k = [-lembda*T(1,j+1); zeros(m-4,1); -lembda*T(m,j+1)];
    T(2:m-1,j+1) = inv(M)*(T(2:m-1,j)-k);
end
rot90(T)

subplot(221)
plot(T)
xlabel('Different points of rod');
ylabel('Temperature values');
zlabel('Temperature');
title('Simple Plotting of the Solution');

subplot(222)
surf(T)
xlabel('Different points of rod');
ylabel('Different time steps');
title('Surface Plotting of the Solution');


subplot(2,2,3:4)
contour(T)
xlabel('Different points of rod');
ylabel('Different time steps');
title('Contour Plotting of the Solution');

% % OUTPUT:
% Enter the length of rod:0.05
% Enter the step size for x-axis:0.01
% Enter the upper bound time step:9
% Enter the step size of t-axis:3
% Enter the thermal density:54
% Enter the density:7800
% Enter thermal conductivity:490
% ans =
%          0         0         0         0         0         0
%          0         0         0         0         0         0
%          0         0         0         0         0         0
%          0    0.0314    0.0628    0.0941    0.1253         0
% M =
%     1.8477   -0.4239         0         0
%    -0.4239    1.8477   -0.4239         0
%          0   -0.4239    1.8477   -0.4239
%          0         0   -0.4239    1.8477
% ans =
%          0    0.0278    0.0514    0.0629    0.0491         0
%          0    0.0297    0.0564    0.0736    0.0641         0
%          0    0.0309    0.0605    0.0848    0.0873         0
%          0    0.0314    0.0628    0.0941    0.1253         0

