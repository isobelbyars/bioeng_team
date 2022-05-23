function [Tout,Yout]=OLDeulerMethod(func,tspan,y0,h)
% Name: Oliver Gallo
% Date: 20220518
% Description: Implementation of Euler's Method
%
% Inputs:
%   func: Function(s) to solve, as function handle.
%   tspan: Time span/Interval of integration. 2-element vector of start 
%   (t0) and end (tf) of interval
%   y0: Initial conditions of function(s) at t0.
%   h: Step size
% Output:
%   [Tout,Yout]:
%       Tout: Column vector of T-values from t0 to tf in step size of h
%       Yout: Column vector of Y-values from y0 to yf. Order
%       corresponds to func Column order
%

% Basic variables
t0 = tspan(1); tf = tspan(2);
Tout = (t0:h:tf);
N = length(Tout) - 1; % Number of steps
Nfunc = length(y0); % Number of equations
Yout = [y0,zeros(Nfunc,N)];

% Main loop through each step
for i=1:N
    Yn = Yout(:,i); % Get current Y vals
    Tn = Tout(i); % Get current T val

    % Apply Euler's Method to Funcs & record result
    Yout(:,i+1) = Yn + (func(Tn,Yn).*h);
end

Tout = Tout.';
Yout = Yout.';

end