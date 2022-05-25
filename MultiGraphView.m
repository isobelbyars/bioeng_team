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
Nplots = (size(Ydata,2)-2)/2 + 2;
Nrows = ceil((Nplots-2)/Ncols) + 2;

%% Plotting
MP = figure('Name',MainTitle,'NumberTitle','off');
subplot(Nrows,Ncols,1)

% Find Vi, Xi Max
VXMax = max(Ydata(:,1:end-3),[],'all');

% Plot all basic plots
for i=1:2:(Nplots-2)*2
    subplot(Nrows,Ncols,ceil(i/2))
    CurVi = Ydata(:,i);
    CurXi = Ydata(:,i+1);
    plot(Xdata,CurVi,'-b',Xdata,CurXi,':r')
    xlim(Xaxis)
    ylim([0,VXMax])
    xlabel(Axistitles{1})
    ylabel(Axistitles{2})
    title(sprintf(SubTitles{1},(i-1)/2))
    if i== 1 % Plot legend once
        legend(LegendNames)
    end
end

% Plot Penultimate plot
penultimate_row = (Nrows*Ncols-2*Ncols+1:1:(Nrows-1)*Ncols);
subplot(Nrows,Ncols,penultimate_row)
plot(Xdata,Ydata(:,end-1))
xlim(Xaxis)
xlabel(Axistitles{1})
ylabel(Axistitles{3})
title(SubTitles{2})

% Plot Final plot
final_row = (Nrows*Ncols-Ncols+1:1:Nrows*Ncols);
subplot(Nrows,Ncols,final_row)
plot(Xdata,Ydata(:,end))
xlim(Xaxis)
xlabel(Axistitles{1})
ylabel(Axistitles{4})
title(SubTitles{3})

%Add Title to overall subplot
sgtitle(MainTitle)

%% Saving figure
figWrite(MP,Fname)

end
