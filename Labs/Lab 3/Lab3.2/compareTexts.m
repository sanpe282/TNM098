function [paragraph, sentence] = compareTexts(texts)

    % Check if the text is the same, return the paragraph and sentence
    % Also return the texts in which they where found in

    paragraph = {0, 0, ''};
    sentence = {0, 0, ''};

    for i = 1:9
        for j = i+1:10
            
            text1 = texts(i).text;
            text2 = texts(j).text;
            
            for m = 1:length(text1)
                for n = 1:length(text2)
                    if(strcmp(text1(m),text2(n)))
                        if(strcmp(text1(m+1),text2(n+1)))
                            paragraph(1) = {i};
                            paragraph(2) = {j};
                            paragraph(end) = text1(m);
                            paragraph(end+1) = text1(m+1);
                        elseif(cellfun('length',text1(m)) > cellfun('length',sentence(3)))
                            if strcmp(text1(m),paragraph(end))
                            else 
                                sentence(1) = {i};
                                sentence(2) = {j};
                                sentence(3) = text1(m);
                            end
                        end
                    end  
                end
            end
        end
    end
    
    
end