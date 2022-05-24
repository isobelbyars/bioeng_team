function dataWrite(OutData,fullName)
% Name: Oliver Gallo
% Date: 20220524
% Description: Helper Function to write data to file and avoid overwriting
%   existing data files. Writes to current directory.
%
% Inputs:
%   OutData: Cell array of content to write to file
%   fullName: File name (including extension)
%   (t0) and end (tf) of interval
% Output:
%   None
%

% Base case of file not existing
    if ~isfile(fullName)
        writecell(OutData,fullName)
    else
        n = 2; % Digit to append to file name
        spltName = strsplit(fullName,'.');
        while true
            newName = sprintf('%s%i.%s',spltName{1},n,spltName{2});
            if ~isfile(newName)
                writecell(OutData,newName)
                break
            end
            n = n+1;
        end
    end
end
