%% Compiling seasonal average 
% for years 2015-2020
% for each MET variable, compile the mean for the study period

%% Setup
close all
clear all

addpath('D:\3_FireandIce\e_function')
savedir = 'D:\3_FireandIce\h_output\c_met_analysis\' % for data processed
figdir = 'D:\3_FireandIce\f_fig\fig_met_analysis\'

%% Load data
load('D:\3_FireandIce\b_data_process\ice_aws\iceAWS_1hr.mat')
load('Athabasca_Moraine_Precip_Corrected_Caroline_20210315.mat')
%% Join the two datasets
t1 = find(iceAWSt == tp(1));
t2 = find(iceAWSt== tp(end) );

t = iceAWSt(t1:t2);
d1 = iceAWS(t1:t2, :);
d2 = p(1:end);
moraineAWS = [d1 d2];
clear d1 d2 t1 t2

%% Find start and end of eahc period
tvec = datevec(t);
tstart = find(tvec(:, 2)==7 & tvec(:, 3)==1 & tvec(:, 4) == 0);
t(tstart) % making sure its Juy 1st

tend = find(tvec(:, 2)==9 & tvec(:, 3)==15 & tvec(:, 4) == 0);
t(tend) % making sure its Sept 15

%% Find the average for each MET data
for i = 1:6
    Ta(i, 1) = mean(moraineAWS(tstart(i):tend(i), 1));% Ta
    RH(i, 1) = mean(moraineAWS(tstart(i):tend(i), 2));% RH
    U (i, 1)  = mean(moraineAWS(tstart(i):tend(i), 3));% U
    SWin(i, 1)= mean(moraineAWS(tstart(i):tend(i), 4));% SWin
    LWin(i, 1)= mean(moraineAWS(tstart(i):tend(i), 5));% LWin
    P (i, 1) = sum(moraineAWS(tstart(i):tend(i), 6)); % precip
end 
headers = {'Variable', 'Y2015','Y2016', 'Y2017','Y2018','Y2019','Y2020'};
varname = {'Ta (C)';'RH (%)';'U (m/s)'; 'SWin (W/m2)';'LWin (W/m2)';'P (mm)'};
T = table(varname, Ta, RH, U, SWin, LWin, P);
T.Properties.VariableNames = headers;
writetable(T, strcat(savedir, 'SeasonalAveragesTable_20152020.txt'))


%% Calculating albedo
%% import data
load('D:\3_FireandIce\h_output\c_met_analysis\albedo_iceathabasca_daily_clean_20152020.mat')

%% Plot seasonal albedo
% get start and end time for plot
% find start and end
t = alb_t;
tvec = datevec(t);
tstart = find(tvec(:, 2)==7 & tvec(:, 3)==1 & tvec(:, 4) == 0);
t(tstart) % making sure its Juy 1st

tend = find(tvec(:, 2)==9 & tvec(:, 3)==15 & tvec(:, 4) == 0);
t(tend) % making sure its Sept 15
tend = tend(2:end);
yr = 2015:2020;

close all
f2 = figure(2)
f2.Units = 'inches'
f2.Position = [0 0 7 3];

% cm = winter(6)
cm = [0 0 0;...     % black
     255 0 0;...    % red
     255 0 255;...  % magenta
     127 0 255 ;... % purple
     0 0 255;...     % blue
     0 204 204]./255; % cyan
    
% cm_redtoblue = color_shades({[204 0 102]./255,[0 0 204]./255})
% cm = cm_redtoblue(1:round(length(cm_redtoblue)./6):end, :)

for i =1:6;
    plot(alb_t(tstart(1):tend(1)),alb(tstart(i):tend(i)), 'linewidth',0.7, 'color', cm(i, :)); hold on
    ylim([0.1 1])
   
end 
ylabel ('Albedo (-)')
xlim ([alb_t(tstart(1)) alb_t(tend(1))])
 
legend ('2015','2016','2017','2018','2019','2020', 'location', 'NorthWest')
figname = 'iceAWS_albedo_permeltseason_daily';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')


%% Table for Average albedo  of whole season
for i =1:6;
Alb_meltseason(1, i) = nanmean(alb(tstart(i):tend(i)))
Alb_meltseason(2, i) = min(alb(tstart(i):tend(i)))
end 

headers = {'Y2015','Y2016', 'Y2017','Y2018','Y2019','Y2020'};
T = table(Alb_meltseason(:,1), Alb_meltseason(:,2), Alb_meltseason(:,3), Alb_meltseason(:,4), Alb_meltseason(:,5), Alb_meltseason(:,6) );
T.Properties.VariableNames = headers;
writetable(T, strcat(savedir, 'MeanAlbedoPerYear_Jul01toSep15.csv'))

%% Average for middle of period (remove snow period)
% find start and end
t = alb_t;
tvec = datevec(t);
tstart = find(tvec(:, 2)==7 & tvec(:, 3)==15 & tvec(:, 4) == 0);
t(tstart) % making sure its Juy 1st

tend = find(tvec(:, 2)==8 & tvec(:, 3)==15 & tvec(:, 4) == 0);
t(tend) % making sure its Sept 15

for i =1:6;
Alb_MiddleSummer(1,i) = nanmean(alb(tstart(i):tend(i)))
Alb_MiddleSummer(2,i) = nanmin(alb(tstart(i):tend(i)))
end 

headers = {'Y2015','Y2016', 'Y2017','Y2018','Y2019','Y2020'};
T = table(Alb_MiddleSummer(:,1), Alb_MiddleSummer(:,2), Alb_MiddleSummer(:,3), Alb_MiddleSummer(:,4), Alb_MiddleSummer(:,5), Alb_MiddleSummer(:,6) );
T.Properties.VariableNames = headers;
writetable(T, strcat(savedir, 'MeanAlbedoPerYear_Jul20toAug20.csv'))
