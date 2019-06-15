clear;
close all;

office = office256;

%% Adding noise to the image.
img_gauss_noise = gaussnoise(office, 16);
img_sap_noise = sapnoise(office, 0.1, 255);

figure;
sgtitle('Noise Added to an Image');

subplot(1,2,1);
showgrey(img_gauss_noise);
title('Gaussian noise');

subplot(1,2,2);
showgrey(img_sap_noise);
title('Salt & Pepper noise');

%% Gaussian smoothing with different variances is used in an attemp to remove the noise.

variances = [0.1, 0.5, 1, 2, 5, 10, 20, 50];

% Removing the Gaussian Noise.
figure;
sgtitle('Gaussian Smoothing of Gaussian Noise');

for var = 1 : length(variances)
        subplot(2, 4, var);
        % Applying Gaussian filter to image with Gaussian noise.
        showgrey( gaussfft(img_gauss_noise, variances(var)) );
        title(['variance: ' num2str(variances(var))]);
end

% Removing the Salt and Pepper Noise.
figure;
sgtitle('Gaussian Smoothing of Salt and Pepper Noise');

for var = 1 : length(variances)
        subplot(2, 4, var);
        % Applying Gaussian filter to image with s&p noise.
        showgrey( gaussfft(img_sap_noise, variances(var)) ); 
        title(['variance: ' num2str(variances(var))]);    
end


%% Median filtering with different window sizes.

height_gauss = size(img_gauss_noise, 1);
height_sap = size(img_sap_noise, 1);

% Window sizes for the median filter.
window_sizes = [2, 4, 8];

figure;
sgtitle('Median filtering of Gaussian Noise');

for     i = 1 : length(window_sizes)
        subplot(1, 3, i);
        % Applying Median filter to image with Gaussian noise.
        showgrey(medfilt(img_gauss_noise, window_sizes(i)));
        title(['Window size (w&h) : ' num2str(window_sizes(i)) ] );       
end

figure;
sgtitle('Median filtering of Salt & Pepper Noise');

for     i = 1 : length(window_sizes)
        subplot(1, 3, i);
        % Applying Median filter to image with S&P noise.
        showgrey(medfilt(img_sap_noise, window_sizes(i)));
        title(['Window size (w&h) : ' num2str(window_sizes(i)) ] );       
end

%% Ideal Low Pass Filtering of Salt & Pepper Noise and Gaussain Noise.

cut_off_freq = [0.5, 0.2, 0.1];

figure;
sgtitle('Ideal Low Pass Filtering for Gaussian and S&P noise');

for     i = 1 : length(cut_off_freq)
        subplot(2,3,i);
        % Applying Ideal Low Pass filter to image with Gaussian noise.
        filtered_img = ideal(img_gauss_noise, cut_off_freq(i));
        showgrey(filtered_img);
        title(['Cut-off Frequency : ' num2str(cut_off_freq(i)) ] );       
end

for     i = length(cut_off_freq)+1 : 2*length(cut_off_freq)
        subplot(2,3,i);
        % Applying Ideal Low Pass filter to image with S&P noise.
        filtered_img = ideal(img_sap_noise, cut_off_freq(i-length(cut_off_freq)));
        showgrey(filtered_img);
        title(['Cut-off Frequency : ' num2str(cut_off_freq(i-length(cut_off_freq))) ] );       
end