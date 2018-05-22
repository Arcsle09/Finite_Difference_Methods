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
T(:,1) = 20; % Initial Condition
T(1,:) = 100; % Left boundary condition
T(m,:) = 25;  % Right boundary condition
rot90(T)

%Construction of M
M1(1:m-2) = 1 +2*lembda;
M2(1:m-3) = -lembda;
M3(1:m-3) = -lembda;
M = diag(M1,0) + diag(M2,1) + diag(M3,-1)

for j = 1:n-1
    K = [-lembda*T(1,j+1); zeros(m-4,1); -lembda*T(m,j+1)]
    T(2:m-1,j+1) = inv(M)*(T(2:m-1,j)-K)
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

% OUTPUT:
% Enter the length of rod:0.05
% Enter the step size for x-axis:0.01
% Enter the upper bound time step:9
% Enter the step size of t-axis:3
% Enter the thermal density:54
% Enter the density:7800
% Enter thermal conductivity:490
% ans =
%    100     0     0     0     0    25
%    100     0     0     0     0    25
%    100     0     0     0     0    25
%    100    20    20    20    20    25
% M =
%     1.8477   -0.4239         0         0
%    -0.4239    1.8477   -0.4239         0
%          0   -0.4239    1.8477   -0.4239
%          0         0   -0.4239    1.8477
% ans =
%   100.0000   59.0430   36.2921   26.8085   24.2434   25.0000
%   100.0000   51.3261   30.6687   23.8761   22.8354   25.0000
%   100.0000   39.4510   24.7919   21.4380   21.4769   25.0000
%   100.0000   20.0000   20.0000   20.0000   20.0000   25.0000

