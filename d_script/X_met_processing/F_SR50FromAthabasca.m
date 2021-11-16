% Athabasca SR50 - cpmpiled 15 min values form raw onice aws data
%%
close all
clear all
savedir = 'D:\FireandIce\output\SR50\'
figdir = 'D:\FireandIce\fig\fig_chrmsim\'

T = importfile_SR50('D:\FireandIce\data_process\ice_aws\Sr50_allyears_15min','Sheet1',5,7589);

%% Fix record to unde time of drill
% 2015
d = table2array(T(:, 2));
t =table2array(T(:, 1));
d(d==-9999)=nan;
plot(t, d);% useless record

%% 2016
d = table2array(T(:, 4));
t =table2array(T(:, 3));
d(d==-9999)=nan;
d(d<=0.5)=nan
d(d>=3.5)=nan;
plot(d);% remove basic spikes
d_fix = d;
d_fix(1302:end) = d_fix(1302:end)+ (d(1301)-d(1302)); 
plot(d_fix)
d_fix(4752:end)=nan;
sr50_2016 = d_fix;
sr50_2016t = t;
plot(sr50_2016t, sr50_2016)
% record after  Aug 18 is not good. Fresh snow?

%% 2017
d = table2array(T(:, 6));
t =table2array(T(:, 5));
d(d==-9999)=nan;
plot(d);
d(1:1966)=nan;
d_fix = d;
d_fix(3409:end) = d_fix(3409:end)+ (d_fix(3407)-d_fix(3409)+0.005); % average for the 30 min watsed
d_fix(d_fix<0.4)=nan;
plot(d_fix)
d_fix(4830:end)=nan;
figure; plot(t, d_fix)
sr50_2017 = d_fix;
sr50_2017t = t;
plot(sr50_2017t, sr50_2017)

%% 2018
d = table2array(T(:, 8));
t =table2array(T(:, 7));
d(d==-9999)=nan;
d(d<= 0.5)=nan;
d(d>= 4.3)=nan;
plot(d);
d_fix = d;
d_fix(1981:end) = d_fix(1981:end)+ (d_fix(1974)-d_fix(1981)+0.005); % average for the 30 min watsed
d_fix([1980, 3039, 4153])=nan;
plot(d_fix)
d_fix(4959:end) = d_fix(4959:end)+ (d_fix(4946)-d_fix(4959)+0.005); % average for the 30 min watsed

figure; plot(t, d_fix)
sr50_2018 = d_fix;
sr50_2018t = t;
plot(sr50_2018t, sr50_2018)

%% 2019
d = table2array(T(:, 10));
t =table2array(T(:, 9));
plot(d);
d_fix = d;
d_fix(2264:end) = d_fix(2264:end)+ (d_fix(2257)-d_fix(2264)+0.018); % average for the 30 min watsed
d_fix(d_fix<=0.52)=nan;
d_fix(5140:end) = d_fix(5140:end)+ (d_fix(5137)-d_fix(5140)+0.005); % average for the 30 min watsed
d_fix(d_fix<=0.5)=nan;
d_fix(5138:5139)=nan;
plot(d_fix)
sr50_2019 = d_fix;
sr50_2019t = t;
plot(sr50_2019t, sr50_2019)

%% 2020
d = table2array(T(:, 12));
t =table2array(T(:, 11));
plot(d);
d_fix = d;
d_fix(1:1401)=nan;
plot(d_fix)

% fix redrill 1
d_fix(4180:end) = d_fix(4180:end)+ (d_fix(4179)-d_fix(4180)); % average for the 30 min watsed
d_fix(d_fix ==0)=nan;
d_fix([3653, 3677, 3684, 3686])= nan;
d_fix(d_fix==2.439)=nan;
sr50_2020 = d_fix;
sr50_2020t = t;
plot(sr50_2020t, sr50_2020)

%% save output
T = table(sr50_2016t, sr50_2016, ...
    sr50_2017t, sr50_2017, ...
    sr50_2018t, sr50_2018, ...
    sr50_2019t, sr50_2019, ...
    sr50_2020t, sr50_2020);
writetable(T,strcat(savedir, 'SR50_peryear_15min_clean.csv'))
save(strcat(savedir, 'SR50_peryear_15min_clean'), 'sr50_2016t', 'sr50_2016', ...
    'sr50_2017t', 'sr50_2017', ...
    'sr50_2018t', 'sr50_2018', ...
   'sr50_2019t', 'sr50_2019', ...
    'sr50_2020t', 'sr50_2020')
