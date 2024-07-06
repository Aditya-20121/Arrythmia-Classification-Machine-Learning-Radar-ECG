%% Read data from the first CSV file
data1 = readmatrix('1_ECG_only_A.csv', 'Range', '2:993');


% Read data from the third CSV file
data2 = readmatrix('1_ECG_only_V.csv ', 'Range', '2:622');


%% Save combined data to a .csv file
%AV_combined_data = [data1; data2];
%writematrix(AV_combined_data, '2_AV_combined_data.csv' );


%% seperate Labels and ECG data
y1 = data1(:, 12001);   % Labels
y3 = data2(:, 12001);   % Labels
 
data1 = data1(:, 1:12000); % ECG data points
data2 = data2(:, 1:12000); % ECG data points

%% Code for Down sampling the data
% Define the original and desired lengths
%original_length = 12000;
%desired_length = 11664;

%data1 = downsample(data1, original_length, desired_length);
%data2 = downsample(data2, original_length, desired_length);

%t0 = (0:length(data1)-1); % Time vector
%t00 = (0:length(data1)-1); % Time vector

%% Write concatenated data to a new CSV file
%concatenated_data = [data11, y1 ; data33 , y2];
%writematrix(concatenated_data, 'AV_11664x1521.csv');
% Load the radar ECG data from CSV file
%data = readmatrix('radar_ecg_data.csv');


%% Augmentation
X1 = data1(:, :); % ECG data points
augment_data1 = augment(X1, y1, 3);

% Data augmentation for data 3
X2 = data2(:, :); % ECG data points
augment_data3 = augment(X2, y3, 5);


%% combine data
augmented_data = [ augment_data1; augment_data3];
%writematrix(augmented_data, 'augmented_AV_data.csv' );

%% save in a .csv file (warning : size is too big so its best to save it a .mat file.) 
%writematrix(augmented_data, 'augmented_AV_data.csv' );

%% Save augmented data to MAT file
save('3_AV_ECG_augmented_data.mat', 'augmented_data');




%% function to perform augmentation of data, adding random noise to the ECG data.
function [augmented_data] = augment(X, y, num_augmented_samples)

    % Initialize augmented data and labels
    augmented_X = [];
    augmented_y = [];
    
    %% Data augmentation loop
    for i = 1:size(X, 1)
        % Original sample
        original_sample = X(i, :);
        
        % Apply data augmentation techniques
        for j = 1:num_augmented_samples
            % Perform data augmentation
            
            % Example: Add Gaussian noise
            augmented_sample = original_sample + 0.01 * randn(size(original_sample));
            
            % Example: Time shifting
            % shift_amount = randi([-100, 100]);
            % augmented_sample = circshift(original_sample, shift_amount);
            
            % Store augmented sample and label
            augmented_X = [augmented_X; augmented_sample];
            augmented_y = [augmented_y; y(i)];
        end
    end
    
    %% Combine original and augmented data
    combined_X = [X; augmented_X];
    combined_y = [y; augmented_y];
    
    augmented_data = [combined_X, combined_y];
end



%{
%% Function to downsample the values to fit in 108x108 matrix for RNN
function [downsampled_data] = downsample(data, original_length, desired_length)
    
    % Define the ratio between original and desired lengths
    ratio = original_length / desired_length;
    
    % Downsample each row of the data
    downsampled_data = zeros(size(data, 1), desired_length);
    for i = 1:size(data, 1)
        % Reshape the row into a 2D matrix with original_length columns
        ecg_row = reshape(data(i, :), [], original_length);
        
        % Downsample using mean pooling
        downsampled_row = mean(ecg_row(:, 1:round(ratio):end), 1);
        
        % Ensure the downsampled row has the desired length
        downsampled_row = downsampled_row(1:desired_length);
        
        % Assign the downsampled row to the downsampled data matrix
        downsampled_data(i, :) = downsampled_row;
    end

end
%}
