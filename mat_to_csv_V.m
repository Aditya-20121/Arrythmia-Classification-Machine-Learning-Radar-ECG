
% Step 1: Data Loading
% Load ECG data for each arrhythmia type
V2_files = dir('Dataset\V\V2\data\*.mat');
V3_files = dir('Dataset\V\V3\data\*.mat');
V14_files = dir('Dataset\V\V14\data\*.mat');
fs = 100;
V11_files = dir('Dataset\V\V11\data\*.mat');
V12_files = dir('Dataset\V\V12\data\*.mat');
V13_files = dir('Dataset\V\V13\data\*.mat');

V2_data = cell(numel(V2_files), 1);
V3_data = cell(numel(V3_files), 1);
V14_data = cell(numel(V14_files), 1);
V11_data = cell(numel(V11_files), 1);
V12_data = cell(numel(V12_files), 1);
V13_data = cell(numel(V13_files), 1);

for i = 1:numel(V2_files)
    V2_data{i} = load(fullfile(V2_files(i).folder, V2_files(i).name));
end

for i = 1:numel(V3_files)
    V3_data{i} = load(fullfile(V3_files(i).folder, V3_files(i).name));
end

for i = 1:numel(V14_files)
    V14_data{i} = load(fullfile(V14_files(i).folder, V14_files(i).name));
end

for i = 1:numel(V11_files)
    V11_data{i} = load(fullfile(V11_files(i).folder, V11_files(i).name));
end

for i = 1:numel(V12_files)
    V12_data{i} = load(fullfile(V12_files(i).folder, V12_files(i).name));
end

for i = 1:numel(V13_files)
    V13_data{i} = load(fullfile(V13_files(i).folder, V13_files(i).name));
end

%% Plot ECG signals for N1 arrhythmia type
%figure;
%subplot(3,1,1);
%title('ECG Signals for N1 Arrhythmia Type');
%xlabel('Time (s)');
%ylabel('Amplitude');
%hold on;
%ecg_signal = N1_data{1}.ECG{1};
%time = (0:length(ecg_signal)-1)/400 ; % Time vector
%plot(time, ecg_signal);
%hold off;


%% 
%var_names = fieldnames(mat_data.N1_results{1,1});
data = cell(621,1);
j = 1;
%%
for i = 1:numel(V2_data)
    data{j} = V2_data{i,1}.ECG{1,1};
    j = j+1;
end
for i = 1:numel(V3_data)
    data{j} = V3_data{i ,1}.ECG{1,1};
    j = j+1;
    
end
for i = 1:numel(V14_data)
    data{j} = V14_data{i,1}.ECG{1,1};  
    j = j+1;
end

%%
for i = 1:numel(V11_data)
    data{j} = V11_data{i,1}.ECG{1,1};
    j = j+1;
end
for i = 1:numel(V12_data)
    data{j} = V12_data{i ,1}.ECG{1,1};
    j = j+1;
    
end
for i = 1:numel(V13_data)
    data{j} = V13_data{i,1}.ECG{1,1};  
    j = j+1;
end

%% Convert to table
T = table(data);

%% Add label
numRows = size(data, 1);
oCol = ones(numRows, 1);
oneCol = table(oCol);
% Append the column of ones to the data matrix
T = [T oneCol];

%% Write table to CSV file
writetable(T, "1_ECG_only_V.csv");
