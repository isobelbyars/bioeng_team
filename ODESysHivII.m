function dydt=ODESysHivII(~,y,Rc)
% Name: Oliver Gallo
% Date: 20220524
% Description: Custom Encoding of HIV Immune Impairment ODE System
%
% Inputs:
%   t: Current Time
%   y: Current Viral Concentration vector [Vn;Xn;...;Z]Length is 2*Strain
%   count + 1 (Z)
%   Rc: Rate Constant vector [r;p;q;c;k;b;u]
% Output:
%   dydt: ODE Column Vector
%

    % Rate Constants
    r = Rc(1);p = Rc(2);q = Rc(3);c = Rc(4);k = Rc(5);b = Rc(6);u = Rc(7);

    dydt = zeros(length(y),1);

    Z = y(end);

    % Define V as sum of all Vi
    idxVi = (1:2:length(y)-2); % Indexes of Vi in y
    V = sum(y(idxVi));

    % Generate all Vi, Xi required
    for i=1:2:length(y)-1
        Vi = y(i);Xi = y(i+1);
        dydt(i) = r*Vi - p*Vi*Xi - q*Vi*Z;
        dydt(i+1) = c*Vi - b*Xi - u*V*Xi;
    end
    

    % Define Z equation
    dydt(end) = k*V - b*Z - u*V*Z;

end