function tableOut = importDiscordData(filename, dataLines)
%IMPORTFILE Import data from a text file
%  CHANNELSMARTCONTRACT = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  CHANNELSMARTCONTRACT = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  channelsmartcontract = importfile("C:\Work\discordActivityAnalysis\channel-smart-contract.csv", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 14-Mar-2023 12:14:28

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 6);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Author", "Date", "Content", "Var5", "Var6"];
opts.SelectedVariableNames = ["Author", "Date", "Content"];
opts.VariableTypes = ["string", "string", "datetime", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Content", "Var5", "Var6"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Author", "Content", "Var5", "Var6"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Date", "InputFormat", "MM/dd/yyyy hh:mm aa");

% Import the data
dataTable = readtable(filename, opts);
dataTable.Date.Format = 'MM/dd/yyyy';

channelTable = table('size', [height(dataTable),1], 'VariableTypes',{'string'}, 'VariableNames',{'Channel'});
channelTable{:,1} = filename;
tableOut = [dataTable channelTable];
end