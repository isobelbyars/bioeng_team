function MultiGraphView(Xdata,Ydata,MainTitle,SubTitles,Axistitles, ...
    LegendNames,Ncols,Xaxis,Fname)
% Name: Oliver Gallo
% Date: 20220524
% Description: Helper Function to plot multiple graphs for HIV Evolutionary
%   Dynamics Team Assignment. Displays graphs to user & saves to .fig file.
%   Assuming final graph is to be given solo row. All other graphs to be
%   plotted as 2.
%
% Inputs:
%   Xdata: X data. Constant for all Plots. Column vector.
%   Ydata: Y data. Column vector of all Y data. Column vector.
%   MainTitle: Title for entire plot.
%   SubTitles: Titles for subplots. 2-cell array. First is for Vi,Xi plots,
%   second is for Z plot
%   Axistitles: Cell array of Axis Titles. X Axis, Y axis (Vi,Xi plots), Y
%   axis (Z plot).
%   LegendNames: Names for legends of Xi,Vi plots as cell array.
%   Nc: Number of columns in subplot layout.
%   xaxis: X Axis lim.
%   Fname: Name to save figure under.
% Output:
%   None
%

% Determine number of rows required
Nplots = (size(Ydata,2)-1)/2 + 1;
Nrows = ceil(Nplots/Ncols) + 1; % +1 accounts for extra row for final plot

%% Plotting
MP = figure('Name',MainTitle,'NumberTitle','off');
subplot(Nrows,Ncols,1)
% Plot all basic plots

for i=1:2:(Nplots-1)*2
    subplot(Nrows,Ncols,ceil(i/2))
    CurVi = Ydata(:,i);
    CurXi = Ydata(:,i+1);
    plot(Xdata,CurVi,'-b',Xdata,CurXi,':r')
    xlim(Xaxis)
    xlabel(Axistitles{1})
    ylabel(Axistitles{2})
    title(sprintf(SubTitles{1},(i-1)/2))
    if i== 1 % Plot legend once
        legend(LegendNames)
    end
end

% Plot final plot
final_row = (Nrows*Ncols-Ncols+1:1:Nrows*Ncols);
subplot(Nrows,Ncols,final_row)
plot(Xdata,Ydata(:,end))
xlim(Xaxis)
xlabel(Axistitles{1})
ylabel(Axistitles{3})
title(SubTitles{2})

%Add Title to overall subplot
sgtitle(MainTitle)

%% Saving figure
figWrite(MP,Fname)

end
