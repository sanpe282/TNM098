% TNM098 - Lab 3.1
% Sandra Pettersson and Isabelle Rosenquist

disp('')
disp('Starting the program.');

% ----------------------------------%
%    1. Read the images in the DB   %
% ----------------------------------%

images = readImage();

% -------------------------------------%
%    2. Process the images in the DB   %
% -------------------------------------%

% a. Calculate colour content
colorContentCalc(images);

% b. Calculate colour and luminance distribution around the central point
centerPointCalc(images);

% c. Calculate colour and luminance distribution around several points
multiplePointsCalc(images);

% ---------------------------------------------%
%    3. Choose image to make comparison with   %
%    Options: 1-12                             %
% ---------------------------------------------%

theImage = 7;

% ------------------------------------------------------------------------------------%
%    4. Choose the type of comparison                                                 %
%    Options: 1. all, 2. colorContent, 3. rgbOne, 4. lumOne, 5. rgbFive, 6. lumFive   %
% ------------------------------------------------------------------------------------%

comparison = 1;

% ---------------------------%
%    5. Compare the images   %
% ---------------------------%

compareImage(comparison, theImage);

disp('')
disp('Program ended.')
