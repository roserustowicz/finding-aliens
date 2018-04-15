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
threshold = 0.01;
[centersBright, radiiBright, metricBright] = imfindcircles(img,[10 30],...
    'ObjectPolarity','bright','EdgeThreshold',threshold,'Sensitivity',0.86);
[centersDark, radiiDark, metricDark] = imfindcircles(img,[10 30],...
    'ObjectPolarity','dark','EdgeThreshold',threshold,'Sensitivity',0.87);
figure()
hold on
imshow(img)
viscircles(centersBright, radiiBright,'EdgeColor','r');
viscircles(centersDark, radiiDark,'EdgeColor','m');

% finding area of circles
areasBright = pi.*(radiiBright.^2);
areasDark = pi.*(radiiDark.^2);

rows = size(img,1);
cols = size(img,2);
% finding average intensity within circle
intensityBright = zeros(length(centersBright),1);
for iter = 1:length(centersBright)
    % selecting parameters
    center = centersBright(iter,:);
    radius = radiiBright(iter);
    
    % finding mask corresponding to circle
    mask = zeros(size(img));
    for i = 1:rows
        for j = 1:cols
            if((i-center(2))^2 + (j-center(1))^2 <= radius^2 )
                mask(i,j)= 1;
            end
        end
    end
        
    intensities = mask.*img;
    intensities = intensities(intensities > 0);
    intensityBright(iter) = nanmean(intensities);
end

intensityDark = zeros(length(centersDark),1);
for iter = 1:length(centersDark)
    % selecting parameters
    center = centersDark(iter,:);
    radius = radiiDark(iter);
    
    % finding mask corresponding to circle
    mask = zeros(size(img));
    for i = 1:rows
        for j = 1:cols
            if((i-center(2))^2 + (j-center(1))^2 <= radius^2 )
                mask(i,j)= 1;
            end
        end
    end
        
    intensities = mask.*img;
    intensities = intensities(intensities > 0);
    intensityDark(iter) = nanmean(intensities);
end
