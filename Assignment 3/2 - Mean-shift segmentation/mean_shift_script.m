close all; clear all;

%% The parameters of the mean shift segmentation.
scale_factor = 0.5;       % Image downscale factor.
spatial_bandwidths = [5, 10, 15, 20]; % Spatial bandwidth for the mean shift segmentation.
colour_bandwidth = 1.2; %[1, 1.2, 1.5];   % Colour bandwidth for the mean shift segmentation.
num_iterations = 40;      % Number of mean-shift iterations.
image_sigma = 1.0;        % Image preblurring scale.

%% Store images.
images.tiger1 = imread( 'tiger1.jpg' );
images.tiger2 = imread( 'tiger2.jpg' );
images.tiger3 = imread( 'tiger3.jpg' );
images.orange = imread( 'orange.jpg' );

image_names = fieldnames(images);
no_images = size(image_names, 1);

%% Number of parameters to varry.

no_colour_bandwidths = size(spatial_bandwidths, 2);

%% Mean shift segmentation for every image in the struct.
for i = 1 : no_images

figure;
sgtitle(['Mean-shift segmentation using: spatial bandwidths = ' num2str(spatial_bandwidths) ]);
img_idx = 1;
    
   for sb = 1 : no_colour_bandwidths
    
    image_original = images.(image_names{i});

    % Rescaling the image.
    image_original = imresize(image_original, scale_factor);

    % Blurring the image with a Gaussina filter.
    d = 2 * ceil( image_sigma * 2 ) + 1; 
    h = fspecial( 'gaussian', [d d], image_sigma );
    image_blurred = imfilter(image_original, h);
    
    % Mean shift segmentation of the image.
    mean_shift_segments = mean_shift_segm(image_blurred, spatial_bandwidths(cb), colour_bandwidth, num_iterations);
    
    %% Plot the segmented images.
    image_mean_segments = mean_segments( image_original, mean_shift_segments );
    image_overlayed_curves = overlay_bounds( image_original, mean_shift_segments );
    
    subplot(4, 2, img_idx); 
    imshow( image_mean_segments ); 
    img_idx = img_idx + 1;
    title( 'Image superpixels')
    
    subplot(4, 2, img_idx); 
    imshow( image_overlayed_curves ); 
    img_idx = img_idx + 1;
    title( 'Segmented image')
    
   end
end

