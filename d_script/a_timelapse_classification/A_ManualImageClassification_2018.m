%% Manual Selection, 2018
close all
clear all
dirsave = 'D:\FireandIce\output\image_classification\'; % to save the results in the right folder
figdir =   'D:\FireandIce\fig\fig_timelapse_classification\';

%% 1 - Import images and select period
imdir=  'D:\FireandIce\data_raw\moraine_timelapse\2018\';
imagefiles = dir(strcat(imdir, '*.JPG'));   % load all the images located in that directory
nfiles = length(imagefiles); %the number of files

% Select the one between July1 and Sept15
d = datetime(string(extractfield(imagefiles, 'date'))); 
t1 = find(d == datetime('01-Jul-2018 10:00:02'));
t2 = find(d == datetime('15-Sep-2018 16:00:02'));
imagefiles = imagefiles(t1:t2);% select only images in that that time period
t = datetime(string(extractfield(imagefiles, 'date'))); 
clear t1 t2 d 

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
[val, idx_smoky_clear] = clicksubplot_keeph;% 2018 didnt have any fire
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
idx_sunny = sort([idx_sunny 201 202]); % 
idx_cloudy =sort([idx_cloudy  203 204 80 81 89 90 189]); % 
idx_mixed = sort([idx_mixed 71 56 111 187]); %
idx_smoky_clear =sort([idx_smoky_clear]); % 
idx_smoky_cloudy = sort([idx_smoky_cloudy]); 
%  a = find(idx_mixed==24); idx_mixed(a) =[];
all_idx = sort([idx_sunny, idx_cloudy , idx_mixed , idx_smoky_cloudy , idx_smoky_clear ]);
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
%% Rename and aave matlab IDX file and string as table
T = table(t', IDX_str, IDX);
headers = {'Date','WeatherType','WeatherCode'}
T.Properties.VariableNames = headers;
%%%%%%%%%%%%%%%%%%%%%%%%%% Change name for each year!
IDX_str_2018 = IDX_str;
IDX_2018=IDX;
t2018 = t; 
writetable( T, strcat(dirsave, 'Table_TimelapseImageWeatherType_2018.txt'))
save(strcat(dirsave, 'TimelapseImageWeatherType_2018.mat'), 'IDX_2018', 'IDX_str_2018', 't2018')

