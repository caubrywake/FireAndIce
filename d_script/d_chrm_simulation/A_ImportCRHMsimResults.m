%% Import simulations results 

%% Setup
clear all
close all

addpath(genpath('D:\3_FireandIce\c_CRHM'))
addpath('D:\3_FireandIce\e_function\')
savedir = 'D:\3_FireandIce\h_output\e_chrm_simulations\'
figdir = 'D:\3_FireandIce\f_fig\fig_chrmsim\'

%% Load model result
files = dir('D:\3_FireandIce\c_CRHM\c_CRHMoutput\*.txt');   % load all the images in that directory
nfiles = length(files); 
clear filenames
for i = 1:nfiles
    filenames{:, i} = strcat(files(i, :).folder, '\', files(i,:).name)
end 
order_sim = [4,2,3,1];
filenames = filenames(order_sim)
filenames= filenames';
% no fire
% With smoke  (meas MET, albedo = 0.3)
% With lais (mod met, meas albedo)
% with fire (meas met, meas aldedo)


for i = 1:4
[icemelt(:, i),swemelt(:, i),xmelt(:, i), albedo(:, i),...
    Qe(:, i), Qh(:, i),Qn(:, i),Qmelt(:, i),...
    LWin(:, i), SWin(:, i)] ...
    = ImportOutput(filenames{i}, ...
 'icemelt', 'SWEmelt','Xmelt','Albedo',...
  'Qe', 'Qh','Qn','Qmelt',...
  'Qlisn', 'Qsisn');
[timeCRHM(:, i)] = ImportOutputTime(filenames{i});
end 
timeCRHM = timeCRHM(:, 1);


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

 %% Plot melt per scenario
% 1) No Fire
% 2) With Smoke
% 3) With LAIs
% 4) With Fire

 close all
 % Compile melt for each seaons
c1 = 'k';% no fire
c2 =  'b'; % radiation effect
c3 = [0.5 .5 .5]; % albedo effect
c4 = 'r'; % with fire
 
 f1 = figure('units','inches','outerposition',[0 0 8 6]);

subplot(2,3,1)
plot(timeCRHM(t2015), cumsum(xmelt(t2015, 1)),  'Color', c1); hold on %No fire
plot(timeCRHM(t2015), cumsum(xmelt(t2015, 2)),  'Color', c2);  % Only smoke (atmospheric - blue)
plot(timeCRHM(t2015), cumsum(xmelt(t2015, 3)),  'Color', c3); % Only soot 
plot(timeCRHM(t2015), cumsum(xmelt(t2015, 4)),  'Color', c4); % With fire (observed)
ylabel({'Cumulative ice melt';' (mm w.e.)'})
text(timeCRHM(t2015(72)), 4000, 'c) 2015', 'Fontsize', 10);
 xlim([timeCRHM(t2015(1)) timeCRHM(t2015(end))]); 
