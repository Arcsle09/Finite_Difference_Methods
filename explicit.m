close all;
clear all;
clc;

k = input('Enter the thermal density:');
rho = input('Enter the density:');
c = input('Enter thermal conductivity:');
alpha = k/(rho*c);

l = input('Enter the length of rod:');
dx = input('Enter the step size for x-axis:');
x = 0:dx:l;

tl = input('Enter the last time step:');
dt = input('Enter the step size of t-axis:');
t = 0:dt:tl;
lambda = (alpha*dt)/(dx*dx);

m = length(x);
n = length(t);

T = zeros(m,n);

T(:,1) = 20; % Initial Condition
T(1,:) = 100; % Left boundary condition
T(m,:) = 25;  % Right boundary condition

for j = 1:n-1
    for i = 2:m-1
        T(i,j+1) = T(i,j) + lambda*(T(i+1,j)- 2*T(i,j) + T(i-1,j));
    end
end
fprintf('The solution is: %f',T(i,j+1));

subplot(221)
plot(T)
xlabel('Different points of rod');
ylabel('Temperature values');
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
% Enter the thermal density:54
% Enter the density:7800
% Enter thermal conductivity:490
% Enter the length of rod:0.05
% Enter the step size for x-axis:0.01
% Enter the last time step:9
% Enter the step size of t-axis:3
% The solution is: 22.871925>> 
