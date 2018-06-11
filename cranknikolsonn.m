close all;
clear all;
format compact
l=input('enter the length of the rod:');
dx=input('enter the stepsize on x-axis:');
x=0:dx:l
m=length(x)
ub=input('enter the upper bound of time:');
dt=input('enter the stepsize on t-axis:');
t=0:dt:ub
n=length(t)
k=input('enter the thermal conductivity of rod:');
rho=input('enter density of rod:');
c=input('enter specific heat of rod:');
alpha=k/(rho*c)
lambda=alpha*(dt/(dx*dx))
T=zeros(m,n);
T(:,1)=20;
T(1,:)=100;
T(m,:)=25;
rot90(T)
LM1(1:m-2)=2+(2*lambda);
LM2(1:m-3)=-lambda;
LM3(1:m-3)=-lambda;
LM=diag(LM1,0)+diag(LM2,-1)+diag(LM3,1);
RM1(1:m-2)=2-(2*lambda);
RM2(1:m-3)=lambda;
RM3(1:m-3)=lambda;
RM=diag(RM1,0)+diag(RM2,-1)+diag(RM3,1);
for j=1:n-1
    k=[lambda*T(1,j)+lambda*T(1,j+1);zeros(m-4,1);lambda*T(m,j)+lambda*T(m,j+1)];
    T(2:m-1,j+1)=inv(LM)*(RM*T(2:m-1,j)+k);
end
rot90(T)
subplot(2,2,1)
plot(T)
xlabel('different points of rod')
ylabel('temperature')
subplot(2,2,2)
surf(T)
xlabel('different time interval')
ylabel('different points on rod')
zlabel('tempereture')
subplot(2,2,3)
contour(T)
xlabel('different time interval')
ylabel('different points on rod')
