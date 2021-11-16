function plot_metperWxtype_peryear (MET)

c1 = [0 102 204]/255; % blue
c2 = [192 192 192]/255; % ligh gray
c3 = [96 96 96]/255;% dark gray
c4 = [255 178 102]/255;% light orange
c5 = [204 102 0]/255;% orange

fig = figure('units', 'inches', 'position', [0 0 8 6]);
sz = size(MET);


if sz(3) == 3 % no fire year
i = 1; 
subplot(2,3,i); plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3);
xlim ([1 24])
ylabel ('Ta (C)')
i = 2; 
subplot(2,3,i);plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3);
xlim ([1 24])
ylabel ('RH (%)')
i = 3;
subplot(2,3,i); plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3);
xlim ([1 24])
ylabel ('U (m/s)')
i = 4; 
subplot(2,3,i);plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3);
xlim ([1 24])
ylabel ('SWin(W/m2)')
i = 5;
subplot(2,3,i); plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3);
xlim ([1 24])
ylabel ('LWin (W/m2)')
% just for legend
subplot(2,3,6); plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3);
xlim ([100 200])
legend ('Sunny', 'Mix Sun-Cloud', 'Cloud')
xticklabels ([]);yticklabels ([])

else 
i = 1; 
subplot(2,3,i); plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3); plot(MET(:, i, 4), 'Color', c4); plot(MET(:, i, 5), 'Color', c5); 
xlim ([1 24])
ylabel ('Ta (C)')
i = 2; 
subplot(2,3,i); plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3); plot(MET(:, i, 4), 'Color', c4); plot(MET(:, i, 5), 'Color', c5); 
xlim ([1 24])
ylabel ('RH (%)')
i = 3;
subplot(2,3,i); plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3); plot(MET(:, i, 4), 'Color', c4); plot(MET(:, i, 5), 'Color', c5); 
xlim ([1 24])
ylabel ('U (m/s)')
i = 4; 
subplot(2,3,i); plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3); plot(MET(:, i, 4), 'Color', c4); plot(MET(:, i, 5), 'Color', c5); 
xlim ([1 24])
ylabel ('SWin(W/m2)')
i = 5; 
subplot(2,3,i); plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3); plot(MET(:, i, 4), 'Color', c4); plot(MET(:, i, 5), 'Color', c5); 
xlim ([1 24])
ylabel ('LWin (W/m2)')
subplot(2,3,6); plot(MET(:, i, 1), 'Color', c1); hold on;plot(MET(:, i, 2), 'Color', c2); plot(MET(:, i, 3), 'Color', c3); plot(MET(:, i, 4), 'Color', c4); plot(MET(:, i, 5), 'Color', c5); 
xlim ([100 200])
legend ('Sunny', 'Mix Sun-Cloud', 'Cloud', 'Light Smoke', 'Dense Smoke')
xticklabels ([]);yticklabels ([])
end 
% just to get the legend% just to get the legend