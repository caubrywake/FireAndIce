%% Compiling Wx type for each day
% taking the timelapse imagery classification and extracting all days of
% certain types to analyse weatehr conditiosn

close all
clear all

addpath('D:\FireandIce\function')
savedir = 'D:\FireandIce\output\image_classification\'
figdir = 'D:\FireandIce\fig\fig_timelapse_classification\'

%% Load image classification
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2015.mat', 'IDX_2015', 't2015')
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2016.mat', 'IDX_2016', 't2016')
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2017.mat', 'IDX_2017', 't2017')
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2018.mat', 'IDX_2018', 't2018')
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2019.mat', 'IDX_2019', 't2019')
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2020.mat', 'IDX_2020', 't2020')
  
ID = [IDX_2015, IDX_2016, IDX_2017, IDX_2018, IDX_2019, IDX_2020];
time_image = t2015;
clear IDX_2015 IDX_2016 IDX_2017 IDX_2018 IDX_2019 IDX_2020
clear t2016 t2017 t2018 t2019 t2015 t2020 % keep only 

[r, c] = find(isnan(ID))
ID(100,3) = 1; 
ID(163, 5)=2;

%% How many of each type
for i = 1:6 % number of years
E_all(1, i) = numel(find(ID(:,i) == 0 )); % sunny
E_all(2, i) =  numel(find(ID(:,i) == 1)); % mixed
E_all(3, i) =  numel(find(ID(:,i) == 2 )); % cloudy
E_all(4, i) =  numel(find(ID(:,i) == 3 )); % light smoke
E_all(5, i) =  numel(find(ID(:,i) == 4 )); % dense smoke
end 
E_all(:, 7)= sum(E_all(:, 1:6), 2)
E_all(6, :) =  sum(E_all(1:5, :), 1)
NumberofImagesperWxType = E_all;

% Save output as table and matlab variable
varname = {'Sunny'; 'Mixed'; 'Cloudy'; 'LightSmoke'; 'DenseSmoke'; 'Total'};
T = table(varname, E_all(:,1), E_all(:,2), E_all(:,3), E_all(:,4), E_all(:,5), E_all(:,6), E_all(:, 7)) 
headers = {'WxType', 'Y2015','Y2016','Y2017','Y2018','Y2019','Y2020', 'Total'};
T.Properties.VariableNames = headers;
writetable(T, strcat(savedir, 'NumberofImage_PerWxType.txt'))
save (strcat(savedir, 'NumberofImagesperWxType.mat'), 'NumberofImagesperWxType')
clear E_all T varname headers NumberofImagesperWxType time_image
 
%% Classify daily weather type 
% inclucing days with more than 1 tye of weather
% predominently sunny, mixed, predominently cloudy, predominenlty light smoke, predominelty dense smoke
% I only consider days where 2/3 are the same type

IDday = nan(78, 1);
IDday_all = nan(78, 5);
dd = [1:3:length(ID)+1];
for ii = 1:6; % year
for i = 1:length(dd)-1
    d = sort(ID(dd(i):dd(i+1)-1, ii))';

if  d == [0 0 0] | d == [0 0 1] % Predominently sunny
    IDday(i) = 0; % predominently sunny
elseif d == [0 1 1] | d == [1 1 1] |d ==  [1 1 2] | d == [0 2 2]
        IDday(i) = 1; % mixed
elseif d == [1 2 2] | d == [2 2 2]
        IDday(i) = 2; % predominently cloudy
elseif d == [3 3 3] | d == [0 3 3] | d == [1 3 3] | d == [2 3 3] | d == [3 3 4]
        IDday(i) = 3; % predominently  light smoke
 elseif d == [4 4 4] | d == [0 4 4] | d == [1 4 4] | d == [2 4 4] | d == [3 4 4]
        IDday(i) = 4; % predominently  dense smoke
 else 
    IDday(i) = 5;
end 
end 
IDday_all(:, ii) = IDday;
end 
ClassificationofDays_WxType = IDday_all(1:77, :);
time_days = datetime('01-Jul-2015 00:00'):days(1):datetime('15-Sep-2015 00:00');

%% Count the number of days per type
for i = 1:6
E(1, i) = numel(find(IDday_all(:,i) == 0));
E(2, i) =  numel(find(IDday_all(:,i) == 1));
E(3, i) =  numel(find(IDday_all(:,i) == 2));
E(4, i) =  numel(find(IDday_all(:,i) == 3));
E(5, i) =  numel(find(IDday_all(:,i) == 4));
end 
E(:, 7)= sum(E(:, 1:6), 2)
E(6, :) =  sum(E(1:5, :), 1)

NumberofDaysperWxType = E;

% Save output as table and matlab variable
varname = {'Sunny'; 'Mixed'; 'Cloudy'; 'LightSmoke'; 'DenseSmoke'; 'Total'};
T = table(varname, E(:,1), E(:,2), E(:,3), E(:,4), E(:,5), E(:,6), E(:, 7)) 
headers = {'WxType', 'Y2015','Y2016','Y2017','Y2018','Y2019','Y2020', 'Total'};
T.Properties.VariableNames = headers;
writetable(T, strcat(savedir, 'NumberofDays_PerWxType.txt'))
save (strcat(savedir, 'NumberofDayperWxType.mat'), 'NumberofDaysperWxType', 'ClassificationofDays_WxType', 'time_days')

