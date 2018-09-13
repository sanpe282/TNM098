function [meanRGBArea] = colorDistribution(image, x, y, r)

    square = image(x-r:x+r, y-r:y+r, :);
    
    meanR = mean2(square(:,:,1));
    meanG = mean2(square(:,:,2));
    meanB = mean2(square(:,:,3));

    meanRGBArea = zeros(1, 3);
    meanRGBArea(1,1) = meanR/255;
    meanRGBArea(1,2) = meanG/255;
    meanRGBArea(1,3) = meanB/255;
   
end