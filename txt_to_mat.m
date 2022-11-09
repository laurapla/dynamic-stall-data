clear; clc;

% Get all the *.txt files in the path P
P = 'C:\Users\laura\Documents\GitHub\Experimental-data\data_txt';
S = dir(fullfile(P,'*.txt'));

% Path to save *.mat files
out_P = 'C:\Users\laura\Documents\GitHub\Experimental-data\data_mat';

% Go over all the files in S
for k = 1:numel(S)

    % Get name and path of the file
    name = S(k).name;
    file = fullfile(P,name);

    % Get data from the file
    data = load(file);

    % Get name of *.mat file
    nam = extractBetween(name,1,'.');

    if contains(name,'CL')
        alpha_CL = data(:,1);
        CL = data(:,2);
        % Save data in *.mat format
        save([out_P,'\',nam{1}, '.mat'],"alpha_CL","CL")
        clear alpha_CL CL;
    else
        alpha_CD = data(:,1);
        CD = data(:,2);
        % Save data in *.mat format
        save([out_P,'\',nam{1}, '.mat'],"alpha_CD","CD")
        clear alpha_CD CD;
    end

end