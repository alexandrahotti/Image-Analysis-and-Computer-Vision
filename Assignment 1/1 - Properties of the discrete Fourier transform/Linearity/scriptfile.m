close all;
clear;

%% Create images
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)]; %original F
G = F';
H = F + 2 * G;

plot_images(F, G, H);


%% The discrete Fourier transforms of the images.
Fhat = fft2(F); Ghat = fft2(G); Hhat = fft2(H);

%Plot the fourier spectras of the images.
plot_fourierspectras(Fhat, Ghat, Hhat, 'Fourier spectra Fhat', 'Fourier spectra Ghat', 'Fourier spectra Hhat');

%Plot the centered fourier spectras of the images.
plot_fourierspectras(fftshift(Fhat), fftshift(Ghat), fftshift(Hhat), 'Centered Fourier spectra Fhat', 'Centered Fourier spectra Ghat', 'Centered Fourier spectra Hhat');


%% Fourier spectra in 3D - A Sinc Function 
plot_fourierspectra_3D( Fhat, 'Magnitude of Fourier Spectrum for Fhat' );


%% Linearity - Addition in the Spatial domain equals Addition in the Frequency domain.
f = figure;
subplot(1, 2, 1);

% A random Addition in the Frequency domain.
Hhat_freq = Fhat + 2*Ghat;

showgrey(log( 1+abs(fftshift(Hhat_freq)) ));
title('Addition in the Frequency Domain');

% Hhat is the transformation of the image: F + 2 * G.
% Thus, here the addition is performed in the spatial domain.
subplot(1, 2, 2);
showgrey( log(1+abs(fftshift(Hhat))) );
title('Addition in the Spatial Domain');
