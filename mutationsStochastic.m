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
h = 0.1; % Time increment (dt)
%
%% Generate plot to show viral load over time
%
% Plot the deterministic viral load
figure(1)
hold on
times = 0:10:90;
num_strains = 1:10; % 1 new strain every 10 time steps, starting at 1
plot(times, num_strains,'LineWidth',1.5);
title("Viral load (Number of strains present)")
xlabel("Time")
ylabel("Number of strains")
%
% Plot the stochastic viral load over 10 instances
for i=1:10
    % Generate viral load over time in one instance
    tspan = [0,100];
    x = HIVStochGen(P,h,tspan(1),tspan(2));
    new_strain_idx = x(1,:)==1; % index of time values where a new mutation arose
    alltimes = x(2,:);
    start_times = alltimes(new_strain_idx); % time values where a new mutation arose
    strain_nums = 1:length(start_times);
    % Complete the plot by adding an initial and final point
    highest_load = strain_nums(length(strain_nums));
    start_times_final = [0, start_times, 100];
    strain_nums_final = [1, strain_nums, highest_load];
    plot(start_times_final, strain_nums_final,'Color','r','LineWidth',1.5,'LineStyle','--');
end
%
% Complete the graph
axis([0,90,0,15])
legend("Deterministic model","Stochastic model")