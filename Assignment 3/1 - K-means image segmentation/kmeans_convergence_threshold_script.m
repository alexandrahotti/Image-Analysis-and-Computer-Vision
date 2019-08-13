close all; clear all;

%% Parameters of the K-means clustering w/ a threshold.
% Number of clusters.
K = 24;               
% Seed used for sampling initial clusters.
seed = 66664;
% Image downscaling factor applied to image before segmentation.
scale_factor = 1;  
% Amount of preblurring applied to image before segmentation.
image_sigma = 1;

% Threshold for the cluster center update, which corresponds to the maximum
% euclidean distance moved by all of the cluster centers. 
threshold = 0.01;

%% Store images.
% images.tiger1 = imread( 'tiger1.jpg' );
% images.tiger2 = imread( 'tiger2.jpg' );
% images.tiger3 = imread( 'tiger3.jpg' );
images.orange = imread( 'orange.jpg' );


image_names = fieldnames(images);
no_images = size(image_names, 1);

for i = 1 : no_images

image_original = images.(image_names{i});
 
% Scaling the image.
image = imresize( image_original, scale_factor );

% Blurring the image by filtering it with a Gaussian.
d = 2 * ceil( image_sigma * 2 ) + 1;
h = fspecial('gaussian', [d d], image_sigma);
image = imfilter(image, h);

tic

% Sampling initial cluster centers from the image.
random_cluster_init = false;
[ segmentation, cluster_centers, convergence_counter ] = kmeans_segm_convergence_threshold( image, K, seed, random_cluster_init, threshold );

toc

% Get the image mean segments.
image_mean_segments = mean_segments(image_original, segmentation);

% Overlay curves on top of the image based on the color clusters.
image_overlayed_curves = overlay_bounds(image_original, segmentation);

figure;
sgtitle(['An image segmented with the K-means algorithm with: no iterations = ' num2str(convergence_counter) ' and K = ' num2str(K) ]);
%sgtitle(['An image segmented with the K-means algorithm with: K = ' num2str(K) ]);
subplot(1, 2, 1);
imshow( image_overlayed_curves )
title( 'Segmented image' )

subplot(1, 2, 2);
imshow( image_mean_segments )
title( 'Image superpixels' )

end
