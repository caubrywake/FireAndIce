%% Albedo for AWSice
% preprocessed the raw data in R to create one hourly and one daily SWin
% SWouT, albedo file

%% Setup
close all
clear all

addpath('D:\FireandIce\function')
savedir = 'D:\FireandIce\output\met_analysis\'
figdir = 'D:\FireandIce\fig\fig_met_analysis\'
outputdir = 'D:\FireandIce\output\met_analysis\' % for data processed

%% load data 
fn = 'D:\3_FireandIce\a_data\albedo.txt'
D = importdata(fn);
t = string(D.textdata(2:end, 1));
albedot_hr = datetime(t, 'inputformat', 'yyyy MM dd HH mm');
albedo_hr = D.data;
clear D

T = table(albedot_hr, albedo_hr(:, 1), albedo_hr(:, 2), albedo_hr(:, 3));
headers = {'time', 'SWin','SWout','albedo'};
T.Properties.VariableNames = headers;
writetable(T, 'D:\3_FireandIce\a_data\ice_aws\iceAWS_SWin_SWout_albedo_1hr_2014_2020.csv')


fn = 'D:\FireandIce\data_process\ice_aws\AthabascaIce_1day_albedo.obs'
D = importfile_albedoobs(fn,7, 2205);
albday_t = datetime([D(:, 1:5), zeros(length(D), 1)]);
albday = D(:, 6:8);
clear D

save (strcat(savedir, 'iceAWS_albedo_hourly_daily.mat'), 'albday', 'albday_t','albhr','albhr_t');
%% Calculate albedo
albhr_calc = albhr(:, 2)./albhr(:, 1);
albhr_calc(albhr_calc<0) = nan;
albhr_calc(albhr_calc>1)= nan;
plot(albhr_t, albhr_calc);

% remove all the dat that is out of 10-2pm
t = datevec(albhr_t);
hr = t(:, 4);
hr(hr<=10) = nan;
hr(hr>=14) = nan;
x = find(isnan(hr));
albhr_calc(x) = nan;

% retime to daily
T = timetable(albhr_t, albhr_calc);
TT = retime(T, 'daily',@(x) mean(x, 'omitnan'));
albhr_calc_todaily = table2array(TT);
albhr_calc_todaily_t = TT.albhr_t;

%% Daily values
albday_calc = albday(:, 2)./albday(:, 1);
albday_calc(albhr_calc<0) = nan;
albday_calc(albday_calc>1)= nan;

%% Fill missing for both type
albday_calc_fill = fillmissing(albday_calc, 'nearest')% 'MaxGap', 4);
albday_calc_fill(1080:1101) = albday_calc_fill(1080);
plot(albday_t, albday_calc_fill);hold on
plot(albday_t, albday_calc); 


albhr_calc_todaily_fill = fillmissing(albhr_calc_todaily,'nearest');
albhr_calc_todaily_fill(1080:1101) = albhr_calc_todaily_fill(1080);
plot(albday_t, albhr_calc_todaily_fill);hold on
plot(albday_t, albhr_calc_todaily); 

%% Save matlab output of the albedo *** This is my final albedo ****
save (strcat(savedir, 'iceAWS_albedo_dailyfrommidday_filled.mat'), 'albhr_calc_todaily_fill', 'albhr_calc_todaily_t','albhr','albhr_calc_todaily');
alb = albhr_calc_todaily;
alb_t = albday_t;
%% FINAL albedo
save (strcat(savedir, 'albedo_iceathabasca_daily_clean_20152020.mat'), 'alb', 'alb_t');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compare the two (daily from midday hourly values and daily from daily averagwe
figure
plot(albhr_calc_todaily_t, albhr_calc_todaily_fill)
hold on 
plot(albday_t, albday_calc_fill);
legend ('midday average','daily average')

%% Plot only for melt season
% find start and end
t = albday_t;
tvec = datevec(t);
tstart = find(tvec(:, 2)==7 & tvec(:, 3)==1 & tvec(:, 4) == 0);
t(tstart) % making sure its Juy 1st

tend = find(tvec(:, 2)==9 & tvec(:, 3)==15 & tvec(:, 4) == 0);
t(tend) % making sure its Sept 15
tend = tend(2:end);
yr = 2015:2020;

%% Figure
f1 = figure(1)
f1.Units = 'inches'
f1.Position = [0 0 8 5];

for i =1:6;
    subplot(2,3,i)
    plot(albday_t(tstart(i):tend(i)), albhr_calc_todaily(tstart(i):tend(i)), 'linewidth',1); hold on
    plot(albday_t(tstart(i):tend(i)), albday_calc(tstart(i):tend(i)), 'linewidth',1); 
    title (num2str(yr(i)))
    ylim([0 1])
    xlim ([albday_t(tstart(i)) albday_t(tend(i))])
   
    if i == 3;
    legend ('from mid-day hourly values', 'from daily averages', 'location', 'best')
    ylabel ('Albedo')
    end 
end 

figname = 'iceAWS_albedo_permeltseason_daily_midday';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')

%% We keep only the daily values
% plot them together
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
    plot(albday_t(tstart(1):tend(1)),alb(tstart(i):tend(i)), 'linewidth',0.7, 'color', cm(i, :)); hold on
    ylim([0.1 1])
   
end 
ylabel ('Albedo (-)')
xlim ([albday_t(tstart(1)) albday_t(tend(1))])
 
legend ('2015','2016','2017','2018','2019','2020', 'location', 'NorthWest')
figname = 'iceAWS_albedo_permeltseason_daily';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')


%% Average albedo  of whole season
for i =1:6;
Alb_meltseason(1, i) = nanmean(alb(tstart(i):tend(i)))
Alb_meltseason(2, i) = min(alb(tstart(i):tend(i)))
end 

headers = {'Y2015','Y2016', 'Y2017','Y2018','Y2019','Y2020'};
T = table(Alb_meltseason(:,1), Alb_meltseason(:,2), Alb_meltseason(:,3), Alb_meltseason(:,4), Alb_meltseason(:,5), Alb_meltseason(:,6) );
T.Properties.VariableNames = headers;
writetable(T, strcat(outputdir, 'MeanAlbedoPerYear_Jul01toSep15.csv'))

%% Average for middle of period
% find start and end
t = albday_t;
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
writetable(T, strcat(outputdir, 'MeanAlbedoPerYear_Jul20toAug20.csv'))

%% Export daily albedo as an CRHM obs file
t = datevec(albhr_calc_todaily_t);
t = t(:, 1:5); % keep only the first column as we don't need seconds in the CRHM obs format
% change the hours to 1AM to fit with CRHM
t(:, 4) = 1;

alb = [t albhr_calc_todaily_fill];                  
headerlines = {'Obs file from for Athabasca on-ice station, daily albedo';
'alb	1	()'														
'################	alb'}
filepath = strcat(savedir, 'iceAWS_alb_daily.obs')
fid = fopen(filepath, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(filepath, alb, '-append', 'delimiter', '\t');  
