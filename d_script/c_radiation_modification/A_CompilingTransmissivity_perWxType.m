%% A -  Extract the transmissivity corresponding to each weather type
% This is the same as extracting the air temp or humidity, 
% but instead it extract the transmssivity as calculated by CRHM

% Prior to this step, I run some CRHM simulations to obtain transmissivity
% values. The simulation setup and output files are found in D:\3_FireandIce\c_CRHM\a_TransmissivityCalculation

%% Setup
close all
clear all

addpath('D:\3_FireandIce\e_function')
savedir = 'D:\3_FireandIce\h_output\d_radiation_modification\'
figdir = 'D:\3_FireandIce\f_fig\fig_radiation_modification\'

%% Import theoritical values from CRHM transmissivity simulations
% this clear sky transmissicity was calculated in CRHM
fn= 'D:\3_FireandIce\c_CRHM\a_TransmissivityCalculation\TransmissivitySimulationOutputs.txt'; 
a = ImportOutput(fn, 'tau'); tau(:, 1) = a(:, 1);
taut = ImportOutputTime(fn);
% Shift it to the nearest hour
taut= dateshift(taut, 'start', 'hour', 'nearest');
clear a fn

%% Interpolate the classification into hourly
% Load timelapse image classification 
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2015.mat', 'IDX_2015', 't2015')
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2016.mat', 'IDX_2016')
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2017.mat', 'IDX_2017')
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2018.mat', 'IDX_2018')
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2019.mat', 'IDX_2019')
load('D:\3_FireandIce\h_output\b_image_classification\TimelapseImageWeatherType_2020.mat', 'IDX_2020')

ID = [IDX_2015,IDX_2016,IDX_2017,IDX_2018,IDX_2019, IDX_2020];
time_image = t2015;
clear IDX_2015 IDX_2016 IDX_2017 IDX_2018 IDX_2019 t2015

% interpolate to get hourly values of classification (use "nearest to be centered on the values for eachh image)
T = timetable(time_image', ID); 
newTime = datetime('01-Jul-2015 00:00'):hours(1):datetime('15-Sep-2015 23:00')
TT = retime(T, newTime, 'nearest');
Classification_Hourly = table2array(TT);
time_hr= TT.Time;
clear newTime T TT 
%% Extract transmissivity tau for each Wx type
close all
yr = 2015:2020;

for yri = 1:length(yr); % number of years
class = Classification_Hourly(:, yri); %2015

yrvec = datevec(time_hr);
yrvec(:, 1) = yr(yri); time_hr = datetime(yrvec);

if yri == 2 | yri ==  5
    wxtype = [0:2];
else 
    wxtype = [0:4];
end

for ii = 1:length(wxtype)
clear x a var var_reshape
a = find(class == wxtype(ii)); % Sunny 2015
for i = 1:length(a) 
   x(i) = find(taut== time_hr(a(i)));% fomd matching time step in the MET data
end 
    tauWx(yri, ii) = mean(tau(x));
    
    if length(wxtype) ==3
        tauWx(yri, 4:5) = nan
    end 
    
end 
end 
tauWx = round(tauWx, 3);

%% Save outputs
headers = {'Year';'Sunny';'Mixed';'Cloudy'; 'LightSmoke';'DenseSmoke'};
T = table(yr',tauWx(:, 1),tauWx(:, 2),tauWx(:, 3),tauWx(:, 4),tauWx(:, 5));
T.Properties.VariableNames = headers;
writetable(T, strcat(savedir, 'MeanTransmissivity_perWxType_perYear.txt'))

MeanTransmissivity_perWxType_perYear = T;
save (strcat(savedir, 'MeanTransmissivity_perWxType_perYear.mat'), 'MeanTransmissivity_perWxType_perYear')
