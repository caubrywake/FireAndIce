%% Adjusting SWin and LWin based on transmissivity
% this is used to create the "no smoke" simulations in CRHM
% for 2015


%% Setup
close all
clear all

addpath('D:\3_FireandIce\e_function')
savedir = 'D:\3_FireandIce\h_output\d_radiation_modification\'
figdir = 'D:\3_FireandIce\f_fig\fig_radiation_modification\'

%% Import observed SWin
% from the hourly iceAWS data
load('D:\3_FireandIce\b_data_process\ice_aws\iceAWS_1hr.mat')
SW = iceAWS(:, 4);SWadj = SW;
LW = iceAWS(:, 5);LWadj = LW; 
iceAWSt = iceAWSt-hours(2);

%% Import theoritical values from CRHM transmissiivyt simulations
% this clear sky transmissicity was calculated in CRHM
fn= 'D:\3_FireandIce\c_CRHM\a_TransmissivityCalculation\TransmissivitySimulationOutputs.txt'; 
a = ImportOutput(fn, 'Qdflat'); SWcs(:, 1) = a(:, 1);
a = ImportOutput(fn, 'hru_ea'); ea(:, 1) = a(:, 1);
a = ImportOutput(fn, 'hru_t'); ta(:, 1) = a(:, 1);
a = ImportOutput(fn, 'hru_rh'); rh(:, 1) = a(:, 1);
a = ImportOutput(fn, 'tau'); tau(:, 1) = a(:, 1);
timeSWcs = ImportOutputTime(fn);
timeSWcs = timeSWcs + hours(13) ; % now its the same as iceAWS time
% plot(timeSWcs, SWcs)
% hold on
% plot(iceAWSt, iceAWS(:, 4))

Tk = ta+273.15;
RH = rh./100;
sbc = 5.67*10^-8
clear fn a rh ta

%% Trim to the same length as AWSt
t1 = find(timeSWcs == iceAWSt(1))' % 13 nan at the end
timeSWcs = [timeSWcs(t1:end) ; iceAWSt(end-12:end)];
RH = [RH(t1:end); nan(13, 1)];
Tk = [Tk(t1:end); nan(13, 1)];
ea = [ea(t1:end); nan(13, 1)];
tau = [tau(t1:end); nan(13, 1)];

% Calculate the theoritical LW base don the observations of temperature,
% humidity 
LWtheo= 1.24*(ea./Tk).^(1/7) .* (1+0.44.*RH-0.18.*tau).*sbc.*Tk.^4;
tauadj = tau;


