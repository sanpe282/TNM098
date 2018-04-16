function [meanRGBArea] = colorDistribution(image, x, y, r)

    square = image(x-r:x+r, y-r:y+r, :);
    
    meanR = mean2(square(:,:,1));
    meanG = mean2(square(:,:,2));
    meanB = mean2(square(:,:,3));

    meanRGBArea = zeros(100, 100, 3);
    meanRGBArea(:,:,1) = meanR/255;
    meanRGBArea(:,:,2) = meanG/255;
    meanRGBArea(:,:,3) = meanB/255;
    
%     figure
%     subplot(1,2,1);
%     imshow(square);
%     subplot(1,2,2);
%     imshow(meanRGBArea);

end