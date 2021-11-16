%% C - Exporting modified radiation as observation file
% to run imulation in CRHM

%% Setup
close all
clear all

addpath('D:\3_FireandIce\e_function')
savedir = 'D:\3_FireandIce\h_output\d_radiation_modification\'
figdir = 'D:\3_FireandIce\f_fig\fig_radiation_modification\'

%% Import observed dataset
% from the hourly iceAWS data
load('D:\3_FireandIce\b_data_process\ice_aws\iceAWS_1hr.mat')
iceAWS_modrad = iceAWS;

%% import modified rad
% from B_adjustingSW_LWusingtransmissivity script
load('D:\3_FireandIce\h_output\d_radiation_modification\ModifiedSW_LWrad_removingsmokeimpact.mat')
iceAWS_modrad(:, 4)=SWadj;
iceAWS_modrad(:, 5)=LWadj;

%% Export as a CRHM observation file
t = datevec(iceAWSt-hours(2));
t = t(11:end,  1:5); % keep only the first column as we don't need seconds in the CRHM obs format
% change the hours to 1AM to fit with CRHM

iceAWS_modrad = [t iceAWS_modrad(11:end, :)]; % starting at 1am, as needed by CRHM                 
headerlines = {'Obs file from for Athabasca ice station, hourly, with mod radiation to remove smoke';
't	1 (C)';
'rh	1 (%)';
'u	1 (m/s)';
'Qsi	1 (W/m2)';
'Qli	1 (W/m2)';
'$ea ea(t, rh)';
'################	t.1	rh.1	u.1	Qsi.1	Qli.1'}
filepath = strcat(savedir, 'iceAWS_ModRad.obs')
fid = fopen(filepath, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(filepath, iceAWS_modrad , '-append', 'delimiter', '\t');  

