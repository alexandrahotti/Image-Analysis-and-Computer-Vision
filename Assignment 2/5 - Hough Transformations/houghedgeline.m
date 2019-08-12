function [linepair accumulator_space] = houghedgeline(pic, scale, threshold, nrho, ntheta, nlines, monotonic_accumulator_increment)
% Houghedgeline first performs an edge detection step and then applies a Hough transform to the result
% to find edge lines from edge segments.

% nrho: the number of accumulators in the rho direction.
% ntheta: the number of accumulators in the theta direction.
% scale: The variance used in to compute the smoothened 
% intensity function L of the image.
% nrho: is the number of accumulators in the rho direction,
% ntheta: is the number of accumulators in the theta direction.
% threshold: is the lowest value allowed for the given magnitude.
% nlines: is the number of lines to be extracted.

%% Extract edge segments from the image.
% curves are the polygons from which the transform is to be computed.
curves = extractedge( pic, scale, threshold, 'same' );

%% Compute the gradient magnitude of L at each pixel in an image.
% Compute the smoothed intensity of the image.
L = discgaussfft( pic, scale );

% Compute L_v, i.e. the differention of L in the v direction.
L_v = Lv( L , 'same' );

% magnitude is an image with one intensity value per pixel.
magnitude = sqrt( L_v );


%% Use the gradient magnitudes and edge segments to find line segments using the hough transformation.
% linepar is a list of (rho; theta) parameters for each line segment,
[linepair, accumulator_space]= houghline( curves, magnitude, nrho, ntheta, threshold, nlines, monotonic_accumulator_increment );

end

