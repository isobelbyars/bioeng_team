% Name: Oliver Gallo
% Date: 20220527
% Description: HIV Immune Impairment Model (Q2c) with ODE45. Must be run
% without clearing workspace data.
%
% Inputs:
% 
% Output:
%


%% Perform multiple ODE45 solves
OutputsODE45 = cell(2,Nstrains);
Yxinit = [0.01;0];
yx0 = [Yxinit;0]; % Initial y0 conditions
T0idx = (3:2:Nstrains*2);
Ttimes = [t0y0(T0idx,1);100];
Ts2 = [0;Ttimes(1)]; % Initial Tspan

for i=1:Nstrains
    [Tx,Yx] = ode45(@(t,y) ODESysHivII(t,y,Rc),Ts2,yx0);
    OutputsODE45{1,i} = Tx; OutputsODE45{2,i} = Yx;

    % Break if complete
    if i==Nstrains
        break
    end

    % Set new yx0, Ts2
    Ts2 = [Tx(end);Ttimes(i+1)];
    yx0 = [Yx(end,1:2*i).';Yxinit;Yx(end,end)];
end

%% Concatenate output arrays
ODE45Tout = OutputsODE45(1,:);
ODE45Yout = OutputsODE45(2,:);
TODE45idx = cellfun(@length,ODE45Tout);
TODE45Len = sum(TODE45idx);
TxOut = ODE45Tout{Nstrains};
YxOut = ODE45Yout{Nstrains};

for i=Nstrains-1:-1:1
    T_tmp = ODE45Tout{i};
    TxOut = [T_tmp;TxOut];

    Y_tmp = ODE45Yout{i};
    Y_tmp = [Y_tmp(:,1:end-1),...
        zeros(size(ODE45Yout{i},1),(Nstrains-i)*2),Y_tmp(:,end)];
    YxOut = [Y_tmp;YxOut];

end


%% Compute Viral Load over T
VIdx = (1:2:Nstrains*2);
VLevels = YxOut(:,VIdx);
Vsum = sum(VLevels,2); % Sum across VLevel rows
YxOut = [YxOut,Vsum];

%% Data Export
OutName = 'ODE_45IIModelData.csv';
OutHeader = {'Time [s]','V0','X0'}; % Account for base case
for i=1:2:(Nstrains-1)*2 % Generate Header Data for all Vi, Xi
    OutHeader(i+3) = {sprintf('V%i',i)};
    OutHeader(i+4) = {sprintf('X%i',i)};
end
OutHeader(end+1) = {'Z'};
OutHeader(end+1) = {'V'};
OutData = num2cell([TxOut,YxOut]);
OutFinal = [OutHeader;OutData];
dataWrite(OutFinal,OutName)

%% Visualisations
% Figure titles
MTitle = 'HIV Immune Impairment Model (Q2d) [ODE45]';
STitles = {'Hiv Strain %i','Cross Reactive Immunity',...
    'Total HIV Pathogen Level'};
ATitles = {'Time [s]', 'Level/Magnitude',...
    'CR-Immune Magnitude','Total Viral Level'};
LegNames = {'HIV Pathogen Level',...
    'Strain-Specific Immune Response Magnitude'};
Ncols = 4;
Fname = 'ODE45_HIVIIFig.fig';

MultiGraphView(TxOut,YxOut,MTitle,STitles,ATitles,LegNames,Ncols,tspan,Fname)