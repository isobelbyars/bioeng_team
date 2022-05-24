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
time_step = 1; % Length of each "bin"
viral_load_len = tspan(2)/time_step +1;
viral_load_times = 0:time_step:tspan(2);
viral_load = zeros(1,viral_load_len); 
%
% Generate and plot all systems of ODEs
for i=0:10:90
    % Get ODE for current strain
    tspan(1) = i;
    [t,y]=ode45(@(t,y) odeSystem(t,y,r,p,c,b),tspan,y0);
    %
    % Graph the result
    subplot(2,5,i/10+1)
    hold on
    plot(t,y(:,1),'LineWidth',1.5,'Color','b') %immune response
    plot(t,y(:,2),'LineWidth',1.5,'Color','r') %pathogen
    xlabel('Time')
    ylabel('Magnitude')
    ylim([0 inf])
    xlim([0,100])
    title(sprintf("Response to strain %d",i/10+1))
    %
    % Save cumulative total of viral load
    iter = i/10+1; % number of iterations
    pathogen_lev = y(:,2);
    for j=viral_load_times
        idx = floor(t) == j; % Rounding down time to nearest integer
        cur_pathogen = pathogen_lev(idx);
        if ~isempty(cur_pathogen)
            viral_load(j+1) = viral_load(j+1) + mean(cur_pathogen);
        else
            viral_load(j+1) = viral_load(j+1) + 0;
        end
    end
    %
    % Set legend once
    if i==0
        legend('magnitude of immune response','level of viral pathogen in bloodstream','Position',[0.07 0.8 0.1 0.1])
    %
    end
end
% Set title
sgtitle('Pathogen level and immune response over time (with mutations)')
%
%
%% Generate plots to show viral load over time
%
% Level of viral pathogen
figure(2)
subplot(2,1,1)
plot(viral_load_times,viral_load)
title("Viral load (Level of viral pathogen)")
xlabel("Time")
ylabel("Level of pathogen")
%
% Number of strains
figure(2)
num_strains = ceil(viral_load_times/10); % Dependent on 1 new strain every 10 time steps
subplot(2,1,2)
plot(viral_load_times, num_strains);
title("Viral load (Number of strains present)")
xlabel("Time")
ylabel("Number of strains")
%