close all; clear all;

%% The parameters of the Normalized Graph Cut Segmentation.
colour_bandwidth = 20.0; % Color bandwidth.
radius = [1, 4, 7];              % Maximum neighbourhood distance.  
ncuts_thresh = 0.03;     % Nutting threshold.
min_areas = 200;         % Minimum area of segment.
max_depth = 3;           % Maximum splitting depth.
scale_factor = 0.4;      % Image downscale factor.
image_sigma = 2.0;       % Image preblurring scale.

img_idx = 0;
no_radiuses = size(radius, 2);

figure;

sgtitle(['Image Segmentation - Normalized Graph Cut, radiuses = ' num2str(radius) ]);

for i = 1 : no_radiuses
    img_idx = img_idx + 1 ;

    image_original = imread('orange.jpg');
    
    %% Pre-processing the image.
    % Rescaling the image.
    image_original = imresize(image_original, scale_factor);
    
    % Pre blurring the image with a Gaussina filter.
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    image_blurred = imfilter(image_original, h);
    
    %% Segmentation using Normalized Graph Cuts.
    norm_cut_segmentation = norm_cuts_segm(image_blurred, colour_bandwidth, radius(i), ncuts_thresh, min_areas, max_depth);
    
    %% Plotting the segmented images.
    image_mean_segments = mean_segments(image_original, norm_cut_segmentation);
    image_overlayed_curves = overlay_bounds(image_original, norm_cut_segmentation);

    subplot(no_radiuses, 2, img_idx);
    imshow(image_mean_segments);    

    img_idx = img_idx + 1;
    subplot(no_radiuses, 2, img_idx);
   
    imshow(image_overlayed_curves);
    
    %pause
end
