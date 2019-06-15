close all;
clear;

%% Convolutions of discretized gaussian kernels with varying variances and impulses
variances = [0.1, 0.3, 1, 10, 100];
figure;
sgtitle('Convolutions of discretized gaussian kernel and an impulse');

 for plotId = 1 : length(variances)
     
    subplot(2, 3, plotId);
    % Smoothing image with a Gaussian Filter with a certain variance.
    img_smooth_gauss = gaussfft(deltafcn(128, 128), variances(plotId));
    var = variance(img_smooth_gauss);
    showgrey(img_smooth_gauss);
    title(['Kernel var = ' num2str(variances(plotId))]);
    
 end

%% Plot of the impulses.

figure;
subplot(2,1,1);
showgrey(deltafcn(128, 128));
title('Impulse 2D');

subplot(2,1,2);
surf(deltafcn(128, 128));
title('Impulse 3D');
