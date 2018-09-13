function compareImage(comparison, theImage)

    % Load 
    load ('colorContent');
    load ('meanRGBVec');
    load ('meanLumVec');
    load ('meanRGBMat');
    load ('meanLumMat');
    
    disp('')
    disp(['Image: ', num2str(theImage)]);
    
    featureVecImages = zeros(27, 12);
    
    % 1. Create feature vector for all images
    for i = 1:12
        
        % Color content
        featureVecImages(1,i) = colorContent(1,i,1);
        featureVecImages(2,i) = colorContent(1,i,2);
        featureVecImages(3,i) = colorContent(1,i,3);
        
        % Mean RGB, one point
        featureVecImages(4,i) = meanRGBVec(1,i,1);
        featureVecImages(5,i) = meanRGBVec(1,i,2);
        featureVecImages(6,i) = meanRGBVec(1,i,3);
        
        % Mean Lum, one point
        featureVecImages(7,i) = meanLumVec(1,i);
        
        % Mean RGB, five points
        featureVecImages(8,i) = meanRGBMat(1,i,1);
        featureVecImages(9,i) = meanRGBMat(1,i,2);
        featureVecImages(10,i) = meanRGBMat(1,i,3);
        
        featureVecImages(11,i) = meanRGBMat(2,i,1);
        featureVecImages(12,i) = meanRGBMat(2,i,2);
        featureVecImages(13,i) = meanRGBMat(2,i,3);
        
        featureVecImages(14,i) = meanRGBMat(3,i,1);
        featureVecImages(15,i) = meanRGBMat(3,i,2);
        featureVecImages(16,i) = meanRGBMat(3,i,3);
        
        featureVecImages(17,i) = meanRGBMat(4,i,1);
        featureVecImages(18,i) = meanRGBMat(4,i,2);
        featureVecImages(19,i) = meanRGBMat(4,i,3);
        
        featureVecImages(20,i) = meanRGBMat(5,i,1);
        featureVecImages(21,i) = meanRGBMat(5,i,2);
        featureVecImages(22,i) = meanRGBMat(5,i,3);
        
        % Mean Lum, five points
        featureVecImages(23,i) = meanLumMat(1,i);
        featureVecImages(24,i) = meanLumMat(2,i);
        featureVecImages(25,i) = meanLumMat(3,i);
        featureVecImages(26,i) = meanLumMat(4,i);
        featureVecImages(27,i) = meanLumMat(5,i);
        
    end
    
    % 2. Choose the type of comparison
    if comparison == 1
        
        disp('')
        disp('Comparison: Color content, mean RGB value in one point, mean luminance value in one point,');
        disp('            mean RGB value in five points and mean luminance value in five points.');

        comparisonFeatureVec = featureVecImages;
        
    elseif comparison == 2
        
        disp('')
        disp('Comparison: Color content.');
        
        comparisonFeatureVec = featureVecImages(1:3,:);
        
    elseif comparison == 3
        
        disp('')
        disp('Comparison: Mean RGB value in one point.');
        
        comparisonFeatureVec = featureVecImages(4:6,:);        
        
    elseif comparison == 4
        
        disp('')
        disp('Comparison: Mean luminance value in one point.');

        comparisonFeatureVec = featureVecImages(7,:);     
        
    elseif comparison == 5
        
        disp('')
        disp('Comparison: Mean RGB value in five points.');

        comparisonFeatureVec = featureVecImages(8:22,:);
        
    elseif comparison == 6
        
        disp('')
        disp('Comparison: Mean luminance value in five points.');

        comparisonFeatureVec = featureVecImages(23:27,:);
        
    else
        disp('Wrong input!');
    end
    
    % 3. Create feature vector for theImage
    featureVec = comparisonFeatureVec(:,theImage);
    
    % 4. Compare these two
    ei = zeros(1,12);
    unsortedVec = zeros(2,12);

    for i = 1:12
        
        unsortedVec(1,i) = i;
        unsortedVec(2,i) = norm(featureVec - comparisonFeatureVec(:,i));
        
    end
    
    [temp, order] = sort(unsortedVec(2,:));
    sortedVec = unsortedVec(:,order);
    num = sortedVec(1,2);
    
    % 5. Print result
    disp('');
    disp('Comparison done.');
    disp(['The closest image is image ', num2str(num)]);
    
    % Save cells
    save 'comparisonFeatureVec' comparisonFeatureVec; 
    save 'comparisonFeatureVec' comparisonFeatureVec; 
    save 'featureVec' featureVec;
    save 'unsortedVec' unsortedVec;
    save 'sortedVec' sortedVec;

end