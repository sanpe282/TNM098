function multiplePointsCalc(images)

    points = zeros(2,5);
    meanRGBVec = zeros(3,12);
    meanLumMat = zeros(5,12);
    
    for i = 1:12
        
        % Create five points
        dim = size(images{i});
        
        centerRow = ceil(dim(1)/2);
        centerCol = ceil(dim(2)/2);
        
        %  -----------
        % |     1     |
        % |  2  3  4  |
        % |     5     |
        %  -----------
        
        % Point 1
        points(1,1) = centerRow;
        points(2,1) = ceil(centerCol/2);
        
        % Point 2
        points(1,2) = ceil(centerRow/2);
        points(2,2) = centerCol;
       
        % Point 3
        points(1,3) = centerRow;
        points(2,3) = centerCol;
        
        % Point 4
        points(1,4) = ceil(centerRow/2) + centerRow;
        points(2,4) = centerCol;
        
        % Point 5
        points(1,5) = centerRow;
        points(2,5) = ceil(centerCol/2) + centerCol;

        for j = 1:5
            
            meanRGB = colorDistribution(images{i}, points(1,j), points(2,j), 100);
            meanRGBMat(j,i,1) = meanRGB(1,1)*255;
            meanRGBMat(j,i,2) = meanRGB(1,2)*255;
            meanRGBMat(j,i,3) = meanRGB(1,3)*255;
            
        end
        
        for j = 1:5
            
            meanLumMat(j,i) = lumDistribution(images{i}, points(1,j), points(2,j), 100);
            
        end
    end
    
    % Save cells
    save 'points' points; 
    save 'meanRGBMat' meanRGBMat;
    save 'meanLumMat' meanLumMat; 

end