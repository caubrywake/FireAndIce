%% Manual Selection, 2020
close all
clear all
dirsave = 'D:\FireandIce\output\image_classification\'; % to save the results in the right folder
figdir =   'D:\FireandIce\fig\fig_timelapse_classification\';

%% 1 - Import images and select period
imdir=  'D:\FireandIce\data_raw\moraine_timelapse\2020\';
imagefiles = dir(strcat(imdir, '*.JPG'));   % load all the images located in that directory
nfiles = length(imagefiles); %the number of files

%% Create the time array for all the images
d = datetime(string(extractfield(imagefiles, 'date'))); 
t2 = find(d == datetime('11-Aug-2020 16:00:02'));
d1 = d(1:t2);

d2 = datetime('12-Aug-2020 10:00'):hours(3):datetime('12-Aug-2020 16:00')';
d3 = repmat(d2', 20, 1);
d4 = datevec(d3);
d5 = d4;
for i = 4:3:length(d4)
    d5(i:i+2, 3) =  d5(i-3:i-1, 3) +1
end 
AugDay = d5;
%Sept
d2 = datetime('01-Sep-2020 10:00'):hours(3):datetime('01-Sep-2020 16:00')';
d3 = repmat(d2', 15, 1);
d4 = datevec(d3);
d5 = d4;
for i = 4:3:length(d4)
    d5(i:i+2, 3) =  d5(i-3:i-1, 3) +1
end 
SepDay = d5;
D = [d1'; datetime([AugDay ;SepDay])];

% Select the one between July1 and Sept15
t1 = find(D == datetime('01-Jul-2020 10:00:02'));
t2 = find(D == datetime('15-Sep-2020 16:00:00'));
t = D(t1:t2);
imagefiles = imagefiles(t1:t2);% select only images in that that time period
clear t1 t2 d  SepDay AugDay d1 d2 d3 d4 d5
%% Manual selection of images
% thiscreates a figure with half the images
% for the time period


close all
f1 = figure('units','normalized','outerposition',[0 0 1 1]);
CROP = [1 1 3264 1346]; % image area focugin on the visible sky

for ii=1:numel(t)
   fn = strcat(imagefiles(ii).folder, '\',imagefiles(ii).name);
   t(ii) =  datetime(datevec(imagefiles(ii).datenum));
   im = imread(fn);
   cropped = imcrop(im, CROP);
   
  subplot (12,21, ii);
  imagesc(cropped);
  set(gca,'YTickLabel',[]);
  set(gca,'XTickLabel',[]);
  set(gca,'tag',num2str(ii))
end 
jointfig(f1,12, 21)
%% Click on the image, double click on last selection, then esc
%1  Sunny, Mixed,  Cloudy, Light Smoky, Dense Snoke
[val, idx_sunny] = clicksubplot_keeph; 
[val, idx_mixed] = clicksubplot_keeph;
[val, idx_cloudy] = clicksubplot_keeph; 
[val, idx_smoky_clear] = clicksubplot_keeph;% 2020 didnt have any fire
[val, idx_smoky_cloudy] = clicksubplot_keeph;

%% Remove  initial zero (artifact of the clicksubplot function)
idx_sunny = idx_sunny(2:end);
idx_mixed = idx_mixed(2:end);
idx_cloudy = idx_cloudy(2:end);% 
 idx_smoky_clear = idx_smoky_clear(2:end);% 
 idx_smoky_cloudy = idx_smoky_cloudy(2:end);

%% Remove accidental double 
idx_sunny = unique([idx_sunny]);
idx_mixed = unique([idx_mixed]);
idx_cloudy = unique([idx_cloudy]);% 
 idx_smoky_clear = unique([idx_smoky_clear]);% 
 idx_smoky_cloudy = unique([idx_smoky_cloudy]);
%% Find missing images and include them in the idx array
all_idx = sort([idx_sunny, idx_cloudy , idx_mixed , idx_smoky_cloudy , idx_smoky_clear ]);
numel(all_idx) % if this is different tahn numel(t), some images were skipped
figure; plot(all_idx); 
% missed 
idx_sunny = sort([idx_sunny ]); % 
idx_cloudy =sort([idx_cloudy 29 54 55 57]); % 
idx_mixed = sort([idx_mixed 215 30]); %
% idx_smoky_clear =sort([idx_smoky_clear]); % 
% idx_smoky_cloudy = sort([idx_smoky_cloudy]); 
%  a = find(idx_mixed==24); idx_mixed(a) =[];
all_idx = sort([idx_sunny, idx_cloudy , idx_mixed]);
numel(all_idx) % if this is different tahn numel(t), some images were skipped

%% compile result with different number for each weather type
IDX = nan(length(imagefiles),1);
IDX(idx_sunny)=0;
IDX(idx_mixed)=1;
IDX(idx_cloudy)=2;
IDX(idx_smoky_clear)=3;
IDX(idx_smoky_cloudy)=4;

%% Create a file with weather type as string instead
IDX_str = strings(length(imagefiles),1);
IDX_str(idx_sunny)='sunny';
IDX_str(idx_mixed)='mixed';
IDX_str(idx_cloudy)='cloudy';
IDX_str(idx_smoky_clear)='light smoke';
IDX_str(idx_smoky_cloudy)='dense smoke';
%% Rename and save matlab IDX file and string as table
T = table(t, IDX_str, IDX);
headers = {'Date','WeatherType','WeatherCode'}
T.Properties.VariableNames = headers;
%%%%%%%%%%%%%%%%%%%%%%%%%% Change name for each year!
IDX_str_2020 = IDX_str;
IDX_2020=IDX;
t2020 = t; 
writetable( T, strcat(dirsave, 'Table_TimelapseImageWeatherType_2020.txt'))
save(strcat(dirsave, 'TimelapseImageWeatherType_2020.mat'), 'IDX_2020', 'IDX_str_2020', 't2020')

