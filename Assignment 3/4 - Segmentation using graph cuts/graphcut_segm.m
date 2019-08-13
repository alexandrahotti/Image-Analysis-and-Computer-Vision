function [ segm, prior ] = graphcut_segm(image, area, K, alpha, sigma)
% Performs a graph cut segmentation on an image using small windows.

% Image dimensions.
[height, width, ~] = size(image);

%% Defining a mask used to segment the foreground from the background of the image.
dw = area(3) - area(1) + 1;
dh = area(4) - area(2) + 1;

mask = uint8([zeros(area(2)-1,width); zeros(dh,area(1)-1), ones(dh,dw), ...
	     zeros(dh,width-area(3)); zeros(height-area(4),width)]);

 
grey = single( rgb2gray(image) );
height = fspecial( 'gaussian', [7, 7], 0.5 );

grey = imfilter( grey, height );
height = fspecial( 'sobel' );

dx = imfilter( grey, height/4 );
dy = imfilter( grey, height/4' );

grad = sqrt( dx.^2 + dy.^2 );
edge = (alpha*sigma) * ones( size(grey) ) ./ (grad + sigma);

tic
for l=1:3
    
    fprintf( 'Find Gaussian mixture models...\n' );
    
    fprob = mixture_prob( image, K, 10, mask );
    bprob = mixture_prob( image, K, 10, 1 - mask );
    prior = reshape( fprob ./ (fprob + bprob), size(image, 1), size(image, 2), 1 );
    toc

    fprintf('Find minimum cut...\n');
    [u, ~, ~] = cmf_cut(prior, edge);
    mask = uint8( u > 0.5 );
    toc

end

segm = int16(u>0.5) + 1;

