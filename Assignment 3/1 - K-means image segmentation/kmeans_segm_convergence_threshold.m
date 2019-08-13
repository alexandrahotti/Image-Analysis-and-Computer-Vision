function [ segmentation, cluster_centers, convergence_counter ] = kmeans_segm_convergence_threshold( image, K, seed, random_cluster_init, threshold )
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

% Maximum distance between old cluster centers and new cluster centers set
% to an initial arbitary large value.
max_center_update = 1000;

% No iterations until convergence initilized.
convergence_counter = 0;

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


%% Compute the distance between the initlized centers colors and every single pixel color.
center_pixel_distances = pdist2( cluster_centers, image_array, 'euclidean' );

% Update the cluster centers until all of them have moved less than a
% predefined threshold between 2 iterations.
while( max_center_update > threshold )
    
    convergence_counter = convergence_counter + 1;
    % Retrive the current closest cluster for each pixel.
    [~, closest_cluster] = min( center_pixel_distances, [], 1 );
    
    % A varible used to store the cluster centers from the previous iteration.
    cluster_centers_old = cluster_centers;
for k = 1 : K
    
        % For every single cluster, assign and store all the closets pixels to this
        % cluster.
        pixels_closest_center_K = find( closest_cluster == k ); 
        
        % Recalculate the new center based on all the new pixels assigned
        % to it.
        cluster_centers(k, :) = mean( image_array( pixels_closest_center_K , :) );
end
    % Calculate the distances between the center coordinates from the
    % previous and the current iteration.
    center_update_difference = abs( cluster_centers - cluster_centers_old );
    
    % The maximum distance that all of the centers have moved between two
    % iterations.
    max_center_update = max(center_update_difference(:));
    
    % Calcuate the distances between the new centers and all pixels.
    center_pixel_distances = pdist2( cluster_centers, image_array, 'euclidean' );
end

% Retrive the final clusters.
[ ~, final_clusters ] = min( center_pixel_distances,[], 1 );

% Reshape the image to (W,H,RGB).
segmentation = reshape(final_clusters, image_width, image_height);

end