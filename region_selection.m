% region selection from image
size_of_region = 32;
regions = zeros(size_of_region,size_of_region,1);

% loading image
img = im2double(imread('data/ks_2_30.png'));
plt = figure();
imshow(img);
title(sprintf('press "return" to quit,\n press/click anything else to continue,\n if region selected is greater than %dX%d it is not stored.',size_of_region,size_of_region))

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
        rect(1) = max(rect(1) -round(0.5*(size_of_region-rect(3))),1);
        rect(2) = max(rect(2) - round(0.5*(size_of_region-rect(4))),1);

        if ((rect(1)+rect(3)) > size(img,2))
            rect(1) = size(img, 2) - size_of_region;
        end
        
        if ((rect(2)+rect(4)) > size(img, 1))
            rect(2) = size(img, 1) - size_of_region; 
        end
        
        % ensuring region size is uniform
        rect(3) = size_of_region;
        rect(4) = size_of_region;

        % display selected rectangle
        rectangle('Position',rect,'EdgeColor','r')
        
        %saving rectangle in array
        if( rect(2)>0 && rect(1)>0 && rect(2)+rect(4)<=size(img,1) && rect(1)+rect(3)<=size(img,2))
            regions(:,:,iter) = img(rect(2):rect(2)+rect(4)-1,rect(1):rect(1)+rect(3)-1);
            iter = iter+1;
        end
    end
    
    waitforbuttonpress
end
% saving regions 3D matrix
save('ks_2_30_01.mat','regions')