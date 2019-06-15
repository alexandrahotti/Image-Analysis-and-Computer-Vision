function plot_fourierspectra_3D(Fhat, caption )
%Creates plot of Magnitude of Fourier Spectrum 

figure;
surf( log(1+abs(fftshift(Fhat))) );
title(caption);
end