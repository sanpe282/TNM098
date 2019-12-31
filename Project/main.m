% TNM098 - PROJECT

%% PROJECT PLAN

% We will be focusing on finding patterns in individuals and groups in one day. 
% If there is time left we would also like to observe what happens in a longer period of time.

% 1. We will start by analyzing the data to find the most visited gates to see where the visitors
% spend most of their time. 
% 2. Then we also wants to see what kind of vehicles that visits the park and where exactly
% they spend most time.

% Since there is no specific data about the birds that resides in the park we need to draw 
% our own conclusions from the patterns we find in the visitors movements.

%% STEP 0: CREATE THE COORDINATE MATRIX (LOADING DOES NOT WORK AS IT SHOULD...)
% Entrances: 1-5, General gates: 6-13, Gates: 14-22, Ranger stops: 23-30, Ranger base: 31, Campings: 32-40

gateCoord = {'entrance0' '315' '76' '0'; 'entrance1' '96' '339' '0'; 'entrance2' '904' '437' '0'; 'entrance3' '573' '826' '0'; 'entrance4' '695' '909' '0';
    'general-gate0' '549' '57' '0'; 'general-gate1' '325' '135' '0'; 'general-gate2' '519' '169' '0'; 'general-gate3' '919' '281' '0'; 'general-gate4' '349' '490' '0'; 'general-gate5' '617' '554' '0'; 'general-gate6' '675' '680' '0'; 'general-gate7' '329' '714' '0';
    'gate0' '320' '174' '0'; 'gate1' '295' '227' '0'; 'gate2' '130' '276' '0'; 'gate3' '739' '305' '0'; 'gate4' '812' '568' '0'; 'gate5' '651' '724' '0'; 'gate6' '578' '748' '0'; 'gate7' '485' '792' '0'; 'gate8' '685' '894' '0';
    'ranger-stop0' '446' '91' '0'; 'ranger-stop1' '105' '130' '0'; 'ranger-stop2' '403' '183' '0'; 'ranger-stop3' '734' '232' '0'; 'ranger-stop4' '101' '476' '0'; 'ranger-stop5' '748' '588' '0'; 'ranger-stop6' '612' '729' '0'; 'ranger-stop7' '500' '753' '0';
    'ranger-base' '636' '865' '0';
    'camping0' '266' '213' '0'; 'camping1' '641' '256' '0'; 'camping2' '227' '325' '0'; 'camping3' '232' '344' '0'; 'camping4' '247' '446' '0'; 'camping5' '110' '602' '0'; 'camping6' '743' '875' '0'; 'camping7' '894' '719' '0'; 'camping8' '904' '247' '0'}

save('gateCoord.mat','gateCoord');

%% STEP 1: LOAD COORDINATE DATA AND SENSOR DATA

clear all;
load('gateCoord.mat');

sensorData1 = importdata('Lekagul_Sensor_Data_20150713.xlsx');
sensorData2 = importdata('Lekagul_Sensor_Data.xlsx');
sensorData3 = importdata('Lekagul_Sensor_Data_may-aug.xlsx');
sensorData4 = importdata('Lekagul_Sensor_Data_w29.xlsx');

sensorDataDay = cell(1223,4);
sensorDataYear = cell(171477,4);
sensorDataSummer = cell(107203,4);
sensorData29 = cell(8375,4);

for c = 1:1223 
    sensorDataDay(c,1) = sensorData1.textdata(c,1);
    sensorDataDay(c,2) = sensorData1.textdata(c,2);
    sensorDataDay(c,4) = sensorData1.textdata(c,4);
    
    if (ismissing(string(sensorData1.data(c,1))))
        sensorDataDay(c,3) = {'2P'};
    else
        sensorDataDay(c,3) = num2cell(sensorData1.data(c,1));
    end
end

