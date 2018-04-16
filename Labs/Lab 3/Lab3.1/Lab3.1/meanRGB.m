function [meanVector] = meanRGB(images)

    meanVector = zeros(1,12,3);
    colors = zeros(1,12);

    for i = 1:12
        
        image = images{i};
        
        meanVector(1,i,1) = mean2(image(:,:,1));
        meanVector(1,i,2) = mean2(image(:,:,2));
        meanVector(1,i,3) = mean2(image(:,:,3));
        
        testImage = zeros(100, 100, 3);
        testImage(:,:,1) = meanVector(1,i,1)/255;
        testImage(:,:,2) = meanVector(1,i,2)/255;
        testImage(:,:,3) = meanVector(1,i,3)/255;
        
        %figure;
        %imshow(testImage);

    end
end