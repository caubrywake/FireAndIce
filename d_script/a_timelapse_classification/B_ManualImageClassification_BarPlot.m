%% Produce figure of the timelapse image classification derived for 2015-2020
% By Caroline Aubry-Wake, caroline.aubrywake@gmail.com
% edited 2021-11-16
close all
clear all

addpath('D:\FireandIce\function')
savedir = 'D:\FireandIce\output\image_classification\'
figdir = 'D:\FireandIce\fig\fig_timelapse_classification\'

%% Load image classification
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2015.mat')
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2016.mat')
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2017.mat')
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2018.mat')
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2019.mat')
load('D:\FireandIce\output\image_classification\TimelapseImageWeatherType_2020.mat')

%% set color
cclear = [0 102 204]/255; % blue
cmixed = [192 192 192]/255; % ligh gray
ccloudy = [96 96 96]/255;% dark gray
csmoky = [204 102 0]/255;% orange
csmoky_clear = [255 178 102]/255;% light orange
cbad = [0 0 0]/255;% black
cmap = [cclear; cmixed; ccloudy;csmoky_clear;csmoky]
cmap_nosmoke=[cclear; cmixed; ccloudy]
%%
f2 = figure('units','normalized','outerposition',[0 0 .5 .5]);

subplot (6,1,1)
imagesc(datenum(t2015), 1, IDX_2015')
xticks([datenum('01-Jul-2015 11:00') datenum('15-Jul-2015') datenum('01-Aug-2015') datenum('15-Aug-2015') datenum('01-Sep-2015')  datenum('15-Sep-2015')])
colormap(gca, cmap)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);set(gca,'xticklabel',[])
xlim ([datenum(t2015(1)) datenum(t2015(end))]);
hc = colorbar;
hc.Ticks = [0.4 1.1 2 2.8 3.7]
hc.TickLabels = {'sunny'; 'mixed'; 'cloudy';'light smoke';'dense smoke'}
  set(hc,'Position',[.91 .725 .02 .2])
set(hc, 'FontSize', 11);
text (datenum(t2015(1)-9),1, '(a) 2015', 'BackgroundColor', 'w')

subplot (6,1,2)
imagesc(datenum(t2016), 1, IDX_2016')
xticks([datenum('01-Jul-2016 11:00') datenum('15-Jul-2016') datenum('01-Aug-2016') datenum('15-Aug-2016') datenum('01-Sep-2016')  datenum('15-Sep-2016')])
colormap(gca, cmap_nosmoke)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);set(gca,'xticklabel',[])
xlim ([datenum(t2016(1)) datenum(t2016(end))]);
text (datenum(t2016(1)-9),1, '(b) 2016', 'BackgroundColor', 'w')

subplot (6,1,3)
imagesc(datenum(t2017), 1, IDX_2017')
xticks([datenum('01-Jul-2017 11:00') datenum('15-Jul-2017') datenum('01-Aug-2017') datenum('15-Aug-2017') datenum('01-Sep-2017')  datenum('15-Sep-2017')])
colormap(gca, cmap)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);set(gca,'xticklabel',[])
xlim ([datenum(t2017(1)) datenum(t2017(end))]);
text (datenum(t2017(1)-9),1, '(c) 2017', 'BackgroundColor', 'w')

subplot (6,1,4)
imagesc(datenum(t2018), 1, IDX_2018')
xticks([datenum('01-Jul-2018 11:00') datenum('15-Jul-2018') datenum('01-Aug-2018') datenum('15-Aug-2018') datenum('01-Sep-2018')  datenum('15-Sep-2018')])
colormap(gca, cmap)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);set(gca,'xticklabel',[])
xlim ([datenum(t2018(1)) datenum(t2018(end))]);
text (datenum(t2018(1)-9),1, '(d) 2018', 'BackgroundColor', 'w')

subplot (6,1,5)
imagesc(datenum(t2019), 1, IDX_2019')
xticks([datenum('01-Jul-2019 12:00') datenum('15-Jul-2019') datenum('01-Aug-2019') datenum('15-Aug-2019') datenum('01-Sep-2019')  datenum('15-Sep-2019')])
xticklabels ({'01-Jul', '15-Jul','01-Aug', '15-Aug','01-Sep','15-Sep'})
colormap(gca, cmap_nosmoke)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);
set(gca,'yticklabel',[]);set(gca,'xticklabel',[])
xlim ([datenum(t2019(1)) datenum(t2019(end))]);
text (datenum(t2019(1)-9),1, '(e) 2019', 'BackgroundColor', 'w')

subplot (6,1,6)
imagesc(datenum(t2020), 1, IDX_2020')
xticks([datenum('01-Jul-2020 12:00') datenum('15-Jul-2020') datenum('01-Aug-2020') datenum('15-Aug-2020') datenum('01-Sep-2020')  datenum('15-Sep-2020')])
xticklabels ({'01-Jul', '15-Jul','01-Aug', '15-Aug','01-Sep','15-Sep'})
colormap(gca, cmap)
set(gca,'ytick',[]); set(gca,'yticklabel',[]);
xlim ([datenum(t2020(1)) datenum(t2020(end))]);
text (datenum(t2020(1)-9),1, '(f) 2020', 'BackgroundColor', 'w')

% save figure
figname = 'TimeLapseImagery_WxType_perImage_20152020';
saveas(gcf, strcat(figdir, figname), 'png')
saveas(gcf, strcat(figdir, figname), 'pdf')
saveas(gcf, strcat(figdir, figname), 'fig')

  