clear d dd E headers T varname NumberofDaysperWxType i ii ID IDday_all
%% Bar plot of Day Wx type
cclear = [0 102 204]/255; % blue
cmixed = [192 192 192]/255; % ligh gray
ccloudy = [96 96 96]/255;% dark gray
csmoky = [204 102 0]/255;% orange
csmoky_clear = [255 178 102]/255;% light orange
cbad = [0 0 0]/255;% black
cmap = [cclear; cmixed; ccloudy;csmoky_clear;csmoky;cbad];
cmap_nosmoke=[cclear; cmixed; ccloudy;cbad];
cmap_nosmoke_nobad=[cclear; cmixed; ccloudy];
cmap_nobad=[cclear; cmixed; ccloudy;csmoky_clear;csmoky];

f3 = figure('units','normalized','outerposition',[0 0 .5 .8]);

subplot (6,1,1)
imagesc(datenum(time_days), 1, ClassificationofDays_WxType(:, 1)')
xticks([datenum('01-Jul-2015 11:00') datenum('15-Jul-2015') datenum('01-Aug-2015') datenum('15-Aug-2015') datenum('01-Sep-2015')  datenum('15-Sep-2015')])
colormap(gca, cmap)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);set(gca,'xticklabel',[])
xlim ([datenum(time_days(1)) datenum(time_days(end))]);
hc = colorbar;
hc.Ticks = [0.5 1.2 2.1 2.9 3.7 4.6]
hc.TickLabels = {'sunny'; 'mixed'; 'cloudy'; 'light smoke';'dense smoke'; 'discarded'}
  set(hc,'Position',[.91 .3 .01 .4])
  hc.TickLength = 0;
set(hc, 'FontSize', 12);
text(datenum(time_days(2)-hours(6)),0.77, '(a) 2015', 'BackgroundColor','w')

subplot (6,1,2)
imagesc(datenum(time_days), 1, ClassificationofDays_WxType(:, 2)')
xticks([datenum('01-Jul-2015 11:00') datenum('15-Jul-2015') datenum('01-Aug-2015') datenum('15-Aug-2015') datenum('01-Sep-2015')  datenum('15-Sep-2015')])
colormap(gca, cmap_nosmoke_nobad)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);set(gca,'xticklabel',[])
xlim ([datenum(time_days(1)) datenum(time_days(end))]);
text(datenum(time_days(2)-hours(6)),0.77, '(b) 2016', 'BackgroundColor','w')

subplot (6,1,3)
imagesc(datenum(time_days), 1, ClassificationofDays_WxType(:, 3)')
xticks([datenum('01-Jul-2017 11:00') datenum('15-Jul-2017') datenum('01-Aug-2017') datenum('15-Aug-2017') datenum('01-Sep-2017')  datenum('15-Sep-2017')])
colormap(gca, cmap)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);set(gca,'xticklabel',[])
xlim ([datenum(time_days(1)) datenum(time_days(end))]);
text(datenum(time_days(2)-hours(6)),0.77, '(c) 2017', 'BackgroundColor','w')

subplot (6,1,4)
imagesc(datenum(time_days), 1, ClassificationofDays_WxType(:, 4)')
xticks([datenum('01-Jul-2015 11:00') datenum('15-Jul-2015') datenum('01-Aug-2015') datenum('15-Aug-2015') datenum('01-Sep-2015')  datenum('15-Sep-2015')])
colormap(gca, cmap)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);set(gca,'xticklabel',[])
xlim ([datenum(time_days(1)) datenum(time_days(end))]);
text(datenum(time_days(2)-hours(6)),0.77, '(d) 2018', 'BackgroundColor','w')

subplot (6,1,5)
imagesc(datenum(time_days), 1, ClassificationofDays_WxType(:, 5)')
xticks([datenum('01-Jul-2015 11:00') datenum('15-Jul-2015') datenum('01-Aug-2015') datenum('15-Aug-2015') datenum('01-Sep-2015')  datenum('15-Sep-2015')])
colormap(gca, cmap)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);set(gca,'xticklabel',[])
xlim ([datenum(time_days(1)) datenum(time_days(end))]);
text(datenum(time_days(2)-hours(6)),0.77, '(e) 2019', 'BackgroundColor','w')

subplot (6,1,6)
imagesc(datenum(time_days), 1, ClassificationofDays_WxType(:,6)')
xticks([datenum('01-Jul-2015 11:00') datenum('15-Jul-2015') datenum('01-Aug-2015') datenum('15-Aug-2015') datenum('01-Sep-2015')  datenum('15-Sep-2015')])
colormap(gca, cmap_nobad)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);
xlim ([datenum(time_days(1)) datenum(time_days(end))]);
xticklabels ({'01-Jul', '15-Jul','01-Aug', '15-Aug','01-Sep','15-Sep'})
text(datenum(time_days(2)-hours(6)),0.77, '(f) 2020', 'BackgroundColor','w')
%
figname = 'TimeLapseImagery_WxType_perDay_20152020';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
