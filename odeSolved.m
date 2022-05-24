%
%% Visualisation of pathogen level and immune response over time
%
clc
clear
close all
%
% Constants
r = 2.5;
p = 2;
c = 0.1;
b = 0.1;
%
% Time span
tspan = [0,100];
% Initial conditions
y0 = [0,0.01];
% Define system of ODEs
[t,y]=ode45(@(t,y) odeSystem(t,y,r,p,c,b),tspan,y0);
%
% Graph the result
figure(1)
hold on
plot(t,y(:,1),'LineWidth',1.5,'Color','b')
plot(t,y(:,2),'LineWidth',1.5,'Color','r')
xlabel('Time')
ylabel('Magnitude')
ylim([0 inf])
title('Pathogen level and immune response over time')
legend('magnitude of immune response','level of viral pathogen in bloodstream')
%
% Graph viral load on its own
figure(2)
hold on
plot(t,y(:,2),'LineWidth',1.5)
xlabel('Time')
ylabel('Viral load')
title('Viral load')

