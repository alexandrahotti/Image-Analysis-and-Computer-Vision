close all;
clear;

%% Create two arbitrary images.
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';

%% Plot the Images
f1 = figure;
showgrey(F);
title('Image F');

f2 = figure;
showgrey(G);
title('Image G');

%% Compute the Fast Fourier Transformations.
Fhat = fft2(F); Ghat=fft2(G);

%% Plot the magnitude of the multiplication of the two images.
f3 = figure;
showgrey(F.*G);
title(' The multiplication between the two images - F.*G');

% Plot the magnitude of the fourier transform of the multiplication of the two images.
f4 = figure;
showfs(fft2(F.*G));  
title('The fourier transform of the multiplication between the two images - fft2(F.*G)');


%% Convolution in one domain is multiplication in the other domain.

f5 = figure;

subplot(1, 2, 1);
[m, n] = size(F);
sz = m * n;
showfs(fftshift(conv2(fftshift(Fhat),fftshift(Ghat))/sz));
title('Convolution in the fourier domain');

subplot(1, 2, 2);
showfs(fft2(F.*G));
title('Multiplication in the spatial domain');
