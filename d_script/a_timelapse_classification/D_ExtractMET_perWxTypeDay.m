%% D - Extract MET observation for each weather type
% This script extract the and average the meteorological conditions from
% the on-ice AWS for each weather type
 clear all

addpath('D:\3_FireandIce\e_function')
savedir = 'D:\3_FireandIce\h_output\b_image_classification\'
figdir = 'D:\3_FireandIce\f_fig\fig_timelapse_classification\'
%% Load data

% Import athabasca iceAWS
load('D:\3_FireandIce\b_data_process\ice_aws\iceAWS_1hr.mat')
plot(iceAWSt, iceAWS(:, 4)); hold on
iceAWSt = iceAWSt - hours(2); % wrong timezone
plot(iceAWSt, iceAWS(:, 4));
% Load timelapse image classification per day
 load('D:\3_FireandIce\h_output\b_image_classification\NumberofDayperWxType.mat', 'ClassificationofDays_WxType', 'time_days')

%% Interpolate the classification into hourly
% Interpolate the daily clasification into hourly
T = timetable(time_days',ClassificationofDays_WxType);
newTime = datetime('01-Jul-2015 00:00'):hours(1):datetime('15-Sep-2015 23:00')
TT = retime(T, newTime, 'previous')
Classification_Hourly = table2array(TT);
time_hr = TT.Time;

plot(time_hr, Classification_Hourly(:, 1)); hold on
plot(time_days, ClassificationofDays_WxType(:, 1)) % it worked
clear T TT newTime

%% Extract MET mean for 2015

close all

class = Classification_Hourly(:, 1); %2015
wxtype = [0:4];
x = datevec(time_hr);
x(:, 1) = 2015; time_hr = datetime(x);

for ii = 1:length(wxtype);
clear x a var var_reshape
a = find(class == wxtype(ii)); % Sunny 2015
for i = 1:length(a) 
   x(i) = find(iceAWSt == time_hr(a(i)));% fomd matching time step in the MET data
end 

for i =1:5 % through the variables
    var = iceAWS(x, i);
    var_reshape = reshape(var, 24, numel(var)/24);
    MET(:, i, ii) = mean(var_reshape,2);
end
end 
MET_DiurnalCycle_PerWxType_2015 =MET;
save (strcat(savedir, 'MET_DiurnalCycle_PerWxType_2015.mat'), 'MET_DiurnalCycle_PerWxType_2015')

plot_metperWxtype_peryear (MET)% function to plot the results
title('2015')
figname = 'WxType_MET_2015';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Extract MET mean for 2016
clear MET VAR WX TS class x

class = Classification_Hourly(:, 2); %2016
wxtype = [0:2] % no smoke;
x = datevec(time_hr);
x(:, 1) = 2016; time_hr = datetime(x);

for WX = 1:length(wxtype); % for each weather type
clear x a var var_reshape
a = find(class == wxtype(WX));
for TS = 1:length(a) % for each time step
   x(TS) = find(iceAWSt == time_hr(a(TS)));% fomd matching time step in the MET data
end 

for VAR=1:5 % through the variables
    var = iceAWS(x, VAR);
    var_reshape = reshape(var, 24, numel(var)/24);
    MET(:, VAR, WX) = mean(var_reshape,2);
end
end 
MET_DiurnalCycle_PerWxType_2016 =MET;
save (strcat(savedir, 'MET_DiurnalCycle_PerWxType_2016.mat'), 'MET_DiurnalCycle_PerWxType_2016')

plot_metperWxtype_peryear (MET)% function to plot the results
title('2016')
figname = 'WxType_MET_2016';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Extract MET mean for 2017
clear MET VAR WX TS 

class = Classification_Hourly(:, 3); %2017
wxtype = [0:4];
x = datevec(time_hr);
x(:, 1) = 2017; time_hr = datetime(x);

for WX = 1:length(wxtype); % for each weather type
clear x a var var_reshape
a = find(class == wxtype(WX));
for TS = 1:length(a) % for each time step
   x(TS) = find(iceAWSt == time_hr(a(TS)));% fomd matching time step in the MET data
end 

for VAR=1:5 % through the variables
    var = iceAWS(x, VAR);
    var_reshape = reshape(var, 24, numel(var)/24);
    MET(:, VAR, WX) = mean(var_reshape,2);
end
end
MET_DiurnalCycle_PerWxType_2017 =MET;
save (strcat(savedir, 'MET_DiurnalCycle_PerWxType_2017.mat'), 'MET_DiurnalCycle_PerWxType_2017')

plot_metperWxtype_peryear (MET)% function to plot the results
title ('2017')
figname = 'WxType_MET_2017';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Extract MET mean for 2018
clear MET VAR WX TS 
class = Classification_Hourly(:, 4); %2018
wxtype = [0:4];
x = datevec(time_hr);
x(:, 1) = 2018; time_hr = datetime(x);

for WX = 1:length(wxtype); % for each weather type
clear x a var var_reshape
a = find(class == wxtype(WX));
for TS = 1:length(a) % for each time step
   x(TS) = find(iceAWSt == time_hr(a(TS)));% fomd matching time step in the MET data
end 

for VAR=1:5 % through the variables
    var = iceAWS(x, VAR);
    var_reshape = reshape(var, 24, numel(var)/24);
MET(:, VAR, WX) = mean(var_reshape,2);
end
end

MET_DiurnalCycle_PerWxType_2018 =MET;
save (strcat(savedir, 'MET_DiurnalCycle_PerWxType_2018.mat'), 'MET_DiurnalCycle_PerWxType_2018')

plot_metperWxtype_peryear (MET)% function to plot the results
title ('2018')
figname = 'WxType_MET_2018';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Extract MET mean for 2019
clear MET
class = Classification_Hourly(:, 5); %2019
wxtype = [0:2];
x = datevec(time_hr);
x(:, 1) = 2019; time_hr = datetime(x);

for WX = 1:length(wxtype); % for each weather type
clear x a var var_reshape
a = find(class == wxtype(WX));
for TS = 1:length(a) % for each time step
   x(TS) = find(iceAWSt == time_hr(a(TS)));% fomd matching time step in the MET data
end 

for VAR=1:5 % through the variables
    var = iceAWS(x, VAR);
    var_reshape = reshape(var, 24, numel(var)/24);
MET(:, VAR, WX) = mean(var_reshape,2);
end
end
MET_DiurnalCycle_PerWxType_2019 =MET;
save (strcat(savedir, 'MET_DiurnalCycle_PerWxType_2019.mat'), 'MET_DiurnalCycle_PerWxType_2019')

plot_metperWxtype_peryear (MET)% function to plot the results
title ('2019')
figname = 'WxType_MET_2019';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')
%% Extract MET mean for 2020
clear MET VAR WX TS 
class = Classification_Hourly(:, 6); %2018
wxtype = [0:4];
x = datevec(time_hr);
x(:, 1) = 2020; time_hr = datetime(x);

for WX = 1:length(wxtype) % for each weather type
clear x a var var_reshape
a = find(class == wxtype(WX));
for TS = 1:length(a) % for each time step
   x(TS) = find(iceAWSt == time_hr(a(TS)));% fomd matching time step in the MET data
end 

for VAR=1:5 % through the variables
    var = iceAWS(x, VAR);
    var_reshape = reshape(var, 24, numel(var)/24);
MET(:, VAR, WX) = mean(var_reshape,2);
end
end
MET_DiurnalCycle_PerWxType_2020 =MET;
save (strcat(savedir, 'MET_DiurnalCycle_PerWxType_2020.mat'), 'MET_DiurnalCycle_PerWxType_2020')

plot_metperWxtype_peryear (MET)% function to plot the results
title ('2020')
figname = 'WxType_MET_2020';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Average all the years together
addpath('D:\3_FireandIce\e_function')
savedir = 'D:\3_FireandIce\h_output\b_image_classification\'
figdir = 'D:\3_FireandIce\f_fig\fig_timelapse_classification\'
clear all
 close all
load('D:\3_FireandIce\h_output\b_image_classification\MET_DiurnalCycle_PerWxType_2017.mat')
load('D:\3_FireandIce\h_output\b_image_classification\MET_DiurnalCycle_PerWxType_2018.mat')
load('D:\3_FireandIce\h_output\b_image_classification\MET_DiurnalCycle_PerWxType_2019.mat')
load('D:\3_FireandIce\h_output\b_image_classification\MET_DiurnalCycle_PerWxType_2020.mat')
load('D:\3_FireandIce\h_output\b_image_classification\MET_DiurnalCycle_PerWxType_2015.mat')
load('D:\3_FireandIce\h_output\b_image_classification\MET_DiurnalCycle_PerWxType_2016.mat')
%% Extract and average the result per weather type
Sunny= squeeze(mean(cat(3, MET_DiurnalCycle_PerWxType_2015(:,:,1),MET_DiurnalCycle_PerWxType_2016(:,:,1), ...
            MET_DiurnalCycle_PerWxType_2017(:,:,1),MET_DiurnalCycle_PerWxType_2018(:,:,1), ...
            MET_DiurnalCycle_PerWxType_2019(:,:,1), MET_DiurnalCycle_PerWxType_2020(:,:,1)), 3));
Mixed = squeeze(mean(cat(3, MET_DiurnalCycle_PerWxType_2015(:,:,2),MET_DiurnalCycle_PerWxType_2016(:,:,2), ...
            MET_DiurnalCycle_PerWxType_2017(:,:,2),MET_DiurnalCycle_PerWxType_2018(:,:,2), ...
            MET_DiurnalCycle_PerWxType_2019(:,:,2),  MET_DiurnalCycle_PerWxType_2020(:,:,2)),3));
Cloudy = squeeze(mean(cat(3, MET_DiurnalCycle_PerWxType_2015(:,:,3),MET_DiurnalCycle_PerWxType_2016(:,:,3), ...
            MET_DiurnalCycle_PerWxType_2017(:,:,3),MET_DiurnalCycle_PerWxType_2018(:,:,3), ...
            MET_DiurnalCycle_PerWxType_2019(:,:,3), MET_DiurnalCycle_PerWxType_2020(:,:,3)),3));   
LightSmoke= squeeze(mean(cat(3, MET_DiurnalCycle_PerWxType_2015(:,:,4), ...
            MET_DiurnalCycle_PerWxType_2017(:,:,4),MET_DiurnalCycle_PerWxType_2018(:,:,4),...
           MET_DiurnalCycle_PerWxType_2020(:,:,4)), 3));   
DenseSmoke= squeeze(mean(cat(3, MET_DiurnalCycle_PerWxType_2015(:,:,5), ...
            MET_DiurnalCycle_PerWxType_2017(:,:,5),MET_DiurnalCycle_PerWxType_2018(:,:,5),...
            MET_DiurnalCycle_PerWxType_2020(:,:,5)),3));
        
%% Make a table
d = [mean(Sunny); mean(Mixed); mean(Cloudy); mean(LightSmoke); mean(DenseSmoke)];
headers = {'WxType','Ta','RH', 'U', 'SWin','LWin'};
DayType = {'Clear';'Mixed';'Cloudy';'Light Smoke';'Dense Smoke'}
T = table(DayType, d(:,1), d(:,2), d(:,3), d(:,4), d(:,5));
T.Properties.VariableNames = headers;
writetable(T, strcat(savedir, 'WxType_Average.csv'))

% change in SW
max(Sunny(:, 4))-max(LightSmoke(:,4))
max(Sunny(:, 4))-max(DenseSmoke(:,4))

max(Sunny(:, 5))
min(Sunny(:, 5))
%% Plot the results
c1 = [0 102 204]/255; % blue
c2 = [192 192 192]/255; % ligh gray
c3 = [96 96 96]/255;% dark gray
c4 = [255 178 102]/255;% light orange
c5 = [204 102 0]/255;% orange
lw = .8;

% hours
t = datetime('01-Aug-2015 00:00'):hours(1):datetime('01-Aug-2015 23:00')
fig = figure('units', 'inches', 'position', [0 0 8 4]);

%% all years
%% Plot the results
c1 = [0 102 204]/255; % blue
c2 = [192 192 192]/255; % ligh gray
c3 = [96 96 96]/255;% dark gray
c4 = [255 178 102]/255;% light orange
c5 = [204 102 0]/255;% orange
lw = .8;

% hours
t = datetime('01-Aug-2015 00:00'):hours(1):datetime('01-Aug-2015 23:00')
fig = figure('units', 'inches', 'position', [0 0 8 4]);

% Row 1:Ta. Column: 2015-2020, all years
i = 1; subplot(2,3,i); 
plot(t, Sunny(:, i), 'Color', c1, 'linewidth', lw); hold on;
plot(t, Mixed(:, i), 'Color', c2, 'linewidth', lw);
plot(t, Cloudy(:, i), 'Color', c3, 'linewidth', lw);
plot(t, LightSmoke(:, i), 'Color', c4, 'linewidth', lw);
plot(t, DenseSmoke(:, i), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([4 11])
ylabel ('T_a ({\circ}C)')
xticks([t(1):hours(6):t(24)]); xticklabels({'00:00';'6:00';'12:00';'18:00'})
grid on

i = 2; subplot(2,3,i); 
plot(t, Sunny(:, i), 'Color', c1, 'linewidth', lw); hold on;
plot(t, Mixed(:, i), 'Color', c2, 'linewidth', lw);
plot(t, Cloudy(:, i), 'Color', c3, 'linewidth', lw);
plot(t, LightSmoke(:, i), 'Color', c4, 'linewidth', lw);
plot(t, DenseSmoke(:, i), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([rh1 rh2])
ylabel ('RH (%)')
xticks([t(1):hours(6):t(24)]); xticklabels({'00:00';'6:00';'12:00';'18:00'})
grid on

i = 3; subplot(2,3,i); 
plot(t, Sunny(:, i), 'Color', c1, 'linewidth', lw); hold on;
plot(t, Mixed(:, i), 'Color', c2, 'linewidth', lw);
plot(t, Cloudy(:, i), 'Color', c3, 'linewidth', lw);
plot(t, LightSmoke(:, i), 'Color', c4, 'linewidth', lw);
plot(t, DenseSmoke(:, i), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylabel ('U (ms^{-1})')
xticks([t(1):hours(6):t(24)]); xticklabels({'00:00';'6:00';'12:00';'18:00'})
grid on

i = 4; 
subplot(2,3,i); 
plot(t, Sunny(:, i), 'Color', c1, 'linewidth', lw); hold on;
plot(t, Mixed(:, i), 'Color', c2, 'linewidth', lw);
plot(t, Cloudy(:, i), 'Color', c3, 'linewidth', lw);
plot(t, LightSmoke(:, i), 'Color', c4, 'linewidth', lw);
plot(t, DenseSmoke(:, i), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylabel ('SW_{in} (Wm^{-2})')
xticks([t(1):hours(6):t(24)]); xticklabels({'00:00';'6:00';'12:00';'18:00'})
grid on

i = 5;  subplot(2,3,i); 
plot(t, Sunny(:, i), 'Color', c1, 'linewidth', lw); hold on;
plot(t, Mixed(:, i), 'Color', c2, 'linewidth', lw);
plot(t, Cloudy(:, i), 'Color', c3, 'linewidth', lw);
plot(t, LightSmoke(:, i), 'Color', c4, 'linewidth', lw);
plot(t, DenseSmoke(:, i), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylabel ('LW_{in} (Wm^{-2})')
xticks([t(1):hours(6):t(24)]); xticklabels({'00:00';'6:00';'12:00';'18:00'})
grid on

subplot(2,3,6); 
plot(t, Sunny(:, i), 'Color', c1, 'linewidth', lw); hold on;
plot(t, Mixed(:, i), 'Color', c2, 'linewidth', lw);
plot(t, Cloudy(:, i), 'Color', c3, 'linewidth', lw);
plot(t, LightSmoke(:, i), 'Color', c4, 'linewidth', lw);
plot(t, DenseSmoke(:, i), 'Color', c5, 'linewidth', lw);
xlim ([datetime('01-July-2021 01:00') datetime('01-July-2021 02:00')])
legend ('Clear', 'Mixed', 'Cloud', 'Light Smoke', 'Dense Smoke')
xticklabels ([]);yticklabels ([])
grid on

figname = 'WxType_MET_allYears';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% supplementary figure
fig = figure('units', 'inches', 'position', [0 0 11 11]);

ta1 = 4
ta2 = 12;

rh1 = 30;
rh2 = 100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2015
var = MET_DiurnalCycle_PerWxType_2015;
i = 1; 
subplot(7,5,i);
plot(t, var(:,1,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,1,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,1,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,1,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,1,5), 'Color', c5, 'linewidth', lw);
ylim([ta1 ta2]);
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 2; 
subplot(7,5,i);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([rh1 rh2])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 3; 
subplot(7,5,i);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 4; 
subplot(7,5,i);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 5;  
subplot(7,5,i); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

%% 2016
var = MET_DiurnalCycle_PerWxType_2016;
i = 1; 
subplot(7,5,i+5); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([ta1 ta2])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 2; 
subplot(7,5,i+5); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([rh1 rh2])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 3; 
subplot(7,5,i+5); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 4; 
subplot(7,5,i+5); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 5;  
subplot(7,5,i+5); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]);xticklabels([])
grid on

%% 2017
var = MET_DiurnalCycle_PerWxType_2017;
i = 1; 
subplot(7,5,i+10);
plot(t, var(:,1,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,1,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,1,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,1,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,1,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([ta1 ta2])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 2; 
subplot(7,5,i+10);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([rh1 rh2])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 3; 
subplot(7,5,i+10);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 4; 
subplot(7,5,i+10);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on


i = 5;  
subplot(7,5,i+10); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

%% 2018
var = MET_DiurnalCycle_PerWxType_2018;
i = 1; 
subplot(7,5,i+15);
plot(t, var(:,1,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,1,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,1,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,1,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,1,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([ta1 ta2])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 2; 
subplot(7,5,i+15);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([rh1 rh2])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 3; 
subplot(7,5,i+15);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 4; 
subplot(7,5,i+15);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on


i = 5;  
subplot(7,5,i+15); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

%% 2019
var = MET_DiurnalCycle_PerWxType_2019;
i = 1; 
subplot(7,5,i+20); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([ta1 ta2])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 2; 
subplot(7,5,i+20); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([rh1 rh2])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 3; 
subplot(7,5,i+20); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 4; 
subplot(7,5,i+20); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on


i = 5;  
subplot(7,5,i+20); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on
%% 2020
var = MET_DiurnalCycle_PerWxType_2020;
i = 1; 
subplot(7,5,i+25);
plot(t, var(:,1,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,1,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,1,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,1,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,1,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([ta1 ta2])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 2; 
subplot(7,5,i+25);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([rh1 rh2])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 3; 
subplot(7,5,i+25);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

i = 4; 
subplot(7,5,i+25);
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on


i = 5;  
subplot(7,5,i+25); 
plot(t, var(:,i,1), 'Color', c1, 'linewidth', lw); hold on;
plot(t, var(:,i,2), 'Color', c2, 'linewidth', lw);
plot(t, var(:,i,3), 'Color', c3, 'linewidth', lw);
plot(t, var(:,i,4), 'Color', c4, 'linewidth', lw);
plot(t, var(:,i,5), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
xticks([t(1):hours(6):t(24)]); xticklabels([])
grid on

%% average
i = 1; subplot(7,5,i+30); 
plot(t, Sunny(:, i), 'Color', c1, 'linewidth', lw); hold on;
plot(t, Mixed(:, i), 'Color', c2, 'linewidth', lw);
plot(t, Cloudy(:, i), 'Color', c3, 'linewidth', lw);
plot(t, LightSmoke(:, i), 'Color', c4, 'linewidth', lw);
plot(t, DenseSmoke(:, i), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([4 11])
ylabel ('T_a ({\circ}C)')
xticks([t(1):hours(6):t(24)]); xticklabels({'00:00';'6:00';'12:00';'18:00'})
grid on

i = 2; subplot(7,5,i+30);
plot(t, Sunny(:, i), 'Color', c1, 'linewidth', lw); hold on;
plot(t, Mixed(:, i), 'Color', c2, 'linewidth', lw);
plot(t, Cloudy(:, i), 'Color', c3, 'linewidth', lw);
plot(t, LightSmoke(:, i), 'Color', c4, 'linewidth', lw);
plot(t, DenseSmoke(:, i), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylim([rh1 rh2])
ylabel ('RH (%)')
xticks([t(1):hours(6):t(24)]); xticklabels({'00:00';'6:00';'12:00';'18:00'})
grid on

i = 3; subplot(7,5,i+30);
plot(t, Sunny(:, i), 'Color', c1, 'linewidth', lw); hold on;
plot(t, Mixed(:, i), 'Color', c2, 'linewidth', lw);
plot(t, Cloudy(:, i), 'Color', c3, 'linewidth', lw);
plot(t, LightSmoke(:, i), 'Color', c4, 'linewidth', lw);
plot(t, DenseSmoke(:, i), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylabel ('U (ms^{-1})')
xticks([t(1):hours(6):t(24)]); xticklabels({'00:00';'6:00';'12:00';'18:00'})
grid on

i = 4; 
subplot(7,5,i+30);
plot(t, Sunny(:, i), 'Color', c1, 'linewidth', lw); hold on;
plot(t, Mixed(:, i), 'Color', c2, 'linewidth', lw);
plot(t, Cloudy(:, i), 'Color', c3, 'linewidth', lw);
plot(t, LightSmoke(:, i), 'Color', c4, 'linewidth', lw);
plot(t, DenseSmoke(:, i), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylabel ('SW_{in} (Wm^{-2})')
xticks([t(1):hours(6):t(24)]); xticklabels({'00:00';'6:00';'12:00';'18:00'})
grid on

i = 5;  subplot(7,5,i+30);
plot(t, Sunny(:, i), 'Color', c1, 'linewidth', lw); hold on;
plot(t, Mixed(:, i), 'Color', c2, 'linewidth', lw);
plot(t, Cloudy(:, i), 'Color', c3, 'linewidth', lw);
plot(t, LightSmoke(:, i), 'Color', c4, 'linewidth', lw);
plot(t, DenseSmoke(:, i), 'Color', c5, 'linewidth', lw);
xlim ([t(1) t(24)])
ylabel ('LW_{in} (Wm^{-2})')
xticks([t(1):hours(6):t(24)]); xticklabels({'00:00';'6:00';'12:00';'18:00'})
grid on

figname = 'WxType_MET_allindividualyears';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')
%%% 
