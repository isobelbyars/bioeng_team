%
%% Solution to Part 2b of team assignment - Mutations & 
% Strain-Specific Immunity
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
P = 0.1;
%
%% Generate plot to demonstrate how new strains mutate and develop
% Time span
tspan = [0,100];
% Initial conditions
y0 = [0,0.01];
% Total viral load
viral_load = zeros(261,10); % The first call to ode45 generates 261 points
%
% Generate and plot all systems of ODEs
for i=0:10:90
    % Get ODE for current strain
    tspan(1) = i;
    [t,y]=ode45(@(t,y) odeSystem(t,y,r,p,c,b),tspan,y0);
    %
    % Graph the result
    disp(i/10+1)
    subplot(2,5,i/10+1)
    hold on
    plot(t,y(:,1),'LineWidth',1.5,'Color','b')
    plot(t,y(:,2),'LineWidth',1.5,'Color','r')
    xlabel('Time')
    ylabel('Magnitude')
    ylim([0 inf])
    xlim([0,100])
    title(sprintf("Response to strain %d",i/10+1))
    %
    % Save cumulative total of viral load
    iter = i/10+1; % number of iterations
    if length(y) < 261
        y_new = zeros(261,1);
        start_idx = 261 - length(y) +1;
        disp(length(y_new(start_idx:261)))
        y_new(start_idx:261) = y(:,2);

        viral_load(:,iter) = y_new;
    else
        viral_load(:,iter) = y(:,2);
        viral_load_times = t;
    end


    % Set legend once
    if i==0
        legend('magnitude of immune response','level of viral pathogen in bloodstream','Position',[0.07 0.8 0.1 0.1])

    end
% Set title
sgtitle('Pathogen level and immune response over time (with mutations)')
%
end
%
%% Generate plot to show viral load over time
%
% Level of viral pathogen
% TODO: t vectors produced by ode45 are not divided up consistently
% so this graph is incorrect!!
figure(2)
test = sum(viral_load, 2)
subplot(2,1,1)
plot(viral_load_times,test)
title("Level of viral pathogen (total for all strains)")
xlabel("Time")
ylabel("Level of pathogen")

% Number of strains
num_strains = ceil(viral_load_times/10); % Dependent on 1 new strain every 10 time steps
subplot(2,1,2)
plot(viral_load_times, num_strains);
title("Number of HIV strains present")
xlabel("Time")
ylabel("Number of strains")


