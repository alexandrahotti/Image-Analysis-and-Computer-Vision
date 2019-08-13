function [ segmentation,centers,counter ] = kmeans_segm_thr( image,K,seed,threshold)

counter=0;
max_dist=1000;

image_float = im2double(image);
image_w= size(image, 1);
image_h= size(image, 2);

nopixels=image_w*image_h;

Ivec = reshape(image_float, nopixels, 3);

cluster_centers_new = zeros(K, 3);
%disp(size(Ivec));

rng(seed,'twister');
%colours = rand(K, 3);
%Dark
%colours_first=[255 50 0; 255 255 255];
%Light
%colours_first=[255 240 0; 255 255 255];

%colours_first=[255 150 0; 255 255 255];


center_coords = randsample(nopixels, K);

for k = 1 : K
   cluster_centers_new(k, :) = Ivec(center_coords(k), :);
end

D = pdist2(cluster_centers_new, Ivec, 'euclidean');
%disp(size(D))
% Iterate L times
%for l = 1 : L
while(max_dist>threshold)
counter=counter+1;

% Assign each pixel to the cluster center for which the distance is minimum

%[Y,I] = min(D,[],1);
[~,I]=min(D);
cluster_centers_old=cluster_centers_new;
for k=1:K
    
pixels_closest_center_K = find(I == k);
cluster_centers_new(k,:)=mean(Ivec(pixels_closest_center_K , :));
end

%disp(size(cluster_centers_new))
%disp(size(cluster_centers_old))
diff=abs(cluster_centers_new-cluster_centers_old);
max_dist=max(diff(:));

D = pdist2(cluster_centers_new, Ivec, 'euclidean');

end

[Y,I] = min(D,[],1);
segmentation = reshape(I, image_w, image_h);
centers = cluster_centers_new;
end

