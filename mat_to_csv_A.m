%% Step 1: Data Loading
% Load ECG data for each arrhythmia type
A2_files = dir('Dataset\A\A2\data\*.mat');
A3_files = dir('Dataset\A\A3\data\*.mat');
A4_files = dir('Dataset\A\A4\data\*.mat');
A11_files = dir('Dataset\A\A11\data\*.mat');
A12_files = dir('Dataset\A\A12\data\*.mat');
A13_files = dir('Dataset\A\A13\data\*.mat');

A2_data = cell(numel(A2_files), 1);
A3_data = cell(numel(A3_files), 1);
A4_data = cell(numel(A4_files), 1);
A11_data = cell(numel(A11_files), 1);
A12_data = cell(numel(A12_files), 1);
A13_data = cell(numel(A13_files), 1);
%%
for i = 1:numel(A2_files)
    A2_data{i} = load(fullfile(A2_files(i).folder, A2_files(i).name));
end

for i = 1:numel(A3_files)
    A3_data{i} = load(fullfile(A3_files(i).folder, A3_files(i).name));
end

for i = 1:numel(A4_files)
    A4_data{i} = load(fullfile(A4_files(i).folder, A4_files(i).name));
end

for i = 1:numel(A11_files)
    A11_data{i} = load(fullfile(A11_files(i).folder, A11_files(i).name));
end

for i = 1:numel(A12_files)
    A12_data{i} = load(fullfile(A12_files(i).folder, A12_files(i).name));
end

for i = 1:numel(A13_files)
    A13_data{i} = load(fullfile(A13_files(i).folder, A13_files(i).name));
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
data = cell(992,1);
j = 1;
%%
for i = 1:numel(A2_data)
    data{j} = A2_data{i,1}.ECG{1,1};
    j = j+1;
end
for i = 1:numel(A3_data)
    data{j} = A3_data{i ,1}.ECG{1,1};
    j = j+1;
    
end
for i = 1:numel(A4_data)
    data{j} = A4_data{i,1}.ECG{1,1};  
    j = j+1;
end

%%
for i = 1:numel(A11_data)
    data{j} = A11_data{i,1}.ECG{1,1};
    j = j+1;
end
for i = 1:numel(A12_data)
    data{j} = A12_data{i ,1}.ECG{1,1};
    j = j+1;
    
end
for i = 1:numel(A13_data)
    data{j} = A13_data{i,1}.ECG{1,1};  
    j = j+1;
end




%% Convert to table
T = table(data);
%% Add label
numRows = size(data, 1);
zCol = zeros(numRows, 1);
zeroCol = table(zCol);
% Append the column of ones to the data matrix
T = [T zeroCol];

%% Write table to CSV file
writetable(T, "1_ECG_only_A.csv");