for d = 1:171477 
    sensorDataYear(d,1) = sensorData2.textdata(d,1);
    sensorDataYear(d,2) = sensorData2.textdata(d,2);
    sensorDataYear(d,4) = sensorData2.textdata(d,4);
    
    if (ismissing(string(sensorData2.data(d,1))))
        sensorDataYear(d,3) = {'2P'};
    else
        sensorDataYear(d,3) = num2cell(sensorData2.data(d,1));
    end
end

for e = 1:107203 
    sensorDataSummer(e,1) = sensorData3.textdata(e,1);
    sensorDataSummer(e,2) = sensorData3.textdata(e,2);
    sensorDataSummer(e,4) = sensorData3.textdata(e,4);
    
    if (ismissing(string(sensorData3.data(e,1))))
        sensorDataSummer(e,3) = {'2P'};
    else
        sensorDataSummer(e,3) = num2cell(sensorData3.data(e,1));
    end
end

for f = 1:8375 
    sensorData29(f,1) = sensorData4.textdata(f,1);
    sensorData29(f,2) = sensorData4.textdata(f,2);
    sensorData29(f,4) = sensorData4.textdata(f,4);
    
    if (ismissing(string(sensorData4.data(f,1))))
        sensorData29(f,3) = {'2P'};
    else
        sensorData29(f,3) = num2cell(sensorData4.data(f,1));
    end
end

clear c d e f sensorData1 sensorData2 sensorData3 sensorData4;

%% STEP 2: CREATE AND CHOOSE VARIABLES

% Choose which sensor data:
sensorData = sensorDataDay;
numOfData = size(sensorData,1);
numOfGates = size(gateCoord,1);
uniqueCars = 202; % (20150501: 43), 20150713: 202, Week 29: 1093, Summer: 11595, All year: 18708

%% STEP 3: CREATE CAR DATA MATRIX

% Create a sorted data matrix
[~,idx] = sort(sensorData(:,2)); % sort the first column
sortedSensorData = sensorData(idx,:); % sort the whole matrix using the sort indices

id = '';
num = 0;
cars = strings(uniqueCars,2);

% Create a car matrix containing the id and the car type
for i = 1:numOfData

    if(id ~= string(sortedSensorData(i,2)))
        id = sortedSensorData(i,2);
        num = num + 1;
        cars(num,1) = id;
        cars(num,2) = sortedSensorData(i,3);
    end
    
    if(id == string(sortedSensorData(i,2)))
        sortedSensorData(i,4);
    end
end

clear idx i id num;

carPositions = cell(1,numOfData);
n = 1;
prevCar = {};

% Create a matrix for the posistions for each car
for i = 1:numOfData
    thisCar = sortedSensorData(i,2);
    
    if(string(thisCar) ~= string(prevCar))
        n = 1;
    end
    
    for j = 1:uniqueCars
        if(string(cars(j,1)) == string(sortedSensorData(i,2)))
            carPositions(j,n) = sortedSensorData(i,4);
            n = n + 1;
        end
    end
    
    prevCar = thisCar;

end

clear n i j thisCar prevCar ans;

%% STEP 4: PLOT SIZE DEPENDENT DOTS

% FIX: Do this for either all car types or just a specific car type

% Choose which car type:
% 1: 2 axle car (or motorcycle), 2: 2 axle truck, 2P: 2 axle truck (park service vehicle)
% 3: 3 axle truck, 4: 4 axle (and above) truck, 5: 2 axle bus, 6: 3 axle bus
type = '6';

% Display the map as background
imshow('lekagul_roadways_inverted_op30.png');
axis on;
hold on;

% Fill the amount number with empty cells
gateCoord(:,4) = {[0]};

% Count the amount of times a gate is passed
for i = 1:numOfData    
    for j = 1:numOfGates

        % Remove this if statement for all types
        if(string(sensorData(i,3)) == type)
            
            size = gateCoord(j,4);

            if(strcmp(cellstr(sensorData(i,4)),gateCoord(j,1)))
                size{1} = size{1} + 1;
                gateCoord(j,4) = size;
            end
        end
    end 
