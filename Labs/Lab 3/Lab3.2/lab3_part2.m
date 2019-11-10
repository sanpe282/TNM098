% TNM098 - Lab 3.2
% Sandra Pettersson and Isabelle Rosenquist

tic
disp('')
disp('Starting the program.');

% ---------------------------------- % 
%    1. Read from the text files     % 
% ---------------------------------- % 

for i = 1:10
    filename = strcat(num2str(i), '.txt');
    texts(i).text = formatText(fileread(filename));
end

% ---------------------------------- % 
%    2. Compare texts                % 
% ---------------------------------- % 

[paragraph, sentence] = compareTexts(texts)

% ---------------------------------- % 
%    3. Results                      % 
% ---------------------------------- % 

% ----------- PARAGRAPH ------------ % 
% Texts: 2 and 8
% Dr. Rutherford was pacing, with surgical precision, up and down my den.
% He looked slightly more self-possessed than the day before and seemed
% to be in excellent physical condition. I guessed at the contour beneath
% my wadded black silk dressing gown and re-considered my original
% plan to throw him bodily out of the house for having come without my
% invitation.

% ------------ SENTENCE ------------ % 
% Texts: 2 and 6
% I tried out the scales and found that my involuntary host weighed
% over 195 pounds--a good deal of it around the middle. 

disp('')
disp('Program ended.')
toc