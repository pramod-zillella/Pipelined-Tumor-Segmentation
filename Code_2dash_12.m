clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 15;
tic;
% Read in a demo image.
baseFileName="2'-12.dcm";
grayImage = dicomread(baseFileName);
[rows, columns, numberOfColorChannels] = size(grayImage);
if numberOfColorChannels > 1
  grayImage = grayImage(:, :, 2); % Take green channel.
end
%%
im = J;
im = double(im);
im = mean(im,3);
im2=im;
sz = min(size(im));
% im = im(1:sz,1:sz);
% newsz = 3^floor(log(sz)/log(3));
im = imresize(im,[243,243]);
%

disp('Performing BWT decomposition...');
imbwt = bwt(im);
disp('Reconstructing from BWT coefficients...');
imr = ibwt(imbwt);


d = imr-im;
%figure
%subplot(2,2,1);
%imagesc(im);title('Original');
%subplot(2,2,2);
%imagesc(imbwt);%title('BWT decomposition');
%subplot(2,2,3);
%map=jet;
%colormap(map);
%set(gca,'XTick',[], 'YTick', [])
%imagesc(imr);%title('Reconstruction');
%subplot(2,2,4);
%plot(d(:));
%hold on;
%plot(eps*abs(im(:)),'r');
%plot(-eps*abs(im(:)),'r');
%hold off;
%title('Reconstruction error');

figure
imagesc(imr)
map=jet;
colormap(map);
set(gca,'XTick',[], 'YTick', [])
%
rgbImage = imread("1-16_IMR.png");
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorBands] = size(rgbImage);
%rgbImage = imresize(rgbImage,[243,243]);
% Display the original color image.
figure,
subplot(1, 2, 1);
imshow(rgbImage);
%caption = sprintf('Original Color Image : %s', baseFileName);
title('BWT Feature Map', 'FontSize', fontSize, 'Interpreter', 'None');
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'Outerposition', [0, 0, 1, 1]);
drawnow;
disp('Decomposing BWT coefficients into R G B Channels...');
% Extract the individual red, green, and blue color channels.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

% Display the red channel image.
fontSize = 14;
subplot(2, 6, 4);
imshow(redChannel);
title('Red Channel Image', 'FontSize', fontSize, 'Interpreter', 'None');
% Display the green channel image.
subplot(2, 6, 5);
imshow(greenChannel);
title('Green Channel Image', 'FontSize', fontSize, 'Interpreter', 'None');
% Display the blue channel image.
subplot(2, 6, 6);
imshow(blueChannel);
title('Blue Channel Image', 'FontSize', fontSize, 'Interpreter', 'None');
%
thresholdValue = 150;
%imadjust(skullFreeImage);
%binaryImage = skullFreeImage > thresholdValue;
binaryImage = redChannel > thresholdValue;
%binaryImage=~binaryImage;
%binaryImage = bwareafilt(binaryImage, 1);
seD = strel('disk',2);
%binaryImage = imerode(binaryImage,seD);
binaryImage = imdilate(binaryImage, true(3));
binaryImage = bwareafilt(binaryImage, 1);
%binaryImage = imfill(binaryImage);
% Display the image.
subplot(2, 6, 10);
imshow(binaryImage, []);
%
%binaryImage = imerode(binaryImage,seD);
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(3));
binaryImage = bwareafilt(binaryImage, 1);
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(3));
binaryImage = imdilate(binaryImage, true(2));
binaryImage = bwareafilt(binaryImage, 1);
%binaryImage = imerode(binaryImage,seD);
%binaryImage = imerode(binaryImage,seD);
%binaryImage = imerode(binaryImage,seD);
%binaryImage = imerode(binaryImage,seD);
%labeledImage = bwlabel(binaryImage);
%binaryImage = ismember(labeledImage, 2);
%binaryImage = imfill(binaryImage, 'holes');
%binaryImage = imfill(binaryImage);
binaryImage = imdilate(binaryImage, true(2));
binaryImage = imdilate(binaryImage, true(2));
binaryImage = imdilate(binaryImage, true(2));
binaryImage = imdilate(binaryImage, true(2));
binaryImage = imdilate(binaryImage, true(2));

subplot(2, 6, 11);
imshow(binaryImage, []);
caption = sprintf('Enhanced\n Skull Region'); 
title(caption, 'FontSize', fontSize, 'Color', 'k'); 
%
[r,c]= size(redChannel);
im2= imresize(im2,[r,c]);
outputImage1 = im1; % Initialize
outputImage1(binaryImage) = [0]; % Mask out.

