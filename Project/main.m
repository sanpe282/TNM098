% Load the data
A = importdata('Lekagul_Sensor_Data_20150501.xlsx');

% Variables
numOfData = 324;
dateMat = cell2mat(A(:,1));

% Matrices
timeMat = strings(numOfData,3);
carID = strings(numOfData,1);
carType = strings(numOfData,1);
gateName = strings(numOfData,1);

% Assign the matrices
for i = 1:numOfData
    
    timeMat(i,1) = dateMat(i,12:13);
    timeMat(i,2) = dateMat(i,15:16);
    timeMat(i,3) = dateMat(i,18:19);
    carID(i) = A(i,2);
    carType(i) = A(i,3);
    gateName(i) = A(i,4);
    
end

