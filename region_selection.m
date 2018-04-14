% region selection from image
size_of_region = 64;
regions = zeros(size_of_region,size_of_region,1);

% loading image
img = im2double(imread('landsat_kansas_2016_2017.tif'));
plt = figure();
imshow(img);
title(sprintf('press "return" to quit,\n press/click anything else to continue,\n if region selected is greater than 64X64 it is not stored.'))

key = get(gcf,'CurrentKey');
% run loop until user input
iter = 1;
while(strcmp(get(gcf,'CurrentKey'),'return')~= 1)
    
    % get rectangle from user
    rect = getrect(plt);

    % making selected rectangle a square
    % if(rect(3)>=rect(4))
    %     rect(4) = rect(3);
    % else
    %     rect(3) = rect(4);
    % end

    if (rect(3)<=size_of_region && rect(4)<=size_of_region)    
        % modifying the initial points so that user-defined center is the same
        rect(1) = rect(1) - max(round(0.5*(size_of_region-rect(3))),0);
        rect(2) = rect(2) - max(round(0.5*(size_of_region-rect(4))),0);

        % ensuring region size is uniform
        rect(3) = size_of_region;
        rect(4) = size_of_region;

        % display selected rectangle
        rectangle('Position',rect,'EdgeColor','r')

        %saving rectangle in array
        regions(:,:,iter) = img(rect(2):rect(2)+rect(4)-1,rect(1):rect(1)+rect(3)-1);
        iter = iter+1;
    end
    
    waitforbuttonpress
end
% saving regions 3D matrix
save('ROI','regions')