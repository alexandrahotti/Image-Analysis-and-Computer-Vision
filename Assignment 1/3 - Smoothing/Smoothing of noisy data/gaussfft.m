function [convolved_Image, tmp] = gaussfft( pic,t )
% A function that performs Gaussian filtering using the fast Fourier
% transform by convolving an image  with a two-dimensional Gaussian
% function of arbitrary variance t via a discretization of the Gaussian
% function in the spatial domain.

% Get the dimensions of the image.
[height, width] = size(pic);

x_range = - height * 0.5 : height * 0.5 - 1;
y_range = - width * 0.5 : width * 0.5 - 1;

% Create a grid with the dimensions of the image.
[X, Y] = meshgrid( x_range, y_range );

% A discretization of the Gaussian with variance t.
gauss_kernel = ( 1/( 2*pi*t ) ) *exp ( -(X.^2+Y.^2) / (2*t) );

%Transform the kernel into the fourier domain.
Ghat = fft2(gauss_kernel);

%Transform image into the fourier domain.
Ihat = fft2(pic);

% Convolve the image and the gaussian kernel. By multiplying them in the
% fourier domain.
convolved_Image = fftshift(ifft2( Ihat .* Ghat ));


tmp=Ihat.*Ghat;  

end

