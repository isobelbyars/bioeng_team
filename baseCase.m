%
%% Solution to question 2a of team assignment
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
%% Produce a phase portrait
%
% Set up grid
x = linspace(0,4,30); % Magnitude of immune response
v = linspace(0,20,30); % Level of viral pathogen in bloodstream
[X,V] = meshgrid(x,v);
%
% Rates of change
xdot = c*V - b*X;
vdot = r*V - p*V.*X;
%
% Show phase portrait
%
figure(1)
hold on
quiver(X,V,xdot,vdot);
title("Phase portrait for viral pathogen levels and magnitude of immune response")
xlabel("Magnitude of immune response (x)")
ylabel("Level of viral pathogen in bloodstream (v)")
axis([0,4,0,20])
%
% Add trajectory
xstart = [0];
vstart = [0.01];
streamline(X,V,xdot,vdot,xstart,vstart);
%
% Vertical nullcline at v=x
null1_x = x;
null1_v = x;
% Horizontal nullcines at v=0 and x=1.25
null2_x = x;
null2_v = zeros(1,30);
null3_x = 1.25*ones(1,30);
null3_v = v;
% Add nullclines to plot
plot(null1_x,null1_v,'Color', 'r');
plot(null2_x,null2_v,'Color', 'r');
plot(null3_x,null3_v,'Color', 'r');
% 
% Critical points are present at the intersection of vertical  
% and horizontal nullclines.
% These points are (0,0) and (1.25,1.25) for present values r p c b
crit_x = [0,1.25];
crit_y = [0,1.25];
scatter(crit_x, crit_y, 'Marker', 'o','MarkerEdgeColor','m', 'MarkerFaceColor','m');
%
%% Determine stability of the critical points
%
% Represent xdot and ydot as symbolic variables
syms x_var v_var
xdot_var = c*v_var - b*x_var;
vdot_var = r*v_var - p*v_var.*x_var;
% 
% Find eigenvalues of the associated Jacobian matrix
j = jacobian([xdot_var,vdot_var],[x_var,v_var]);
j1 = subs(j,[x_var,v_var],[crit_x(1),crit_y(1)]);
eig1 = eig(j1); % Current settings gives eigs -0.1,2.5, making
% (0,0) an unstable (saddle) critical point
%
j2 = subs(j,[x_var,v_var],[crit_x(2),crit_y(2)]);
eig2 = eig(j2); % Eigenvalues associated with (1.25,1.25) 
fprintf("The eigenvalues associated with critical point (1.25,1.25) are \n%f + %fi and %f + %fi\n",real(eig2(1)),imag(eig2(1)),real(eig2(2)),imag(eig2(2)))


