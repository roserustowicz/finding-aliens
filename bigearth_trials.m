%close all
clc

% reading data
img_original = im2double(imread('landsat_kansas_2016_2017.tif'));
figure()
imshow(img_original)

% histogram equalisation - don't use
%img = histeq(img_original);
img = img_original;

% doesn't work well for circles fused together -  try erosion?

% finding circles using hough transform
sensitivity = 0.87;
threshold = 0.01;
[centersBright, radiiBright, metricBright] = imfindcircles(img,[10 30],...
    'ObjectPolarity','bright','EdgeThreshold',threshold,'Sensitivity',sensitivity);
[centersDark, radiiDark, metricDark] = imfindcircles(img,[10 30],...
    'ObjectPolarity','dark','EdgeThreshold',threshold,'Sensitivity',sensitivity);
figure()
hold on
imshow(img)
viscircles(centersBright, radiiBright,'EdgeColor','r');
viscircles(centersDark, radiiDark,'EdgeColor','m');