end

clear i j size;

for i = 1:numOfGates
    
    % Get coordinates
    xCoord = str2double(gateCoord(i,2));
    yCoord = str2double(gateCoord(i,3));
    
    % Get dot size
    dotSize = gateCoord(i,4);
    dotSize = dotSize{1}*15;%/1.5;
    %dotSize = dotSize{1}*4;
    
    % Get color depending on dot size
    if (dotSize >= 0) && (dotSize <= 20)
        color = 'g.';
    elseif (dotSize > 20) && (dotSize <= 30)
        color = 'y.';
    elseif (dotSize > 30) && (dotSize <= 100)
        color = 'r.';
    else
        color = 'k.';
    end

    % Plot the dots
    if(dotSize ~= 0)
        plot(xCoord, yCoord, color,'MarkerSize', dotSize*1.5);
        axis([0 1000 0 1000]);
        drawnow;
        hold on;
    end
end

clear i xCoord yCoord dotSize color;

%% STEP 5: DRAW THE DIFFERENT CARS MOVEMENTS

for i = 173:173%uniqueCars
    
    % Display the map as background
    figure;
    imshow('lekagul_roadways_inverted_op30.png');
    axis on
    hold on;
    
    pos = carPositions(i,:);
    pos = pos(~cellfun('isempty',pos));
    
    for j = 1:size(pos,2)
        for k = 1:numOfGates
            if(string(pos(j)) == string(gateCoord(k,1)))
                
                xCoord = str2double(gateCoord(k,2));
                yCoord = str2double(gateCoord(k,3));
                
                if(j == 1) 
                    plot(xCoord, yCoord, 'b.','MarkerSize', 20);
                    xCoord2 = xCoord;
                    yCoord2 = yCoord;
                    axis([0 1000 0 1000]);
                    drawnow
                    hold on;
                elseif(j <= size(pos,2))
                    plot(xCoord, yCoord, 'k.','MarkerSize', 20);
                    plot([xCoord xCoord2], [yCoord yCoord2], 'k');
                    xCoord2 = xCoord;
                    yCoord2 = yCoord;
                    axis([0 1000 0 1000]);
                    drawnow
                    hold on;
                end
            end
        end
    end
end

%% STUFF THAT IS NOT USED...

% ----------

% Plot all gates
% figure;
% %set(gcf, 'Position', [1, 1, 1000, 1000]);
% %plot(1:10,'.-');
% 
% imshow('lekagul_roadways.png');
% axis on
% hold on;
% 
% gateCoord(1,1)

% Plot all entrances
% for i = 1
%     
%     x = str2double(gateCoord(1,2));
%     y = str2double(gateCoord(1,3));
%     
%     plot(x,y, 'g*', 'MarkerSize', 10, 'LineWidth', 2);
%     
% end

% Plot the gates positions in a map
% See specific cars, where they go (like the eye tracking lab)
% Extract every specific car to see how many, where they go 
% Date is not relevant if only one day
% Example: cars = {carID; carType; position[time, place]}

% ----------

