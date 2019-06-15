close all;
clear;

%% Create images 
F = [zeros(60, 128); ones(8, 128); zeros(60, 128)].*[zeros(128, 48) ones(128, 32) zeros(128, 48)];
G = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G_trans = G';

% Plot scaled image.
figure;
showgrey(F);
title('Image 1 - scaled');

% Create and plot a corresponding unscaled image.
figure;
showgrey(G.* G_trans);
title('Image 2 - unscaled');

%% Create and plot fourier transformations of the images.
figure;
showfs(fft2(G .* G_trans));
title('Fourier spectrum Image 2 - unscaled');

figure;
showfs(fft2(F));
title('Fourier spectrum Image 1 - scaled');