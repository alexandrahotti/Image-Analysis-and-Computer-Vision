function fftwave(u, v, sz)
% Input: coordinates of a point in the fourier space.
% Creates a plot of a point in the fourier space and 
% its corresponding inverse fourier transformation in 
% the spatial domain.

if (nargin < 2)
  error('Requires at least two input arguments.')
end
if (nargin == 2)
sz = 128; 
end


Fhat = zeros(sz); % Fhat is vector used to store a point in the fourier space.
Fhat(u, v) = 1;

F = ifft2(Fhat); % % An inverse fourier transform.
Fabsmax = max(abs(F(:)));

% Plot of the point in the frequency space/fourier domain.
subplot(3, 2, 1);
showgrey(Fhat);
title(sprintf('Fhat: (u, v) = (%d, %d)', u, v))

% center coordinates within range [-pi,pi]
[ vc, uc ] = center_coordinates(u, v, sz);

% Calculate wave length and amplitude
wavelength = calculate_wavelength(uc, vc);
amplitude = calculate_amplitude(Fhat, sz);

% Plot of the point in the frequency space/fourier domain with centered coordinates.
subplot(3, 2, 2);
showgrey(fftshift(Fhat));
title(sprintf('centered Fhat: (uc, vc) = (%d, %d)', uc, vc))

% Plot of the real part of the image in the spatial domain.
subplot(3, 2, 3);
showgrey(real(F), 64, -Fabsmax, Fabsmax);
title('real(F)')

% Plot of the imaginary part of the image in the spatial domain.
subplot(3, 2, 4);
showgrey(imag(F), 64, -Fabsmax, Fabsmax);
title('imag(F)')

% Plot of the amplitude of the image in the spatial domain.
subplot(3, 2, 5);
showgrey(abs(F), 64, -Fabsmax, Fabsmax);
title(sprintf('abs(F) (amplitude %f)', amplitude))

% Plot of the wavelength of the image in the spatial domain.
subplot(3, 2, 6);
showgrey(angle(F), 64, -pi, pi);
title(sprintf('angle(F) (wavelength %f)', wavelength))

end