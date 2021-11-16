%% E create a combined observation file with met, preicp and albedo in hourly step

% set up
close all
clear all
addpath('D:\FireandIce\function')
savedir = 'D:\FireandIce\data_process\ice_aws\'
figdir = 'D:\FireandIce\fig\met_processing\'
%% Load data
load('D:\FireandIce\data_process\ice_aws\iceAWS_1hr.mat', 'iceAWS', 'iceAWSt')
load('D:\FireandIce\data_process\ice_aws\iceAWS_albedo_dailyfrommidday_filled.mat', 'albhr_calc_todaily_fill', 'albhr_calc_todaily_t')
iceAWSt = iceAWSt-hours(2);

p_corr = importprecip('D:\FireandIce\data_process\moraine_aws\precip_correctedforUndercatch\Athabasca_Moraine_Precip_Corrected_Caroline_20210315.csv', 2, 45697);
pcorrt = table2array(p_corr(:, 1));
pcorr = table2array(p_corr(:, 5));
clear p_corr

load('D:\FireandIce\data_process\moraine_aws\moraineAWSprecip_1hr.mat')
plot(pcorrt, pcorr); hold on; plot(morAWS_precip_time, morAWS_precip)

%% Assemble all the data in one file
T = timetable(albhr_calc_todaily_t,albhr_calc_todaily_fill);
TT = retime(T, iceAWSt, 'linear');
alb = table2array(TT);
alb(alb>=0.9) = 0.9;

T = timetable(pcorrt, pcorr);
TT = retime(T, iceAWSt, 'fillwithconstant');
precip = table2array(TT);
plot(iceAWSt,precip); hold on

% infil data for sept-jul (not corrected by andre)
t1 = find(iceAWSt == '01-Jul-2015 00:00')
a = find(iceAWSt == '13-Sep-2015 14:00')
b = find(iceAWSt == '1-Jul-2016 00:00')
precip(1:t1)= precip(a:b);
precip(isnan(precip))=0;
data = [iceAWS precip alb];
 %% Measured MET, Measured Albedo% (Ta, RH, U, QSi, Qli, P, albedo)

% Export as a CRHM observation file
t = datevec(iceAWSt);
t = t(:, 1:5); % keep only the first column as we don't need seconds in the CRHM obs format


obs = [t(12:end, :) data(12:end, :)];                  
headerlines = {'Obs file for iceAWs with albedo and precip';
't	1 (C)';
'rh	1 (%)';
'u	1 (m/s)';
'Qsi	1 (W/m2)';
'Qli	1 (W/m2)';
'p	1 (mm)';
'glacier_Albedo_obs	1';	
'$ea ea(t, rh)';																												
'################	t.1		rh.1	u.1	Qsi.1	Qli.1	p.1	glacier_Albedo_obs.1'}
filepath = strcat(savedir, 'iceAWS_TRHUQsiQliPalb.obs')
fid = fopen(filepath, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(filepath, obs, '-append', 'delimiter', '\t');  

%% Measured MET, mod Albedo (alb = 0.3)
modalb = data(:, 7);
modalb(modalb<=0.3)= 0.3 % change all values of high albedo to standadr ice albeod

plot(iceAWSt, modalb); hold on
plot(iceAWSt,  data(:, 7))

% Export as a CRHM observation file
t = datevec(iceAWSt);
t = t(:, 1:5); % keep only the first column as we don't need seconds in the CRHM obs format

obs_modalb = [t(12:end, :) data(12:end, 1:6) modalb(12:end)];                  
headerlines = {'Obs file for iceAWs with albedo and precip';
't	1 (C)';
'rh	1 (%)';
'u	1 (m/s)';
'Qsi	1 (W/m2)';
'Qli	1 (W/m2)';
'p	1 (mm)';
'glacier_Albedo_obs	1';	
'$ea ea(t, rh)';																												
'################	t.1		rh.1	u.1	Qsi.1	Qli.1	p.1	glacier_Albedo_obs.1'}
filepath = strcat(savedir, 'iceAWS_TRHUQsiQliPalb_modAlb.obs')
fid = fopen(filepath, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(filepath, obs_modalb, '-append', 'delimiter', '\t');  

%% Modified Radiationm, measured albedo
load('D:\FireandIce\output\radiation_modification\ModifiedSW_LWrad_removingsmokeimpact.mat', 'LWadj', 'SWadj')
t = datevec(iceAWSt);
t = t(:, 1:5); % keep only the first column as we don't need seconds in the CRHM obs format

obs_modrad= [t(12:end, :) data(12:end, 1:3) SWadj(12:end) LWadj(12:end) data(12:end, 6:7)];                  
headerlines = {'Obs file for iceAWs with albedo and precip';
't	1 (C)';
'rh	1 (%)';
'u	1 (m/s)';
'Qsi	1 (W/m2)';
'Qli	1 (W/m2)';
'p	1 (mm)';
'glacier_Albedo_obs	1';	
'$ea ea(t, rh)';																												
'################	t.1		rh.1	u.1	Qsi.1	Qli.1	p.1	glacier_Albedo_obs.1'}
filepath = strcat(savedir, 'iceAWS_TRHUQsiQliPalb_modRad.obs')
fid = fopen(filepath, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(filepath, obs_modrad, '-append', 'delimiter', '\t');  

%% Modified Radiationm, measured albedo
t = datevec(iceAWSt);
t = t(:, 1:5); % keep only the first column as we don't need seconds in the CRHM obs format

obs_modrad_modalb= [t(12:end, :) data(12:end, 1:3) SWadj(12:end) LWadj(12:end) data(12:end, 6)  modalb(12:end)];                  
headerlines = {'Obs file for iceAWs with albedo and precip';
't	1 (C)';
'rh	1 (%)';
'u	1 (m/s)';
'Qsi	1 (W/m2)';
'Qli	1 (W/m2)';
'p	1 (mm)';
'glacier_Albedo_obs	1';	
'$ea ea(t, rh)';																												
'################	t.1		rh.1	u.1	Qsi.1	Qli.1	p.1	glacier_Albedo_obs.1'}
filepath = strcat(savedir, 'iceAWS_TRHUQsiQliPalb_modRad_modAlb.obs')
fid = fopen(filepath, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(filepath, obs_modrad_modalb, '-append', 'delimiter', '\t');  
