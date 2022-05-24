function figWrite(OutFig,fullName)
% Name: Oliver Gallo
% Date: 20220524
% Description: Helper Function to write figure to file and avoid overwriting
%   existing data files. Writes to current directory.
%
% Inputs:
%   OutFig: Figure to write to array
%   fullName: File name (including extension)
%   (t0) and end (tf) of interval
% Output:
%   None
%

% Base case of file not existing
    if ~isfile(fullName)
        saveas(OutFig,fullName)
    else
        n = 2; % Digit to append to file name
        spltName = strsplit(fullName,'.');
        while true
            newName = sprintf('%s%i.%s',spltName{1},n,spltName{2});
            if ~isfile(newName)
                saveas(OutFig,newName)
                break
            end
        end
    end
end
