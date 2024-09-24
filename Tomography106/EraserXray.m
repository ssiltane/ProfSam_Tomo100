% Analyse the X-ray image of an eraser cut in half. 
%
% Samuli Siltanen September 2024

lwidth = 3;
lwidth_thin = 1;
fsize = 22;
bwidth = 10;
profile_wid = 20;
profile_row = 1100;
color_logprofile = [33 116 0]/255;

% Read in the image
im = imread('Eraser4.tif');
im0 = double(im);
im0 = im0/max(max(im0));
[row,col] = size(im0);

% Record min and max values
maxind = find(im0==max(im0(:)));
[maxrow,maxcol]= ind2sub([row,col],maxind(end));
minind = find(im0==min(im0(:)));
[minrow,mincol]= ind2sub([row,col],minind(1));

% Show 2D plot 
im_plot = im0.^.4;
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
%imwrite(im_plot,'Eraser4_optimized.png')


% Show 2D plot with a row highlighted
im_plot = zeros(row,col,3);
im_plot(:,:,1) = im0.^.4;
im_plot(:,:,2) = im0.^.4;
im_plot(:,:,3) = im0.^.4;
% Indicate row from where the profile is taken
im_plot((profile_row-round(profile_wid/2)):(profile_row+round(profile_wid/2)),:,1) = 1;
im_plot((profile_row-round(profile_wid/2)):(profile_row+round(profile_wid/2)),:,2) = 0;
im_plot((profile_row-round(profile_wid/2)):(profile_row+round(profile_wid/2)),:,3) = 0;
% Mark boundaries
im_plot(:,1:bwidth,:) = 0;
im_plot(:,(end-bwidth+1):end,:) = 0;
im_plot(1:bwidth,:,:) = 0;
im_plot((end-bwidth+1):end,:,:) = 0;
% Show
figure(1)
clf
imagesc(im_plot)
colormap gray
axis image
axis off
%imwrite(uint8(255*im_plot),'Eraser4_optimized_profile.png')


% Show 1D profile through the two halves
profile0 = double(im(profile_row,:));
figure(3)
clf
plot(profile0,'r','linewidth',lwidth)
axis([1 length(profile0) 0 4000])
pbaspect([3.5 1.5 1.5]) 
set(gca,'xtick',[1 1000 2000],'fontsize',fsize)
%print -dpng -r400 Eraser4_profile_raw.png


% Show calibrated 1D profile through the two halves
profile1 = log(max(profile0))-log(profile0);
figure(14)
clf
p1 = plot(profile1,'r','linewidth',lwidth);
set(p1,'color',color_logprofile)
axis([1 length(profile0) 0 3])
pbaspect([3.5 1.5 1.5]) 
set(gca,'xtick',[1 1000 2000],'fontsize',fsize)
%print -dpng -r400 Eraser4_profile_lineint.png


% Choose area for 3D plotting
box_row1 = 1;
box_row2 = 900;
box_col1 = 40;
box_col2 = col-40;


% Show 3D plot of (almost) raw pixel values
im1 = double(im(box_row1:box_row2,box_col1:box_col2));
im1 = imresize(im1,[256,NaN]);
figure(25)
clf
mesh(im1)
axis equal
zlim([3270 3500])
set(gca,'xtick',[],'fontsize',fsize)
set(gca,'ytick',[],'fontsize',fsize)
set(gca,'ztick',[3300:100:3500],'fontsize',fsize)
%print -dpng -r400 Eraser4_flatpart_not.png




