function [meanLumArea] = lumDistribution(image, x, y, r)

    square = image(x-r:x+r, y-r:y+r, :);
    
    squareLab = rgb2lab(square);
    
    lumArea = squareLab(:,:,1);
    
    meanLumArea = zeros(100, 100, 3);
    meanLumArea = mean2(lumArea);

end