clear; clc;

k = 0.1; % Reduced frequency

% Get all the *.mat files in the path P
P = 'C:\Users\laura\Documents\GitHub\Experimental-data\data_mat';
S = dir(fullfile(P,'*.mat'));

% Go over all the files in S
for i = 1:numel(S)

    % Get name and path of the file
    name = S(i).name;
    file = fullfile(P,name);

    % Get parameters of the data
    nam = extractBetween(name,1,'.'); % Get name of file (without the *.mat extension)
    parameter = split(nam,'_');
    airfoil = parameter{1}; % Type of airfoil
    coeff = parameter{2}; % Coefficient (CL or CD)
    a0 = parameter{3}; % Mean angle of attack [deg]
    Aalpha = parameter{4}; % Amplitude of oscillation [deg]
    k = strrep(parameter{5},'p','.'); % Reduced frequency


    % Get data from the file
    data = load(file);
% 
%     if contains(name,'CL')
%         alpha_CL = data(:,1);
%         CL = data(:,2);
%         % Save data in *.mat format
%         save([out_P,'\',nam{1}, '.mat'],"alpha_CL","CL")
%         clear alpha_CL CL;
%     else
%         alpha_CD = data(:,1);
%         CD = data(:,2);
%         % Save data in *.mat format
%         save([out_P,'\',nam{1}, '.mat'],"alpha_CD","CD")
%         clear alpha_CD CD;
%     end

end