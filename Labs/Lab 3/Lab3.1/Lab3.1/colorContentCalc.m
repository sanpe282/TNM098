function [colorContent] = colorContentCalc(images)

    colorContent = zeros(1,12,3);

    for i = 1:12
        
        image = images{i};
        
        colorContent(1,i,1) = mean2(image(:,:,1));
        colorContent(1,i,2) = mean2(image(:,:,2));
        colorContent(1,i,3) = mean2(image(:,:,3));
        
    end
    
    % Save cells
    save 'colorContent' colorContent; 
    
end