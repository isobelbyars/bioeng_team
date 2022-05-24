% Name: Oliver Gallo
% Date: 20220524
% Description: HIV Immune Impairment Model (Q2c)
%
% Inputs:
% 
% Output:
%

clear
close all
clc

%% Set Parameters from file
PFile = load('Q2dVar.mat');
SetNum = 1;


switch SetNum
    case 1
        PSet = num2cell(PFile.Set1);
    case 2
        PSet = num2cell(PFile.Set2);
    case 3
        PSet = num2cell(PFile.Set3);
end

[r,p,q,c,k,b,u,P,tf] = PSet{:};
h = 0.01; % Step size

% Assign Related Paramaters
Pdt = P*h; % Probablity of new strain arising over each dt increment
t0 = 0;tspan = [t0,tf];
Vn_start = 0.01; % Viral load start value
T = (t0:h:tf); % T-val vector
Nt = length(T); % Number of time samples
Rc = [r;p;q;c;k;b;u]; % ODE System Rate Constant Vector

%% Generate Stochastic Mutant HIV Strain Data
Gen_HIVStrains = HIVStochGen(P,h,t0,tf);
HIVStrains = Gen_HIVStrains(:,Gen_HIVStrains(1,:)~=0); % Only keep generated strains
Nstrains = size(HIVStrains,2) + 1; % +1 accounts for base strain

%% Solve ODEs for HIV strains
% Create Array of initial conditions
baseInit = [0,Vn_start;0,0];
VmutationsInit = [HIVStrains(2,:);Vn_start*ones(1,Nstrains-1)].'; % V start only
mutationsInit = zeros(Nstrains-1,2);
for i=1:2:(Nstrains-1)*2 % Generate Xi starting values of 0
    mutationsInit(i,:) = VmutationsInit(ceil(i/2),:); % Current Vi start val
    mutationsInit(i+1,:) = [0,0]; % Current Xi start val
end
CRInit = [0,0];
t0y0 = [baseInit;mutationsInit;CRInit];

[Tout,Yout] = eulerMethod(@(t,y) ODESysHivII(t,y,Rc),tspan,t0y0,h);

%% Compute Viral Load over T
VIdx = (1:2:Nstrains*2);
VLevels = Yout(:,VIdx);
Vsum = sum(VLevels,2); % Sum across VLevel rows
Yout = [Yout,Vsum];

%% Data Export
OutName = 'IIModelData.csv';
OutHeader = {'Time [s]','V0','X0'}; % Account for base case
for i=1:2:(Nstrains-1)*2 % Generate Header Data for all Vi, Xi
    OutHeader(i+3) = {sprintf('V%i',i)};
    OutHeader(i+4) = {sprintf('X%i',i)};
end
OutHeader(end+1) = {'Z'};
OutHeader(end+1) = {'V'};
OutData = num2cell([Tout,Yout]);
OutFinal = [OutHeader;OutData];
dataWrite(OutFinal,OutName)

%% Visualisations
% Figure titles
MTitle = 'HIV Immune Impairment Model (Q2c)';
STitles = {'Hiv Strain %i','Cross Reactive Immunity',...
    'Total HIV Pathogen Level'};
ATitles = {'Time [s]', 'Level/Magnitude',...
    'CR-Immune Magnitude','Total Viral Level'};
LegNames = {'HIV Pathogen Level',...
    'Strain-Specific Immune Response Magnitude'};
Ncols = 4;
Fname = 'HIVIIFig.fig';

MultiGraphView(Tout,Yout,MTitle,STitles,ATitles,LegNames,Ncols,tspan,Fname)