%%
%  load('D:\FireandIce\CRHMModel\Various\Athabasca_SR50.mat')
% % fix the records
% 
% % 2016
% % time of redrill
% t = datetime([SR502016(:, 1:3), zeros(length(SR502016(:, 1)), 3)])
% d = SR502016(:, 4)
% plot(t, d)
% tx = {'11-Jun-2016';'15-Jul-2016';'20-Aug-2016'}
% d2  = d;
% for i = 1:length(tx)
% t1 = find(t == datetime(tx{i}))
% 
% d2(t1:end) = d2(t1:end) + (d2(t1-2)-d2(t1))
% d2(t1-1) = nan
% end 
% d2 = fillmissing(d2, 'linear')
% plot(t, d2)
% SR502016_fix =-d2+d2(1);
% t2016 = t;
% 
% %%$%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 2015
% % time of redrill
% t = datetime([SR502015(:, 1:3), zeros(length(SR502015(:, 1)), 3)])
% d = SR502015(:, 4)
% plot(t, d); hold on
% tx = {'25-Jul-2015'}
% d2  = d;
% for i = 1:length(tx)
% t1 = find(t == datetime(tx{i}))
% 
% d2(t1:end) = d2(t1:end) + (d2(t1-2)-d2(t1))
% d2(t1-1) = nan
% end 
% d2 = fillmissing(d2, 'linear')
% plot(t, d2)
% SR502015_fix = -d2+d2(1);
% t2015 = t;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 2017
% % time of redrill
% t = datetime([SR502017(:, 1:3), zeros(length(SR502017(:, 1)), 3)])
% d = SR502017(:, 4)
% plot(t, d); hold on
% tx = {'06-Aug-2017'}
% d2  = d;
% for i = 1:length(tx)
% t1 = find(t == datetime(tx{i}))
% 
% d2(t1:end) = d2(t1:end) + (d2(t1-2)-d2(t1))
% d2(t1-1) = nan
% end 
% d2 = fillmissing(d2, 'linear')
% plot(t, d2)
% SR502017_fix =-d2+d2(1);
% t2017 = t;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 2018
% % time of redrill
% t = datetime([SR502018(:, 1:3), zeros(length(SR502018(:, 1)), 3)])
% d = SR502018(:, 4)
% plot(t, d); hold on
% tx = {'22-Jul-2018';'21-Aug-2018'}
% d2  = d;
% for i = 1:length(tx)
% t1 = find(t == datetime(tx{i}))
% 
% d2(t1:end) = d2(t1:end) + (d2(t1-2)-d2(t1))
% d2(t1-1) = nan
% end 
% d2 = fillmissing(d2, 'linear')
% SR502018_fix = -d2+d2(1);
% t2018 = t;
% % plot them all
% plot (t2015, SR502015_fix); hold on
% plot (t2016, SR502016_fix)
% plot (t2017, SR502017_fix)
% plot (t2018, SR502018_fix)
% 
% % 2020
% %% Clean SR50 2020
% load('D:\FireandIce\data_raw\ice_aws\SR502020.mat')
% plot(sr50); hold on
% sr50_fix = sr50;
% % create the temporary sr50 record to find th values to fix
% sr50_temp = sr50_fix;
% sr50_temp([1300:end])=nan;
% a = find(sr50_temp>= 2.8);
% b = find(sr50_temp<= 2.1);
% sr50_fix(a) = nan;
% sr50_fix(b)=nan;
% hold on
% plot(sr50_fix)
% 
% sr50_temp = sr50_fix;
% sr50_temp([1:1200, 1300:end])=nan;
% a = find(sr50_temp>= 2.489);
% sr50_fix(a) = nan;
% plot(sr50_fix)
% 
% sr50_temp = sr50_fix;
% sr50_temp([1:2000, 2200:end])=nan;
% a = find(sr50_temp<= 2.5);
% sr50_fix(a) = nan;
% hold on
% plot(sr50_fix)
% 
% sr50_temp = sr50_fix;
% sr50_temp([1:3550, 3590:end])=nan;
% a = find(sr50_temp>=4.3);
% sr50_fix(a) = nan;
% hold on
% plot(sr50_fix)
% 
% sr50_temp = sr50_fix;
% sr50_temp([1:5800])=nan;
% a = find(sr50_temp<=5);
% sr50_fix(a) = nan;
% hold on
% plot(sr50_fix)
% 
% close all
% plot(sr50t, sr50_fix)
% 
% T = timetable(sr50t, sr50_fix);
% TT = retime(T, 'daily', 'mean');
% TTT = timetable2table(TT);
% writetable(TTT, 'D:\FireandIce\data_process\ice_aws\SR50_fix_daily_2020.csv')