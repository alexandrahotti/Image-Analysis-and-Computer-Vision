close all;
clear all;

%% Defining parameters and variables for the edge extraction.

%Images to extract images from.
tools_image = few256;
house_image = godthem256;

% parameters for edge extraction
variance = 4;
shape = 'same';

threshold_gradient_magnitude_house = 20;
threshold_gradient_magnitude_tools = 24;


%% Extraction of edges for both images.

[ curves_zerocross_house, curves_mag_house ] = extractedge( house_image, variance, threshold_gradient_magnitude_house, shape );
[ curves_zerocross_tools, curves_mag_tools ] = extractedge( tools_image, variance, threshold_gradient_magnitude_tools, shape );

%% Plotting extracted edge curved on top of corresponding images.

% Best scale and threshold value results for the house image.

figure;

% Plotting curves where a magnitude threshold was applied to the image gradient.
sgtitle('Extracted Edge Curves using a Variance/Scale of 4 and a Gradient Magnitude Threshold of 20.');

subplot(1, 2, 1);
overlaycurves( house_image, curves_mag_house )
title('With a Gradient Magnitude Threshold')

subplot(1, 2, 2);
overlaycurves( house_image, curves_zerocross_house)
title('Without a Gradient Magnitude Threshold')


% Best scale and threshold value results for the tools image.

figure;

% Plotting curves where a magnitude threshold was applied to the image gradient.
sgtitle('Extracted Edge Curves using a Variance/Scale of 4 and a Gradient Magnitude Threshold of 24.');

subplot(1, 2, 1);
overlaycurves( tools_image, curves_mag_tools )
title('With a Gradient Magnitude Threshold')

subplot(1, 2, 2);
overlaycurves( tools_image, curves_zerocross_tools)
title('Without a Gradient Magnitude Threshold')
