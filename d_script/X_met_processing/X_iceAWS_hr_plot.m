%% Importing Hourly AWS ice data
% edited by Caroline Aubry-Wake
% this script import the .csv file and plots the result. The hourly data
% was compiled form the 15min data, and was infilled and changw to hourly
% time step in R using CRHMr.
%% Set-up
cd ('D:\3_FireandIce')
close all
clear all
addpath('D:\3_FireandIce\function')

% set path to directories
figdir = 'f_fig\a_met\'

%% Load data 
fn = 'D:\3_FireandIce\a_data\ice_aws\AthabascaIce_1hr_2014_2020.csv'
D = importdata(fn);
iceAWS = D.data;
iceAWSt= datetime(D.textdata(2:end, 1));
clear D fn

%% Plot ice AWS data
f1 = figure(1)
f1.Units = 'inches'
f1.Position = [0 0 6 6];
subplot(4,1,1)
plot(iceAWSt, iceAWS(:, 1));
ylabel('Ta (C)');
xlim([iceAWSt(1) iceAWSt(end)]);
ylim ([-30 20]);

subplot(4,1,2);
plot(iceAWSt, iceAWS(:, 2));
ylabel('RH (%)');
xlim([iceAWSt(1) iceAWSt(end)]);
ylim ([0 100]);

subplot(4,1,3)
plot(iceAWSt, iceAWS(:, 3))
ylabel('U (m/s)');
xlim([iceAWSt(1) iceAWSt(end)])
ylim ([0 21]);

subplot(4,1,4)
plot(iceAWSt, iceAWS(:, 4)); hold on
plot(iceAWSt, iceAWS(:, 5));
ylabel('Qsi and Qli (W/m2)');
xlim([iceAWSt(1) iceAWSt(end)])
ylim ([0 1200]);

figname = 'iceAWS_1hr';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')
