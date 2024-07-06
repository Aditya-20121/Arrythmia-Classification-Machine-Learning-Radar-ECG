% Load the radar ECG data from the CSV file
data = readmatrix('2_AV_combined_data.csv');

% Extract the radar ECG data (excluding the label column)
radar_ecg_data = data(:, 1:end-5);
fs = 400; % Define the sampling frequency
signal_length = size(radar_ecg_data, 2);


% Initialize arrays to store the computed features
features = zeros(size(radar_ecg_data, 1), 13); % Adjust the number of features as needed


%% Compute features for each row of radar ECG data
% Time-domain features
[mean_values, std_dev_values, skewness_values, kurtosis_values, rms_values, zc_rate_values ]  = timeDomainFeatrues(radar_ecg_data);
    
% Frequency-domain features
[spectral_centroid_values, spectral_bandwidth_values, spectral_skewness_values, spectral_kurtosis_values] = freqDomainFeatures(radar_ecg_data, signal_length, fs);
    
% HRV statistics
[mean_rr_intervals, sdnn_values, rmssd_values] = HRVFeatures(radar_ecg_data, fs);
    


%% Store computed features in the array
features = [mean_values, std_dev_values, skewness_values, kurtosis_values, rms_values, zc_rate_values, spectral_centroid_values, spectral_bandwidth_values, spectral_skewness_values, spectral_kurtosis_values, mean_rr_intervals, sdnn_values, rmssd_values];

%% Save the computed features to a CSV file
%writematrix(features, 'features_AV.csv');





%% Time domain features
function [mean_values, std_dev_values, skewness_values, kurtosis_values, rms_values, zc_rate_values ]  = timeDomainFeatrues(radar_ecg_data)
    % Initialize arrays to store the computed features
    mean_values = zeros(size(radar_ecg_data, 1), 1);
    std_dev_values = zeros(size(radar_ecg_data, 1), 1);
    skewness_values = zeros(size(radar_ecg_data, 1), 1);
    kurtosis_values = zeros(size(radar_ecg_data, 1), 1);
    rms_values = zeros(size(radar_ecg_data, 1), 1);
    zc_rate_values = zeros(size(radar_ecg_data, 1), 1);

    % Compute features for each row of radar ECG data
    for i = 1:size(radar_ecg_data, 1)
        % Compute features for the current row
        signal = radar_ecg_data(i, :);
        mean_values(i) = mean(signal);
        std_dev_values(i) = std(signal);
        skewness_values(i) = skewness(signal);
        kurtosis_values(i) = kurtosis(signal);
        rms_values(i) = rms(signal);
        zc_rate_values(i) = sum(abs(diff(signal > 0.5))) / (length(signal) - 1); % Assuming a threshold of 0.5
    end
end

% Frequency domain features
function [spectral_centroid_values, spectral_bandwidth_values, spectral_skewness_values, spectral_kurtosis_values] = freqDomainFeatures(radar_ecg_data, signal_length, fs)

    % Frequency Domain - Initialize arrays to store the computed features
    spectral_centroid_values = zeros(size(radar_ecg_data, 1), 1);
    spectral_bandwidth_values = zeros(size(radar_ecg_data, 1), 1);
    spectral_skewness_values = zeros(size(radar_ecg_data, 1), 1);
    spectral_kurtosis_values = zeros(size(radar_ecg_data, 1), 1);

    % Compute frequency-domain features for each row of radar ECG data
    for i = 1:size(radar_ecg_data, 1)
        % Compute FFT coefficients
        fft_result = fft(radar_ecg_data(i, :));
        
        % Compute Power Spectral Density (PSD)
        psd_result = abs(fft_result).^2 / signal_length;
        
        % Compute Spectral Centroid
        f_axis = linspace(0, fs, signal_length);
        spectral_centroid_values(i) = sum(psd_result .* f_axis) / sum(psd_result);
        
        % Compute Spectral Bandwidth
        spectral_bandwidth_values(i) = sqrt(sum((f_axis - spectral_centroid_values(i)).^2 .* psd_result) / sum(psd_result));
        
        % Compute Spectral Skewness and Kurtosis
        spectral_skewness_values(i) = skewness(psd_result);
        spectral_kurtosis_values(i) = kurtosis(psd_result);
    end

end


% Heart rate variability features
function [mean_rr_intervals, sdnn_values, rmssd_values] = HRVFeatures(radar_ecg_data, fs)

    % Initialize arrays to store the computed features
    mean_rr_intervals = zeros(size(radar_ecg_data, 1), 1);
    sdnn_values = zeros(size(radar_ecg_data, 1), 1);
    rmssd_values = zeros(size(radar_ecg_data, 1), 1);
    % Compute HRV features for each row of radar ECG data
    for i = 1:size(radar_ecg_data, 1)
        % Apply a bandpass filter to extract relevant frequencies
        [b, a] = butter(4, [0.5, 40]/(fs/2), 'bandpass');
        filtered_signal = filtfilt(b, a, radar_ecg_data(i, :));
        
        % Differentiate the filtered signal to enhance the peaks
        diff_signal = diff(filtered_signal);
        
        % Apply thresholding to detect peaks
        threshold = 0.5 * max(diff_signal); % Adjust threshold as needed
        peak_indices = find(diff_signal > threshold);
        
        % Compute RR intervals from peak indices
        rr_intervals = diff(peak_indices) / fs;
        
        % Compute HRV statistics
        mean_rr_intervals(i) = mean(rr_intervals);
        sdnn_values(i) = std(rr_intervals);
        rmssd_values(i) = sqrt(mean(diff(rr_intervals).^2));
    end
end