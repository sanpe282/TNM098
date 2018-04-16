function centerColor(images)

    centerPoints = zeros(2,12);
    
    for i = 1:12
        
        dim = size(images{i});
        
        centerRow = ceil(dim(1)/2);
        centerCol = ceil(dim(2)/2);
        
        centerPoints(1,i) = centerRow;
        centerPoints(2,i) = centerCol;
        
        colorDistribution(images{i}, centerRow, centerCol, 100);
        lumDistribution(images{i}, centerRow, centerCol, 100);

    end
    
    %save cells
    save 'centerPoints' centerPoints; 

end