outputImage = redChannel; % Initialize
outputImage(binaryImage) = [0]; % Mask out.

subplot(2, 6, 12);
imshow(outputImage1, []);
caption = sprintf('Estimated\n Brain Region'); 
title(caption, 'FontSize', fontSize, 'Color', 'k'); 
%showMaskAsOverlay(0.8, edges==1, 'g')
%caption = sprintf('Skull-Stripped Image');
%title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
%
thresholdValue = 65;
%imadjust(skullFreeImage);
%binaryImage = skullFreeImage > thresholdValue;
binaryImage = outputImage > thresholdValue;
binaryImage1=binaryImage;
figure, 
subplot(2,4,1)
imshow(binaryImage, []);
title('Segmented Region', 'FontSize', fontSize, 'Interpreter', 'None');

% 
%binaryImage3 = bwareafilt(binaryImage, 3);
%binaryImage = bwareafilt(binaryImage, 1);
%binaryImage = binaryImage2-binaryImage1;
seD = strel('disk',1);
%binaryImage = imerode(binaryImage,seD);
%binaryImage = bwareafilt(binaryImage, 1);
%binaryImage = imdilate(binaryImage, true(3));
%binaryImage = imdilate(binaryImage, true(3));
binaryImage = imfill(binaryImage,'holes');
%binaryImage = bwareafilt(binaryImage, 1);
binaryImage = imerode(binaryImage,seD);
binaryImage = bwareafilt(binaryImage, 1);
binaryImage = imdilate(binaryImage, true(2));
binaryImage = imdilate(binaryImage, true(2));
binaryImage = imdilate(binaryImage, true(2));
binaryImage = imdilate(binaryImage, true(2));
binaryImage = imdilate(binaryImage, true(2));
% Display the image.
subplot(2,4,2)
imshow(binaryImage, []);
title('Segmented Tumor Region', 'FontSize', fontSize, 'Interpreter', 'None');
%
disp('Time Elapsed for Tumor Sgmentation from Brain MRI...');
toc
p = double(binaryImage);
p1=p;

img = dicomread("1-16_Mask.dcm");
q=double(imresize(img,[r,c]));
q1=q;
iou = jaccard(p,q);
iou 
subplot(2,4,3)
imshow(q, []);
title('Ground Truth Mask', 'FontSize', fontSize, 'Interpreter', 'None');

subplot(2,4,4);
im1= imresize(im,[r,c]);
imshow(im1, []);
caption = sprintf('Tumor\nOutlined in red in the overlay'); 
title(caption, 'FontSize', fontSize, 'Color', 'k'); 
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
hold on;
boundaries = bwboundaries(binaryImage);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
	thisBoundary = boundaries{k};
	% Note: since array is row, column not x,y to get the x you need to use the second column of thisBoundary.
	plot(thisBoundary(:,2), thisBoundary(:,1), 'r', 'LineWidth', 1);
end
boundaries1 = bwboundaries(q);
numberOfBoundaries1 = size(boundaries1, 1);
for k = 1 : numberOfBoundaries1
	thisBoundary = boundaries1{k};
	% Note: since array is row, column not x,y to get the x you need to use the second column of thisBoundary.
	plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 1);
end
hold off;
%
p = p(:);
q = q(:);
subplot(2,4,6:7)
cm = confusionchart(p,q);
TP= cm.NormalizedValues(4);
TN= cm.NormalizedValues(1);
FP= cm.NormalizedValues(2);
FN= cm.NormalizedValues(3);
sensitivity = TP / (TP + FN)
specificity = TN / (FP + TN)
Dice_Coefficient = 2*TP /(2*TP + FP + FN)
accuracy = (TP+TN)/(TP+TN+FP+FN)

%%
figure
%subplot(2,4,4);
im1= imresize(im,[r,c]);
imshow(im1, []);
caption = sprintf('Tumor\nOutlined in red in the overlay'); 
title(caption, 'FontSize', fontSize, 'Color', 'k'); 
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
hold on;
%boundaries = bwboundaries(binaryImage);
%numberOfBoundaries = size(boundaries, 1);
%for k = 1 : numberOfBoundaries
%	% Note: since array is row, column not x,y to get the x you need to use the second column of thisBoundary.
%	plot(thisBoundary(:,2), thisBoundary(:,1), 'r', 'LineWidth', 1);
%end

showMaskAsOverlay(0.5,q1,'b');
showMaskAsOverlay(0.2,p1,'r');
hold off;


%showMaskAsOverlay(1,infection,'r');


