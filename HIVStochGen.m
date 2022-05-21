function strains=HIVStochGen(P,h,t0,tf)
% Name: Oliver Gallo
% Date: 20220521
% Description: Stochastic Generation of New HIV Strains
%
% Inputs:
%   P: Probablity of new strain arising
%   h: Time increment/step size (dt). Same as h for Euler Method
%   t0: Start time
%   tf: End time
% Output:
%   strains: 2 row vector.
%       Row 1: Logical 0,1 indicating if new strain arises
%       Row 2: Time value if new strain has arisen. 0 otherwise
%

    % Constants
    Pdt = P*h; % Probablity of new strain arising over each dt increment
    T = (t0:h:tf); % T-val vector
    Nt = length(T); % Number of time samples

    %% Stochastic Modelling of Strains arrising
    strains = zeros(2,Nt);
    for i=1:Nt
        if binornd(1,Pdt) % Bernouli randNum. 1 = new strain
            strains(1,i) = 1;
            strains(2,i) = T(i); % Record start time for new strain
        end
    end
end