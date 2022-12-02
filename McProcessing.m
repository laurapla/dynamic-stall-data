% University of California, Irvine - Fall 2021
% Laura Pla Olea - lplaolea@uci.edu

close all; clear; clc;

%% Inputs

% Data to process
airfoil = 'NACA0012';
coefficient = 'CL'; % Force coefficient (CL or CD)
patt = {airfoil; coefficient; '_t_'};

% File path
P = 'C:\Users\laura\Documents\GitHub\dynamic-stall-data\data_mat';

%% Getting data

% Get all the *.mat files in the path P
S = dir(fullfile(P,'*.mat'));

% Check which files contain the airfoil and the coefficient that we
% want to look at
ce = {S.name}.';
fun = @(s)contains(ce,s);
out = cellfun(fun,patt,'UniformOutput',false);
idx = all(horzcat(out{:}),2);

% Get only the files that we want
cell_array = ce(idx);
N = numel(cell_array);

%% Processing data

a0 = cell(N,1);
Aalpha = cell(N,1);
k = cell(N,1);
mean_val = zeros(N,1);

% Go over all the files in S
for i = 1:N

    % Get name of the file
    name = [cell_array{i}];

    % Get path of the file
    file = fullfile(P,name);

    % Get parameters of the data
    nam = extractBetween(name,1,'.'); % Get name of file (without the *.mat extension)
    nam = erase(nam,'_t'); % Erase the '_t' from the temporal files
    parameter = split(nam,'_');
    a0{i} = parameter{3}; % Mean angle of attack [deg]
    Aalpha{i} = parameter{4}; % Amplitude of oscillation [deg]
    k{i} = strrep(parameter{5},'p','.'); % Reduced frequency

    % Get data from the file
    data = load(file);
    if strcmp(coefficient,'CL')
        alpha = data.alpha_CL;
        coeff = data.CL;
    else
        alpha = data.alpha_CD;
        coeff = data.CD;
    end

    % Calculate the mean value of the coefficient
    mean_val(i) = mean(coeff);

end

% Save the parameters and the mean in a table
T = [table(a0) table(Aalpha) table(k) table(mean_val)];

%% Plotting data

line_width = 1.7;
font_lgd = 10;
font_labels = 14;

symbols = {'o','+','*','.','x','_','|','<','>','^','s','d','p','h'};
Okabe_Ito = [0.902 0.624 0; 0.337 0.737 0.914; 0 0.62 0.451;
    0.941 0.894 0.259; 0 0.447 0.698; 0.835 0.369 0; 0.8 0.475 0.655];

figure(1);
colororder(Okabe_Ito)

% Steady data
if strcmp(coefficient,'CL')
    load(fullfile(P,"NACA0012_CL_steady.mat"));
    plot(alpha_CLs,CLs,'k','LineWidth',line_width);
    ylabel('C_{L}');
else
    load(fullfile(P,"NACA0012_CD_steady.mat"));
    plot(alpha_CDs,CDs,'k','LineWidth',line_width);
    ylabel('C_{D}');
end
xlabel('\alpha (deg)'); hold on;

% Initialize legend
Legend = cell(N+1,1);
Legend{1} = 'Steady';

% Mean values of dynamic stall
for i = 1:N
    
    symbol_id = i;
    while symbol_id>numel(symbols)
        symbol_id = symbol_id-numel(symbols);
    end

    % Plot the value
    scatter(str2double(a0(i)),mean_val(i),symbols{symbol_id},'LineWidth',line_width);

    % Legend string of the current point
    Legend{i+1} = strcat('$\alpha^{*}=$', a0{i},' $^{\circ}$, $A_{\alpha}=$', Aalpha{i}, '$^{\circ}$, k=', k{i});
end

legend(Legend,'Location','bestoutside','interpreter','latex','FontSize',font_lgd)
grid on;