%% Plot SR50 data and Icemelt
close all
clear all

%% set-up
addpath(genpath('D:\3_FireandIce\CRHM'))
addpath('D:\3_FireandIce\e_function\')
savedir = 'D:\3_FireandIce\h_output\chrm_simulations\'
figdir = 'D:\3_FireandIce\f_fig\fig_chrmsim\'


%% Load model result
files = dir('D:\3_FireandIce\c_CRHM\a_CRHMoutput\Sim1.txt');   
filenames = files.name;
[icemelt(:, 1),swemelt(:, 1),xmelt(:, 1), albedo(:, 1)] ...
    = ImportOutput(filenames, ...
 'icemelt', 'SWEmelt','Xmelt','Albedo');
[timeCRHM(:, 1)] = ImportOutputTime(filenames);
timeCRHM = dateshift(timeCRHM,'start','hour', 'nearest');
%% select time for each melt season
t1 = find(timeCRHM == '01-Jul-2015')
t2 = find(timeCRHM == '16-Sep-2015')
t2015 = [t1:t2-1];
t1 = find(timeCRHM == '01-Jul-2016')
t2 = find(timeCRHM == '16-Sep-2016')
t2016 = [t1:t2-1];
t1 = find(timeCRHM == '01-Jul-2017')
t2 = find(timeCRHM == '16-Sep-2017')
t2017 = [t1:t2-1];
t1 = find(timeCRHM == '01-Jul-2018')
t2 = find(timeCRHM == '16-Sep-2018')
t2018 = [t1:t2-1];
t1 = find(timeCRHM == '01-Jul-2019')
t2 = find(timeCRHM == '16-Sep-2019')
t2019 = [t1:t2-1];
t1 = find(timeCRHM == '01-Jul-2020')
t2 = find(timeCRHM == '16-Sep-2020')
t2020 = [t1:t2-1];

%% import sr50 data
load('D:\3_FireandIce\h_output\SR50\SR50_peryear_15min_clean.mat')
sr50_2016t = sr50_2016t(97:end);
sr50_2017t = sr50_2017t(97:end);
sr50_2018t = sr50_2018t(97:end);
sr50_2019t = sr50_2019t(97:end);
sr50_2020t = sr50_2020t(97:end);

% Change to mm w.e. 
sr50_2016 = sr50_2016(97:end)*1000*0.900;
sr50_2017 = sr50_2017(97:end)*1000*0.900;
sr50_2018 = sr50_2018(97:end)*1000*0.900;
sr50_2019 = sr50_2019(97:end)*1000*0.900;
sr50_2020 = sr50_2020(97:end)*1000*0.900;
% Set to 0 for first timestpe
sr50_2016 = sr50_2016 - sr50_2016(1);
sr50_2018 = sr50_2018 - sr50_2018(1);
sr50_2019 = sr50_2019 - sr50_2019(1);

sr50_2018(7026:end)=nan;
%%
a = find(~isnan(sr50_2017));
sr50_2017 = sr50_2017 - sr50_2017(a(3));
t1 = sr50_2017t(a(3))
t1crhm= find(timeCRHM(t2017)==t1);
b = sum(xmelt(t2017(1:t1crhm), 1))
sr50_2017  = sr50_2017 + b;
sr50_2017(3550:end)=nan;

a = find(~isnan(sr50_2020));
sr50_2020 = sr50_2020 - sr50_2020(a(3));
t1 = sr50_2020t(a(1)-1)
t1crhm= find(timeCRHM(t2020)==t1);
b = sum(xmelt(t2020(1:t1crhm), 1))
sr50_2020  = sr50_2020 + b;
sr50_2020(6508:end) = nan;
plot(sr50_2020)
%% Plot comparison
 close all
 % Compile melt for each seaons
c1 = 'k';% no fire
 c2 = 'r';
 f1 = figure('units','inches','outerposition',[0 0 8 6]);

subplot(2,3,1)
plot(timeCRHM(t2016), cumsum(xmelt(t2016, 1)),  'Color', c1); hold on %No fire
plot(sr50_2016t-hours(2), sr50_2016, 'Color', c2)
text(timeCRHM(t2016(72)), 4200, 'a) 2016', 'Fontsize', 10);
 xlim([timeCRHM(t2016(1)) timeCRHM(t2016(end))]); 
xticks ([datetime('01-Jul-2016'), datetime( '01-Aug-2016'),datetime( '01-Sep-2016')]);
xticklabels({'01-Jul', '01-Aug', '01-Sep'});
ylim([0 4500]);yticks ([0:1000:4000]);
xtickformat('dd-MMM')
grid on
ylabel({'Cumulative ice melt';' (mm w.e.)'})
lg = legend ('Modelled','Measured', 'orientation','horizontal', 'location','northwest')
pos = lg.Position;
lg.Position = pos + [-0.01 0.07 0 0]

subplot(2,3,2)
plot(timeCRHM(t2017), cumsum(xmelt(t2017, 1)),  'Color', c1); hold on %No fire
plot(sr50_2017t-hours(2), sr50_2017, 'Color', c2)
text(timeCRHM(t2017(72)), 4200, 'b) 2017', 'Fontsize', 10);
 xlim([timeCRHM(t2017(1)) timeCRHM(t2017(end))]); 
xticks ([datetime('01-Jul-2017'), datetime( '01-Aug-2017'),datetime( '01-Sep-2017')]);
xticklabels({'01-Jul', '01-Aug', '01-Sep'});
ylim([0 4500]);yticks ([0:1000:4000]);
xtickformat('dd-MMM')
grid on
ylabel({'Cumulative ice melt';' (mm w.e.)'})

subplot(2,3,3)
plot(timeCRHM(t2018), cumsum(xmelt(t2018, 1)),  'Color', c1); hold on %No fire
plot(sr50_2018t-hours(2), sr50_2018, 'Color', c2)
text(timeCRHM(t2018(72)), 4200, 'c) 2018', 'Fontsize', 10);
xlim([timeCRHM(t2018(1)) timeCRHM(t2018(end))]); 
xticks ([datetime('01-Jul-2018'), datetime( '01-Aug-2018'),datetime( '01-Sep-2018')]);
xticklabels({'01-Jul', '01-Aug', '01-Sep'});
ylim([0 4500]);yticks ([0:1000:4000]);
xtickformat('dd-MMM')
grid on
ylabel({'Cumulative ice melt';' (mm w.e.)'})

subplot(2,3,4)
plot(timeCRHM(t2019), cumsum(xmelt(t2019, 1)),  'Color', c1); hold on %No fire
plot(sr50_2019t-hours(2), sr50_2019, 'Color', c2)
text(timeCRHM(t2019(72)), 4200, 'd) 2019', 'Fontsize', 10);
 xlim([timeCRHM(t2019(1)) timeCRHM(t2019(end))]); 
xticks ([datetime('01-Jul-2019'), datetime( '01-Aug-2019'),datetime( '01-Sep-2019')]);
xticklabels({'01-Jul', '01-Aug', '01-Sep'});
ylim([0 4500]);yticks ([0:1000:4000]);
xtickformat('dd-MMM')
grid on
ylabel({'Cumulative ice melt';' (mm w.e.)'})

subplot(2,3,5)
plot(timeCRHM(t2020), cumsum(xmelt(t2020, 1)),  'Color', c1); hold on  % Only smoke (atmospheric - blue)
plot(sr50_2020t-hours(2), sr50_2020, 'Color', c2)
text(timeCRHM(t2020(72)), 4200, 'e) 2020', 'Fontsize', 10);
 xlim([timeCRHM(t2020(1)) timeCRHM(t2020(end))]); 
xticks ([datetime('01-Jul-2020'), datetime( '01-Aug-2020'),datetime( '01-Sep-2020')]);
xticklabels({'01-Jul', '01-Aug', '01-Sep'});
ylim([0 4500]);yticks ([0:1000:4000]);
xtickformat('dd-MMM')
grid on
ylabel({'Cumulative ice melt';' (mm w.e.)'})

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 0.8;
end

figname = 'CRHM_comparedtoSR50_CumMelt';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')

%% Calculate numbers
clear D
xmelt(xmelt<0)=0;
% average melt for sr50 and for melt, and number of days considered
% remove the nan
% for 2016
var_nonan= sr50_2016 ;
var_nonant= sr50_2016t ;
a = find(isnan(var_nonan));
var_nonan(a)=[];
var_nonant(a)=[];

% find the number of full days (mnually)
var_nonan=var_nonan(1:4608);
var_nonant=var_nonant(1:4608);
nday = numel(var_nonan)/(24*4)
melt_meas = var_nonan(end)-var_nonan(1);

t1 = find(timeCRHM==var_nonant(1));
t2 = find(timeCRHM== var_nonant(end));
melt_mod = sum(xmelt(t1:t2));

diff_mm = melt_meas - melt_mod;
diff_mm_day = melt_meas/nday - melt_mod/nday;
D(1,:) = [melt_meas, melt_mod, diff_mm, melt_meas/nday, melt_mod/nday, diff_mm_day, nday];
% 2017
var_nonan= sr50_2017 ;
var_nonant= sr50_2017t ;
a = find(isnan(var_nonan));
var_nonan(a)=[];
var_nonant(a)=[];

% find the number of full days (mnually)
var_nonan=var_nonan(47:1678);
var_nonant=var_nonant(47:1678);
nday = numel(var_nonan)/(24*4)
melt_meas = var_nonan(end)-var_nonan(1);

t1 = find(timeCRHM==var_nonant(1));
t2 = find(timeCRHM== var_nonant(end));
melt_mod = sum(xmelt(t1:t2));

diff_mm = melt_meas - melt_mod;
diff_mm_day = melt_meas/nday - melt_mod/nday;
D(2,:) = [melt_meas, melt_mod, diff_mm, melt_meas/nday, melt_mod/nday, diff_mm_day, nday];%
% 2018
var_nonan= sr50_2018 ;
var_nonant= sr50_2018t ;
a = find(isnan(var_nonan));
var_nonan(a)=[];
var_nonant(a)=[];

% find the number of full days (mnually)
var_nonan=var_nonan(1:6988);
var_nonant=var_nonant(1:6988);
nday = round(numel(var_nonan)/(24*4))
melt_meas = var_nonan(end)-var_nonan(1);

t1 = find(timeCRHM==var_nonant(1));
t2 = find(timeCRHM== var_nonant(end));
melt_mod = sum(xmelt(t1:t2));
plot(var_nonant, var_nonan)
diff_mm = melt_meas - melt_mod;
diff_mm_day = melt_meas/nday - melt_mod/nday;
D(3,:) = [melt_meas, melt_mod, diff_mm, melt_meas/nday, melt_mod/nday, diff_mm_day, nday];
% 2019
var_nonan= sr50_2019 ;
var_nonant= sr50_2019t ;
a = find(isnan(var_nonan));
var_nonan(a)=[];
var_nonant(a)=[];

% find the number of full days (mnually)
var_nonan=var_nonan(1:7385);
var_nonant=var_nonant(1:7385);
nday = round(numel(var_nonan)/(24*4))
melt_meas = var_nonan(end)-var_nonan(1);

t1 = find(timeCRHM==var_nonant(1));
t2 = find(timeCRHM== var_nonant(end));
melt_mod = sum(xmelt(t1:t2));
diff_mm = melt_meas - melt_mod;
diff_mm_day = melt_meas/nday - melt_mod/nday;
D(4,:) = [melt_meas, melt_mod, diff_mm, melt_meas/nday, melt_mod/nday, diff_mm_day, nday];
% 2020
var_nonan= sr50_2020 ;
var_nonant= sr50_2020t ;
a = find(isnan(var_nonan));
var_nonan(a)=[];
var_nonant(a)=[];

% find the number of full days (mnually)
var_nonan=var_nonan(4:5172);
var_nonant=var_nonant(4:5172);
nday = round(numel(var_nonan)/(24*4))
melt_meas = var_nonan(end)-var_nonan(1);

t1 = find(timeCRHM==var_nonant(1));
t2 = find(timeCRHM== var_nonant(end));
melt_mod = sum(xmelt(t1:t2));
diff_mm = melt_meas - melt_mod;
diff_mm_day = melt_meas/nday - melt_mod/nday;
D(5,:) = [melt_meas, melt_mod, diff_mm, melt_meas/nday, melt_mod/nday, diff_mm_day, nday]; % 2020

D(:, 1:6) = D(:, 1:6)/1000;

D(6,:) = sum(D);
yr = {'Y2016','Y2017','Y2018','Y2019','Y2020','AllYrs'};
T = table(yr', round(D(:, 1),2), round(D(:, 2),2), round(D(:, 3),2),D(:, 4), D(:, 5), D(:, 6), round(D(:, 7)) );
varname = {'Year', 'SR50_mm','CRHM_mm', 'Diff_mm', 'SR50_mm_day','CRHM_mm_day','Diff_mm_day', 'NumberDays'}
T.Properties.VariableNames=varname;
writetable(T, strcat(savedir, 'SR50Meas_CRHMMod_surfacemelt.csv'))

