close all; clear all;

%% Store original and subsampled images in a struct.

images.triangle.original = triangle128;
images.triangle.subsampled = binsubsample(triangle128);

images.triangles.original = houghtest256;
images.triangles.subsampled = binsubsample(houghtest256);

images.house.original = godthem256;
images.house.subsampled = binsubsample(godthem256);

%% Perform the Hough line detection for each image in the struct.

image_names = fieldnames(images);
no_images = size(image_names, 1);

for i = 1 : no_images
% Defining parameters and variables for the Hough Transformation.

curr_image = images.(image_names{i}).original;

% Image size.
N = size( curr_image , 2);

% Number of possible theta values in the accumulator space. I.e. the no 
% angles in the range -90 0 90.
ntheta = 181; 

% Number of possible rho values in the accumulator space. Which corresponds
% to the range: [-sqrt(2)D, sqrt(2)D] which is the length of the image diagonal.
% Source: p. 757 R. Gonzalez and R. Woods: “Digital Image Processing”, Prentice Hall, 2008.
nrho = 2 * 2 * ( N-1 );

% The image gradient.
preserve_image_shape = 'same';
image_gradient_magnitude = sqrt( Lv(curr_image, preserve_image_shape) );

D = sqrt( size(image_gradient_magnitude, 1)^2 + size(image_gradient_magnitude, 2)^2 );

% Number of lines to extract from the image.
nlines = 12;

% The increment used to update the accumulator.
monotonic_accumulator_increment = true;

% Parameters used to filter and threshold the filtered image.
filtering_scale = 4;
image_gradient_threshold = 8;

% Detection of nlines number of lines in the image.
% line_pairs is the parameters of the extracted lines in the image.
% acc is the accumulator space for the image.
[line_pairs, acc] = houghedgeline( curr_image, filtering_scale, image_gradient_threshold, nrho, ntheta, nlines, monotonic_accumulator_increment );


%% Display the found linepairs.

display_linepairs(line_pairs);

%% Plot the Accumulator Space.
figure;
sgtitle(['Hough transformation results of the image: ' image_names(i)])
% Smooth the accumulator space so that it gets easier to visualize the curves.
smoothed_acc_space = binsepsmoothiter(acc, 0.5, 1);
subplot(1, 2, 1);
showgrey( smoothed_acc_space );
title('Accumulator space for the Hough transformation');

%% Plot the extracted lines on top of the image.

% Convert the rho, theta line pairs into linear lines.
hough_lines = linear_parametrization_hough_lines(line_pairs, D);

% Overlay and plot the extracted lines from the hough transformation on top 
% of the corresponding image.
subplot(1, 2, 2);
overlaycurves(image_gradient_magnitude, hough_lines);
axis([1 size(image_gradient_magnitude, 2) 1 size(image_gradient_magnitude, 1)]);
title('Extracted lines from the Hough transformation');

end