%% Import mean transmissivity
% this mean transmissivity was obatined using the daily weather
% classification from the timelapse imagery
load('D:\3_FireandIce\h_output\d_radiation_modification\MeanTransmissivity_perWxType_perYear.mat')
meanTau = table2array(MeanTransmissivity_perWxType_perYear)
tau_sunnyWx = mean(meanTau(:, 2));
tau_lightsmokyWx = nanmean(nanmean(meanTau(:, 5)))
tau_densesmoke =  nanmean(nanmean(meanTau(:, 6)))
% factorsmoky = tau_sunnyWx./tau_smokyWx 

 %% Load timelapse image weather type classification
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2015.mat', 'IDX_2015', 't2015')
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2016.mat', 'IDX_2016', 't2016')
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2017.mat', 'IDX_2017', 't2017')
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2018.mat', 'IDX_2018', 't2018')
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2019.mat', 'IDX_2019', 't2019')
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2020.mat', 'IDX_2020', 't2020')
ID = [IDX_2015,IDX_2016,IDX_2017,IDX_2018,IDX_2019, IDX_2020];
time_image = t2015;
time_image_all = [t2015; t2016; t2017; t2018; t2019;t2020'];
clear IDX_2015 IDX_2016 IDX_2017 IDX_2018 IDX_2019 IDX_2020 t2015 t2016 t2017 t2018 t1029 t2020 
%% Interpolate the daily clasification into hourly
T = timetable(time_image',ID);
newTime = datetime('01-Jul-2015 00:00'):hours(1):datetime('15-Sep-2015 23:00');
TT = retime(T, newTime, 'nearest');
Classification_Hourly = table2array(TT);
time_hr = TT.Time;
time_hr_vec = datevec(time_hr);
time_hr = TT.Time;
time_hr_vec = datevec(time_hr);

x = time_hr_vec; 
x(:, 1) = 2015; time_hr_all(:, 1) = datetime(x);
x(:, 1) = 2016; time_hr_all(:, 2) = datetime(x);
x(:, 1) = 2017; time_hr_all(:, 3) = datetime(x);
x(:, 1) = 2018; time_hr_all(:, 4) = datetime(x);
x(:, 1) = 2019; time_hr_all(:, 5) = datetime(x);
x(:, 1) = 2020; time_hr_all(:, 6) = datetime(x);

%% Try to have it continuous
% create a continuous array for class and time
C = reshape(Classification_Hourly, length(Classification_Hourly)*6, 1);
t = reshape(time_hr_all, length(Classification_Hourly)*6, 1);

% make themr egular to the time of the AWS
T = timetable (t, C);
TT = retime(T, iceAWSt, 'fillwithmissing');
C = table2array(TT);
t = TT.t;
% test i = 7236

for i = 1:length(C);
    if C(i) >= 3 % if the hourly is smoky (0 is sunny, 1 is mixed, 2 is cloudy, 3 and 4 are light and dense smoke)
        time = t(i) ;% at 7am, the difference should be 25, so ID 8
%         hh = t_vec(i, 4)% +1;
        % for SW
           tau_diff(i) = tau_sunnyWx(1) - tau(i); % the difference between the measured tau and the theoritical tau
           if tau_diff(i) <= 0
               continue
           else
               SW_missing(i) = SW(i).*tau_diff(i); % calculate the missing radiation (radiation reduction due to emissivity reduction)
               SWadj(i) = SW(i)+ SW_missing(i); % add the missing radiation to the measured daily pattern
               % for LW
               tadj = tau_sunnyWx;
               LWdiff(i) = 1.24*(ea(i)./Tk(i))^(1/7) * (1+0.44*RH(i)-0.18*tadj).*sbc.*Tk(i).^4; % calculate the missing radiation (radiation reduction due to emissivity reduction)
               LWfc(i) = LWdiff(i)./LWtheo(i);
               LWadj(i) = LW(i).*LWfc(i); % add the missing radiation to the measured daily pattern
               tauadj(i) = tau(i) + tau_diff(i);
           end 
    else
        SWadj(i) = SW(i);
        LWadj(i) = LW(i);
        tau_diff(i) = nan;
        LWdiff(i) = nan;
        LWfc(i) = nan;
           end 
    end 
    

%% Save outputs
save(strcat(savedir, 'ModifiedSW_LWrad_removingsmokeimpact.mat'),'SWadj','LWadj','iceAWSt')

%% Plot results
c1 = [0 0 0];
c2 = [204 0 0]./255;
lw = 1;
close all
fig = figure('units', 'inches', 'position', [0 0 6 6]);

subplot(3,1,1)
a = find(iceAWSt =='23-Aug-2015'); b = find(iceAWSt =='28-Aug-2015')
plot(iceAWSt(a:b), SW(a:b), 'Color', c1, 'Linewidth',lw);hold on
plot(iceAWSt(a:b), SWadj(a:b), 'Color', c2, 'Linewidth',lw);
ylabel ('SW_{in} (Wm^{-2})')
lg = legend ('Measured (with smoke)', 'Modified (no smoke)')
lg.Position = [0.283 0.96 0 0]
text (iceAWSt(a)+hours(1), 910, '(a)')

subplot(3,1,2)
a = find(iceAWSt=='12-Aug-2017'); b = find(iceAWSt =='18-Aug-2017')
plot(iceAWSt(a:b), SW(a:b), 'Color', c1, 'Linewidth',lw);hold on
plot(iceAWSt(a:b), SWadj(a:b), 'Color', c2, 'Linewidth',lw);
ylabel ('SW_{in} (Wm^{-2})')
text (iceAWSt(a)+hours(1), 910, '(b)')

subplot(3,1,3)
a = find(iceAWSt=='14-Aug-2018'); b = find(iceAWSt =='24-Aug-2018')
plot(iceAWSt(a:b), SW(a:b), 'Color', c1, 'Linewidth',lw);hold on
plot(iceAWSt(a:b), SWadj(a:b), 'Color', c2, 'Linewidth',lw);
ylabel ('SW_{in} (Wm^{-2})')
text (iceAWSt(a)+hours(2), 910, '(c)')

figname = 'SW_modified_removesmoke';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')

%% LW 
close all
c1 = [0 0 0];
c2 = [204 0 0]./255;
lw = 1;

fig = figure('units', 'inches', 'position', [0 0 6 6]);

subplot(3,1,1)
a = find(iceAWSt =='23-Aug-2015'); b = find(iceAWSt =='28-Aug-2015')
plot(iceAWSt(a:b), LW(a:b), 'Color', c1, 'Linewidth',lw);hold on
plot(iceAWSt(a:b), LWadj(a:b), 'Color', c2, 'Linewidth',lw);
ylabel ('LW_{in} (Wm^{-2})')
lg = legend ('Measured (with smoke)', 'Modified (no smoke)')
lg.Position = [0.283 0.96 0 0]
text (iceAWSt(a)+hours(1), 340, '(a)')

subplot(3,1,2)
a = find(iceAWSt=='12-Aug-2017'); b = find(iceAWSt =='18-Aug-2017')
plot(iceAWSt(a:b), LW(a:b), 'Color', c1, 'Linewidth',lw);hold on
plot(iceAWSt(a:b), LWadj(a:b), 'Color', c2, 'Linewidth',lw);
ylabel ('LW_{in} (Wm^{-2})')
text (iceAWSt(a)+hours(1), 340, '(b)')

subplot(3,1,3)
a = find(iceAWSt=='14-Aug-2018'); b = find(iceAWSt =='24-Aug-2018')
plot(iceAWSt(a:b), LW(a:b), 'Color', c1, 'Linewidth',lw);hold on
plot(iceAWSt(a:b), LWadj(a:b), 'Color', c2, 'Linewidth',lw);
ylabel ('LW_{in} (Wm^{-2})')
text (iceAWSt(a)+hours(2), 340, '(c)')

figname = 'LW_modified_removesmoke';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')
