close all; clear all;

%% Parameters of the K-means clustering.
% Number of clusters.
K = 6;               
% Number of iterations.
no_iterations = 9;
% Seed used for sampling initial clusters.
seed = 66664;
% Image downscaling factor applied to image before segmentation.
scale_factor = 1;  
% Amount of preblurring applied to image before segmentation.
image_sigma = 1;

%% Load image.
Image_original = imread( 'tiger3.jpg' );

% Scaling the image.
image = imresize( Image_original, scale_factor );

% Blurring the image by filtering it with a Gaussian.
d = 2 * ceil( image_sigma * 2 ) + 1;
h = fspecial('gaussian', [d d], image_sigma);
image = imfilter(image, h);

tic
random_cluster_init = false;
[ segm, centers] = kmeans_segm(image, K, no_iterations, seed, random_cluster_init);

toc

image_mean_segments = mean_segments(Image_original, segm);
image_overlayed_curves = overlay_bounds(Image_original, segm);

figure;
sgtitle(['An image segmented with the K-means algorithm with: K = ' num2str(K)', ', no iterations = ' num2str(no_iterations) ]);
subplot(1, 2, 1);
imshow( image_overlayed_curves )
title('Segmented image')

subplot(1, 2, 2);
imshow( image_mean_segments )
title('Image superpixels')