xticks ([datetime('01-Jul-2015'), datetime( '01-Aug-2015'),datetime( '01-Sep-2015')]);
xticklabels({'01-Jul', '01-Aug', '01-Sep'});
ylim([0 4200]);yticks ([0:1000:4000]);
xtickformat('dd-MMM')
grid on
lg = legend ('No Fire', 'With Smoke', 'With LAI', 'With Fire', 'location', 'northwest','Orientation', 'horizontal')
pos = lg.Position;
lg.Position = pos + [-0.02 +0.075 0 0];
% sim 1: With Fire (measure Met, Measured Albedo
% sim 2: No soot (Measured Met, No soot)
% sim 3: No Smoke (Mod MET(no smoke), meas albedo)
% im 4: No fire

%
subplot(2,3,2)
plot(timeCRHM(t2016), cumsum(xmelt(t2016, 4)),  'Color', c4); % With fire (observed)
plot(timeCRHM(t2016), cumsum(xmelt(t2016, 2)),  'Color', c2);  % Only smoke (atmospheric - blue)
plot(timeCRHM(t2016), cumsum(xmelt(t2016, 3)),  'Color', c3); % Only soot 
plot(timeCRHM(t2016), cumsum(xmelt(t2016, 1)),  'Color', c1); hold on %No fire
text(timeCRHM(t2016(72)), 4000, 'd) 2016', 'Fontsize', 10);
 xlim([timeCRHM(t2016(1)) timeCRHM(t2016(end))]); 
xticks ([datetime('01-Jul-2016'), datetime( '01-Aug-2016'),datetime( '01-Sep-2016')]);
xticklabels({'01-Jul', '01-Aug', '01-Sep'});
ylim([0 4200]);yticks ([0:1000:4000]);
xtickformat('dd-MMM')
grid on

subplot(2,3,3)
plot(timeCRHM(t2017), cumsum(xmelt(t2017, 1)),  'Color', c1); hold on %No fire
plot(timeCRHM(t2017), cumsum(xmelt(t2017, 2)),  'Color', c2);  % Only smoke (atmospheric - blue)
plot(timeCRHM(t2017), cumsum(xmelt(t2017, 3)),  'Color', c3); % Only soot 
plot(timeCRHM(t2017), cumsum(xmelt(t2017, 4)),  'Color', c4); % With fire (observed)
text(timeCRHM(t2017(72)), 4000, 'e) 2017', 'Fontsize', 10);
 xlim([timeCRHM(t2017(1)) timeCRHM(t2017(end))]); 
xticks ([datetime('01-Jul-2017'), datetime( '01-Aug-2017'),datetime( '01-Sep-2017')]);
xticklabels({'01-Jul', '01-Aug', '01-Sep'});
ylim([0 4200]);yticks ([0:1000:4000]);
xtickformat('dd-MMM')
grid on

subplot(2,3,4)
plot(timeCRHM(t2018), cumsum(xmelt(t2018, 1)),  'Color', c1); hold on %No fire
plot(timeCRHM(t2018), cumsum(xmelt(t2018, 2)),  'Color', c2);  % Only smoke (atmospheric - blue)
plot(timeCRHM(t2018), cumsum(xmelt(t2018, 3)),  'Color', c3); % Only soot 
plot(timeCRHM(t2018), cumsum(xmelt(t2018, 4)),  'Color', c4); % With fire (observed)
text(timeCRHM(t2018(72)), 4000, 'f) 2018', 'Fontsize', 10);
xlim([timeCRHM(t2018(1)) timeCRHM(t2018(end))]); 
xticks ([datetime('01-Jul-2018'), datetime( '01-Aug-2018'),datetime( '01-Sep-2018')]);
xticklabels({'01-Jul', '01-Aug', '01-Sep'});
ylim([0 4200]);yticks ([0:1000:4000]);
xtickformat('dd-MMM')
grid on
ylabel({'Cumulative ice melt';' (mm w.e.)'})

subplot(2,3,5)
plot(timeCRHM(t2019), cumsum(xmelt(t2019, 2)),  'Color', c2);  % Only smoke (atmospheric - blue)
plot(timeCRHM(t2019), cumsum(xmelt(t2019, 4)),  'Color', c4); % With fire (observed)
plot(timeCRHM(t2019), cumsum(xmelt(t2019, 1)),  'Color', c1); hold on %No fire
plot(timeCRHM(t2019), cumsum(xmelt(t2019, 3)),  'Color', c3); % Only soot 
text(timeCRHM(t2019(72)), 4000, 'g) 2019', 'Fontsize', 10);
 xlim([timeCRHM(t2019(1)) timeCRHM(t2019(end))]); 
xticks ([datetime('01-Jul-2019'), datetime( '01-Aug-2019'),datetime( '01-Sep-2019')]);
xticklabels({'01-Jul', '01-Aug', '01-Sep'});
ylim([0 4200]);yticks ([0:1000:4000]);
xtickformat('dd-MMM')
grid on


subplot(2,3,6)
plot(timeCRHM(t2020), cumsum(xmelt(t2020, 2)),  'Color', c2);  hold on% Only smoke (atmospheric - blue)
plot(timeCRHM(t2020), cumsum(xmelt(t2020, 4)),  'Color', c4); % With fire (observed)
plot(timeCRHM(t2020), cumsum(xmelt(t2020, 3)),  'Color', c3); % Only soot 
plot(timeCRHM(t2020), cumsum(xmelt(t2020, 1)),  'Color', c1);  %No fire
text(timeCRHM(t2020(72)), 4000, 'h) 2020', 'Fontsize', 10);
 xlim([timeCRHM(t2020(1)) timeCRHM(t2020(end))]); 
xticks ([datetime('01-Jul-2020'), datetime( '01-Aug-2020'),datetime( '01-Sep-2020')]);
xticklabels({'01-Jul', '01-Aug', '01-Sep'});
ylim([0 4200]);yticks ([0:1000:4000]);
xtickformat('dd-MMM')
grid on

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 0.6;
end

figname = 'CRHM_perSim_CumMelt';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')
%% Hourly melt time series
% days: 
close all
f1 = figure('units','inches','outerposition',[0 0 8 4]);

c1 = 'k';% no fire
c2 =  'b'; % radiation effect
c3 = [0.5 .5 .5]; % albedo effect
c4 = 'r'; % with fire

subplot(2,1,1)
a = find(timeCRHM == '11-Aug-2017')
b = find(timeCRHM == '17-Aug-2017')
p2 = plot(timeCRHM(a:b), xmelt(a:b, 2),'Color', c2); hold on% with smoke
p4 = plot(timeCRHM(a:b), xmelt(a:b, 4), 'Color', c4);% with fire
p3 = plot(timeCRHM(a:b), xmelt(a:b, 3),'Color', c3); % with soot
p1 = plot(timeCRHM(a:b), xmelt(a:b, 1), 'Color', c1);   % no fire
 text(timeCRHM(a+1), 8, 'a) 2017', 'Fontsize', 10);
grid on
ylim([0 9])
yticks([0:2:10])
ylabel({'Hourly melt';'(mm w.e.)'});
lg = legend ([p1(1) p2(1) p3(1) p4(1)], 'No Fire', 'With Smoke', 'With LAI', 'With Fire', 'location', 'northwest','Orientation', 'horizontal')
pos = lg.Position;
lg.Position = pos + [-0.018 +0.115 0 0];


subplot(2,1,2)
a = find(timeCRHM == '11-Aug-2018')
b = find(timeCRHM == '17-Aug-2018')
plot(timeCRHM(a:b), xmelt(a:b, 2),'Color', c2); hold on
plot(timeCRHM(a:b), xmelt(a:b, 4), 'Color', c4);
plot(timeCRHM(a:b), xmelt(a:b, 3),'Color', c3); 
plot(timeCRHM(a:b), xmelt(a:b, 1), 'Color', c1);  
text(timeCRHM(a+1, 1), 8, 'b) 2018', 'Fontsize', 10);
ylim([0 9])
yticks([0:2:9])
grid on
ylabel({'Hourly melt';'(mm w.e.)'});

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 0.6;
end

figname = 'CRHM_perSim_HrlyMelt';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')

 
%% table of daily melt 
% for the two period shown in the graph
a = find(timeCRHM == '11-Aug-2017');
b = find(timeCRHM == '18-Aug-2017');
t_1  = timeCRHM(a:b);
melt_1 =  xmelt(a:b, 1:4);
T = timetable(t_1, melt_1);
TT1 = retime(T, 'daily','sum');

a = find(timeCRHM == '11-Aug-2018');
b = find(timeCRHM == '18-Aug-2018');
t_1  = timeCRHM(a:b);
melt_1 =  xmelt(a:b, 1:4);
T = timetable(t_1, melt_1);
TT2 = retime(T, 'daily','sum');

TT3 = [TT1(1:7, :); TT2(1:7, :)]
dailymelt = table2array(TT3);
dailymelt = round(dailymelt);
dailymelt_t = TT3.t_1;
a = datevec(dailymelt_t);
a = datetime(a(:, 1:3));
T = table(a, dailymelt(:, 1), dailymelt(:, 2), dailymelt(:, 3), dailymelt(:, 4));
lab = {'Date', 'NoFire','WithSmoke','WithLAI','WithFire'}
T.Properties.VariableNames = lab; 

tablename = 'MeltPerDay_perScenario_Aug2017_Aug2018mmwe.csv'
writetable(T, strcat(savedir,tablename))


% column: 
% difference
for i = 1:4;
dailymelt_diff(:, i) = dailymelt (:, i)- dailymelt (:, 1);
end 
T = table(a, dailymelt_diff(:, 1), dailymelt_diff(:, 2), dailymelt_diff(:, 3), dailymelt_diff(:, 4));
lab = {'Date', 'NoFire','WithSmoke','WithLAI','WithFire'}
T.Properties.VariableNames = lab; 

tablename = 'MeltPerDay_Diff_perScenario_Aug2017_Aug2018_mmwe.csv'
writetable(T, strcat(savedir,tablename))


%% Compile some numbers
% annual melt for ach simulation
Sim_Icemelt(1, :) = sum(xmelt(t2015, :)); % melt in 2015 4 scnearios
Sim_Icemelt(2, :) = sum(xmelt(t2016, :));
Sim_Icemelt(3, :) = sum(xmelt(t2017, :));
Sim_Icemelt(4, :) = sum(xmelt(t2018, :));
Sim_Icemelt(5, :) = sum(xmelt(t2019, :));
Sim_Icemelt(6, :) = sum(xmelt(t2020, :));

% column are year, rows ar simulation
% look at % change
Sim_Icemelt_m = round(Sim_Icemelt/1000, 2); % in m w.e.
lab = {'Year', 'NoFire','WithSmoke','WithLAI','WithFire'}
yr = [2015:2020]';
T = table(yr, Sim_Icemelt_m(:, 1),Sim_Icemelt_m(:, 2),Sim_Icemelt_m(:, 3),Sim_Icemelt_m(:, 4));
T.Properties.VariableNames = lab; 

tablename = 'CumulativeMelt_perSeason_perScenario_mwe.csv'
writetable(T, strcat(savedir,tablename))

%% Calculate difference
for i = 1:4;
DiffMelt_m(:, i) = Sim_Icemelt_m(:,i) - Sim_Icemelt_m(:,1);
end 
% difference in % 
for i = 1:4;
DiffMelt_percent(:, i) = Sim_Icemelt_m(:, i)./Sim_Icemelt_m(:, 1).*100;
end 
DiffMelt_percent = round(DiffMelt_percent - 100, 2);

%difference in melt (in mm)
lab = {'Year', 'NoFire','WithSmoke','WithLAI','WithFire'}
yr = [2015:2020]';
T = table(yr, DiffMelt_percent(:, 1),DiffMelt_percent(:, 2),DiffMelt_percent(:, 3),DiffMelt_percent(:, 4));
T.Properties.VariableNames = lab; 

tablename = 'CumulativeMelt_perSeason_perScenario_PercentChange.csv'
writetable(T, strcat(savedir,tablename))
%% end
lab = {'Time', 'Albedo'}
T = table(alb_t, alb(:, 1));
T.Properties.VariableNames = lab; 

tablename = 'iceAWS_Atha_albedo_daily_20152020_filled_clean.csv'
writetable(T, strcat('D:\3_FireandIce\b_data_process\',tablename))

