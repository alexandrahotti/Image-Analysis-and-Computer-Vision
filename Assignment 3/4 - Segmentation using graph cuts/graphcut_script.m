close all; clear all;

%% Defining parameters of the graph cut algorithm.
scale_factor = 0.5;            % Image downscale factor.
areas = [ 80, 110, 570, 300 ]; % Image region to train foreground with.
K = 6;                         % Number of mixture components.
alpha = 20.0;                  % Maximum edge cost.
sigma = 15.0;                  % Edge cost decay factor.

%% Loading and pre-processing the image.
image_original = imread( 'tiger3.jpg' );
image_original = imresize( image_original, scale_factor );

% Setting area for the window used to mask the image graph.
areas = int16( areas * scale_factor );

%% The Graph Cut.
[ segraphcut_segmgments, prior_foreground_probabilities, ] = graphcut_segm( image_original, areas, K, alpha, sigma );

image_mean_segment = mean_segments( image_original, segraphcut_segmgments );
image_segment_curves = overlay_bounds( image_original, segraphcut_segmgments );

%% Plotting the resulting segmentation.
figure;
sgtitle(['Graph Cut segmentation with Gaussian Mixture Models, K = ' num2str(K)])
subplot(1, 3, 1); imshow( image_mean_segment ); title( 'Image mean segments' );
subplot(1, 3, 2); imshow( image_segment_curves ); title( 'Segmentation curves' );
subplot(1, 3, 3); imshow( prior_foreground_probabilities ); title( 'Prior Foreground Probabilities,' );
