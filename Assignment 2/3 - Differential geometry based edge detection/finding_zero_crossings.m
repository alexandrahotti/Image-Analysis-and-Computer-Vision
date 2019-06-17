clear all;
close all;

house_img = godthem256;

scales = [0.0001, 1, 4, 16, 64];
figure;

%% Finding zero crossings of Lvv for an image.

sgtitle('Zero crossings for L_{vv}');

for i = 1:length(scales)
    
    subplot(1, 5, i);
    
    % Compute the zero crossings for the image for a given scale.
    Lvvtilde = differentiate_L(house_img, scales(i), @LVVtilde);
    contour( Lvvtilde, [0,0]);
    
    axis('image');
    axis('ij');
    title( sprintf([ 'Scale: ', num2str(scales(i))]) );
   
end

%% Finding zero crossings of Lvvv for an image.

tools_img = few256;

figure;

sgtitle('Maxmima Zero crossings for L_{vvv}');

for i = 1:length(scales)
    
    subplot(1, 5, i);
    
    % Find the zero crossings for Lvvvtilde.
    Lvvvtilde = differentiate_L(tools_img, scales(i), @LVVVtilde);
    % Extract the negative zero crossings, i.e. the maximas.
    Lvvvtilde_maximas = Lvvvtilde < 0;
    
    showgrey( Lvvvtilde_maximas );
    title( sprintf([ 'Scale: ', num2str(scales(i))]) );
   
end
