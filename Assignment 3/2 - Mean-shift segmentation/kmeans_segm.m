function [ segmentation, cluster_centers ] = kmeans_segm( image, K, no_iterations, seed, random_cluster_init )
% Performs k-means segmentation on the pixels of an image to create
% superpixels, i.e. clustered pixels.

% Set a seed for the sampling.
rng(seed);

%% Define parameters used in the clustering.

% The image dimensions.
[image_width, image_height, ~] = size(image);

no_pixels = image_width * image_height;

% Conversion of image RGB integer values into float data types.
image_float = im2double( image );

% Since Matlab prefers operating on 2D arrays for maximum speed, the image 
% is reshaped from a 3D array of size (H; W; 3) to one with the size (W*H; 3).
image_array = reshape(image_float, no_pixels, 3);


%% Initlize the centers of the k-clusters.

% A matrix to store the cluster centers.
cluster_centers = zeros(K, 3);


if random_cluster_init 
    % Random cluster centers initlization.
    center_coords = randsample( no_pixels, K );
else
    % Cluster centers initlization from image RBG values.
    center_coords = round( rand(K, 1) * size(image_array, 1) );
end

% Store the intilized cluster centers in center_coords.
cluster_centers = image_array(center_coords(:),:);



% Compute the distance between the initlized centers colors and every single pixel
% color.
center_pixel_distances = pdist2( cluster_centers, image_array, 'euclidean' );

% For a predefined number of iterations the K clusters are readjusted to the 
% pixels in the image. 
for it = 1 : no_iterations

    % Retrive the current closest cluster for each pixel.
    [~, closest_cluster] = min( center_pixel_distances, [], 1 );

for k = 1 : K
    
        % For every single cluster, assign and store all the closets pixels to this
        % cluster.
        pixels_closest_center_K = find( closest_cluster == k ); 
        
        % Recalculate the new center based on all the new pixels assigned
        % to it.
        cluster_centers(k, :) = mean( image_array( pixels_closest_center_K , :) );
end
    % Calcuate the distances from the new centers from all pixels.
    center_pixel_distances = pdist2( cluster_centers, image_array, 'euclidean' );
end

% Retrive the final clusters.
[ ~, final_clusters ] = min( center_pixel_distances,[], 1 );

% Reshape the image.
segmentation = reshape(final_clusters, image_width, image_height);

end

