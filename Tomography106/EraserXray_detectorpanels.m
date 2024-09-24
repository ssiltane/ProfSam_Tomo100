% Analyse the X-ray image of an eraser cut in half. 
%
% Samuli Siltanen August 2024

lwidth = 3;
lwidth_thin = 1;
fsize = 22;
bwidth = 10;
profile_wid = 20;
profile_row = 1100;

% Read in the image
im = imread('../images/Eraser4.tif');
im0 = double(im);
im0 = im0/max(max(im0));
[row,col] = size(im0);

% Show 2D plot of inverted image
im_plot = 1-im0;
im_plot(:,1:bwidth) = 0;
im_plot(:,(end-bwidth+1):end) = 0;
im_plot(1:bwidth,:) = 0;
im_plot((end-bwidth+1):end,:) = 0;
figure(1)
clf
imagesc(im_plot)
colormap gray
axis image
axis off
imwrite(im_plot,'../images/Eraser4_inverted.png')


% Show extremely filtered plot of inverted image
D = .9;
im_plot = (1+D)*im_plot-D;
im_plot = max(0,im_plot);
im_plot = im_plot.^18;
H = 20;
im_plot = (1+H)*im_plot;
im_plot = min(1,im_plot);
im_plot = im_plot.^1.2;
figure(2)
clf
imagesc(im_plot)
colormap gray
axis image
axis off
imwrite(im_plot,'../images/Eraser4_inverted_optimized.png')


