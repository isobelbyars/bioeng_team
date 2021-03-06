function [Tout,Yout]=eulerMethod(func,tspan,t0y0,h)
% Name: Oliver Gallo
% Date: 20220523
% Description: Implementation of Euler's Method with variable func t0
%
% Inputs:
%   func: Function(s) to solve, as function handle.
%   tspan: Time span/Interval of integration. 2-element vector of start 
%   (t0) and end (tf) of interval
%   y0: Array of rows of initial value and time at which it occurs 
%       [t0,y0;t1,y1;...;tn,yn]
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
Nfunc = length(t0y0); % Number of equations
Yout = zeros(Nfunc,N+1);

% Determine intial Yout
for i=1:Nfunc
    tiyi = t0y0(i,:);
    ti = tiyi(1);yi = tiyi(2);
    % Index of Yi in Yout via equivalent Ti index
    Yout(i,Tout==ti) = yi;
end

% Main loop through each step
for i=1:N
    Yn = Yout(:,i); % Get current Y vals
    Tn = Tout(i); % Get current T val

    % Apply Euler's Method to Funcs & record result
    result = abs(Yn + (func(Tn,Yn).*h)); % Required as Results >=0
    % Check if next cells have existing value
    if any(Yout(:,i+1))
        % If yes, only overwite cells with 0
        % Needed to avoid overwriting new ODE start values
        idx = Yout(:,i+1)==0;
        Yout(idx,i+1) = result(idx);
    else
        Yout(:,i+1) = result;
    end
end

Tout = Tout.';
Yout = Yout.';

end