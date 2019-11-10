function [finalStrings] = formatText(str)

    % Remove characters and make lower case
    str(regexp(str, '["_-]')) = [];
    str(regexp(str, ' ')) = [];
    str(regexp(str, '[\n\n+\r]')) = [];
    str = lower(str);

    % Split on . ? or !
    finalStrings = split(str,{'.', '?', '!'});

    % Remove empty strings
    finalStrings(strcmp('',finalStrings)) = [];

    len = length(finalStrings);
    cnt = 1;
    
    for i = 1:len
        str = char(finalStrings(cnt));
        if(length(str) < 2)
            finalStrings(cnt) = [];
            len = length(finalStrings);
        else
            cnt = cnt + 1;
        end
    end

end