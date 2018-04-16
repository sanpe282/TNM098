function [images] = readImage()

    numfiles = 12;
    images = cell(1, numfiles);

    %images < 9 is syntaxed with 01, 02...
    for i = 1:9 
      myfilename = sprintf('0%d.jpg', i);
      images{i} = imread(myfilename);
    end

    %images > 10 is syntaxed with 10, 11...
    for i = 10:numfiles
      myfilename = sprintf('%d.jpg', i);
      images{i} = imread(myfilename);
    end

end