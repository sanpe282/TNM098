function centerPointCalc(images)

    centerPoints = zeros(2,12);
    meanRGBVec = zeros(1,12,3);
    meanLumVec = zeros(1,12);
    
    for i = 1:12
        
        dim = size(images{i});
        
        centerRow = ceil(dim(1)/2);
        centerCol = ceil(dim(2)/2);
        
        centerPoints(1,i) = centerRow;
        centerPoints(2,i) = centerCol;
        
        meanRGB = colorDistribution(images{i}, centerRow, centerCol, 100);
        
        meanRGBVec(1,i,1) = meanRGB(1,1)*255;
        meanRGBVec(1,i,2) = meanRGB(1,2)*255;
        meanRGBVec(1,i,3) = meanRGB(1,3)*255;
        
        meanLumVec(1,i) = lumDistribution(images{i}, centerRow, centerCol, 100);

    end
    
    %save cells
    save 'centerPoints' centerPoints; 
    save 'meanRGBVec' meanRGBVec;
    save 'meanLumVec' meanLumVec;  

end