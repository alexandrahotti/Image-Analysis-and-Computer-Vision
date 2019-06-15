close all;
clear;

male_pic = male128;
variances = [0.1, 0.5, 1, 4, 16, 64, 256];

%% A Gaussina filter applied to an Image.
sgtitle('Gaussian Filter applied to Image');

% The original image.
subplot(2, 4, 1);
showgrey(male_pic);
title('Original Image');

% Gaussian Filters of different sizes applied to an Image.
 for plotId = 1 : length(variances)
     
    subplot(2, 4, plotId + 1);
    % Smoothing image with a Gaussian Filter with a certain variance.
    img_smooth_gauss = gaussfft(male_pic, variances(plotId));
    showgrey(img_smooth_gauss);
    title(['Kernel var = ' num2str(variances(plotId))]);
    
 end
