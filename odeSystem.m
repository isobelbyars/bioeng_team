function dydt=odeSystem(t,y,r,p,c,b)

% y(1) = x, y(2) = v
% similarly, dydt(1) = dxdt and dydt(2) = dvdt

dydt=zeros(2,1);
dydt(1)=c*y(2)-b*y(1);
dydt(2)=r*y(2)-p*y(2)*y(1);

end