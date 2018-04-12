%% Start

file = "Lab2_Data.xlsx";

A = xlsread(file);

xMin = min(A(:,5));
xMax = max(A(:,5));
yMin = min(A(:,6));
yMax = max(A(:,6));


% Plot all x- and y-values
for i = 1:size(A(:,2))
    
    sec = A(i,1);
    
    if (sec >= 0) && (sec <= 60000)
        color = 'r.';
    elseif (sec > 60000) && (sec <= 120000)
        color = 'g.';
    elseif (sec > 120000) && (sec <= 180000)
        color = 'b.';
    elseif (sec > 180000) && (sec <= 240000)
        color = 'm.';
    else
        color = 'c.';
    end
    
    duration = A(:,3);
    plot(A(i,5),A(i,6), color, 'MarkerSize', 0.05 * duration(i));
    axis([xMin xMax yMin yMax]);
    hold on;
    
end
%%

x_values = A(:,5);
y_values = A(:,6);



[idx, dist] = knnsearch(x_values, y_values, 'dist', 'euclidean', 'k', 1)
%[idx, dist] = knnsearch(x_values, y_values)

%%

x_values = A(:,5);
y_values = A(:,6);

N = size(x,1);
dists = zeros(N,1);
for idx = 1 : N
    dists(idx) = sqrt(sum((x(idx,:) - newpoint).^2));
end
%% Find clusters with DBSCAN

figure;
X = A(:,5:6);
duration = A(:,3);

epsilon = 60; %?
MinPts = 10; %?

% https://se.mathworks.com/matlabcentral/fileexchange/52905-dbscan-clustering-algorithm
IDX = DBSCAN(X, epsilon, MinPts);

PlotClusterinResult(X, IDX, duration);
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);

%% QUESIONS

% Questions of interest might include:
    % How many regions can be identified?
    % How many are heavily used and when?
        % How log did you watch?
        % When did you watch?
    % Which regions are only used for part of the analysis procedure?
    % What are the frequent transitions between the areas of interest? and how do those
    % transition patterns change over time?
    
    