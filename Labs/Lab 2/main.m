%% Start

file = "Lab2_Data.xlsx";

A = xlsread(file);

xMin = min(A(:,5));
xMax = max(A(:,5));
yMin = min(A(:,6));
yMax = max(A(:,6));

figure;

h = animatedline;


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
    
    if (sec >= 0) && (sec <= 60000)
        color2 = 'r';
    elseif (sec > 60000) && (sec <= 120000)
        color2 = 'g';
    elseif (sec > 120000) && (sec <= 180000)
        color2 = 'b';
    elseif (sec > 180000) && (sec <= 240000)
        color2 = 'm';
    else
        color2 = 'c';
    end
    
    duration = A(:,3);
    plot(A(i,5),A(i,6), color, 'MarkerSize', 0.01 * duration(i));
    plot([A(i,5) A(i+1,5)], [A(i,6) A(i+1,6)], color2)
    addpoints(h,A(i,5),A(i,6));
    axis([xMin xMax yMin yMax]);
    drawnow
    hold on;
    
end

%% Find clusters with DBSCAN

figure;
X = A(:,5:6);
duration = A(:,3);
timestamp = A(:,1);

epsilon = 60; %?
MinPts = 10; %?

% https://se.mathworks.com/matlabcentral/fileexchange/52905-dbscan-clustering-algorithm
IDX = DBSCAN(X, epsilon, MinPts);

PlotClusterinResult(X, IDX, duration);
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);

%% VISUALIZATION

figure
m = animatedline

for i = 1:size(IDX,1)
    
    cluster = IDX(i,1);
    k=max(IDX);
    Colors=hsv(k);
    
    for j = 1:5
        
        matrix = zeros(size(IDX,1), 2);
        
        if cluster == j 
            matrix(i,1) = timestamp(i)/1000;
            matrix(i,2) = duration(i)/1000;
        end

        Style = '.';
        MarkerSize = 8;
        Color = Colors(j,:);
        
        subplot(5,1,j)
        plot(matrix(i,1),matrix(i,2),Style,'MarkerSize',MarkerSize,'Color',Color);
        %addpoints(m,matrix(i,1),matrix(i,2))
        axis([0 300 0 2]);
        hold on;
    end
end


%% QUESTIONS

% Questions of interest might include:
    % How many regions can be identified? 
    % How many are heavily used and when?
        % How log did you watch?
        % When did you watch?
    % Which regions are only used for part of the analysis procedure?
    % What are the frequent transitions between the areas of interest? and how do those
    % transition patterns change over time?
    
    