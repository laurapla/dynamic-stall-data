clear; clc;

P = 'C:\Users\laura\Documents\GitHub\Experimental-data\data';

file_CL = [P,'\','NACA0012_CL_steady.mat'];
data_CL = struct2cell(load(file_CL));
data_CL = data_CL{1};
alpha_CLs = data_CL(:,1);
CLs = data_CL(:,2);
figure(1);
plot(alpha_CLs,CLs); xlabel('\alpha [deg]'); ylabel('CL')


file_CD = [P,'\','NACA0012_CD_steady.mat'];
data_CD = struct2cell(load(file_CD));
data_CD = data_CD{1};
alpha_CDs = data_CD(:,1);
CDs = data_CD(:,2);
figure(2);
plot(alpha_CDs,CDs); xlabel('\alpha [deg]'); ylabel('CD')