%gateCoord2 = {'entrance0' '315' '76' 0; 'entrance1' '96' '339' 0; 'entrance2' '904' '437' 0; 'entrance3' '573' '826' 0; 'entrance4' '695' '909' 0;
%    'general-gate0' '549' '57' 0; 'general-gate1' '325' '135' 0; 'general-gate2' '519' '169' 0; 'general-gate3' '919' '281' 0; 'general-gate4' '349' '490' 0; 'general-gate5' '617' '554' 0; 'general-gate6' '675' '680' 0; 'general-gate7' '329' '714' 0;
%    'gate0' '320' '174' 0; 'gate1' '295' '227' 0; 'gate2' '130' '276' 0; 'gate3' '739' '305' 0; 'gate4' '812' '568' 0; 'gate5' '651' '724' 0; 'gate6' '578' '748' 0; 'gate7' '485' '792' 0; 'gate8' '685' '894' 0;
%    'ranger-stop0' '446' '91' 0; 'ranger-stop1' '105' '130' 0; 'ranger-stop2' '403' '183' 0; 'ranger-stop3' '734' '232' 0; 'ranger-stop4' '101' '476' 0; 'ranger-stop5' '748' '588' 0; 'ranger-stop6' '612' '729' 0; 'ranger-stop7' '500' '753' 0;
%    'ranger-base' '636' '865' 0;
%    'camping0' '266' '213' 0; 'camping1' '641' '256' 0; 'camping2' '227' '325' 0; 'camping3' '232' '344' 0; 'camping4' '247' '446' 0; 'camping5' '110' '602' 0; 'camping6' '743' '875' 0; 'camping7' '894' '719' 0; 'camping8' '904' '247' 0}

%save('gateCoord2.mat','gateCoord2');

% ----------

% Create matrices
%timeMat = strings(numOfData,3);
%carID = strings(numOfData,1);
%carType = strings(numOfData,1);
%gateName = strings(numOfData,1);

% Assign the matrices
%for i = 1:numOfData
    
%    timeStamp = split(sensorData(i,1));
%    time = strsplit(string(timeStamp(2,1)),':');

%    timeMat(i,1) = time(1,1);
%    timeMat(i,2) = time(1,2);
%    timeMat(i,3) = time(1,3);
    
%    carID(i) = sensorData(i,2);
%    carType(i) = sensorData(i,3);
%    gateName(i) = sensorData(i,4);
    
%end

% ----------

% PLOT LINE BETWEEN ALL ENTRANCES IN ORDER (TEST)

% % Display the map as background 
% imshow('lekagul_roadways.png');
% axis on
% hold on;
% 
% % Create line variable
% h = animatedline;
% 
% % Plot all x- and y-values
% for i = 1:numOfData-1
%     
%     color = 'r.';
%     color2 = 'r';
% 
%     xCoord = str2double(gateCoord(i,2));
%     xCoord2 = str2double(gateCoord(i+1,2));
%     yCoord = str2double(gateCoord(i,3));
%     yCoord2 = str2double(gateCoord(i+1,3));
%     
%     %duration = A(:,3);
%     plot(xCoord, yCoord, color, 'MarkerSize', 1);
%     plot([xCoord xCoord2], [yCoord yCoord2], color2)
%     addpoints(h, xCoord, yCoord);
%     axis([0 1000 0 1000]);
%     drawnow
%     hold on;
%     
% end

% ----------

% %% PLOT THE ENTRANCES RECORDED IN CHRONOLOGICAL ORDER (TEST)
% 
% % Display the map as background 
% imshow('lekagul_roadways.png');
% axis on
% hold on;
% 
% % Create line variable
% h = animatedline;
% 
% % Plot all x- and y-values
% for i = 1:numOfData
%     
%     i
%     pos = cellstr(sensorData(i,4));
%     
%     color = 'r';
%     color2 = 'r';
%     
%     for j = 1:40
%         
%         gateCoord(j,1);
%         
%         if(strcmp(pos,gateCoord(j,1)))
%             
%             xCoord = str2double(gateCoord(j,2));
%             xCoord2 = str2double(gateCoord(j+1,2)); % Blir fel att ta nästa i gateCoord
%             yCoord = str2double(gateCoord(j,3));
%             yCoord2 = str2double(gateCoord(j+1,3)); % Blir fel att ta nästa i gateCoord
% 
%             %duration = A(:,3);
%             plot(xCoord, yCoord, 'facealpha', 0.2, 'facecolor', color, 'MarkerSize', 3);
%             plot([xCoord xCoord2], [yCoord yCoord2], color2)
%             addpoints(h, xCoord, yCoord);
%             axis([0 1000 0 1000]);
%             drawnow
%             hold on;
%             
%         end
%     end
% end
