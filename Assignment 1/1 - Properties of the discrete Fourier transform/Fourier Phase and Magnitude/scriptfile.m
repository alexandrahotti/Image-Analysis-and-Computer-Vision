%% Define images to be used.
images = cell(3,1);
images{1} = phonecalc128; images{2} = few128; images{3} = nallo128;

no_images = 3;

%% Compute the powerspectrums and add a random phase.
threshold = 10^(-10);

img_ind = 1;

figure;
for     i = 1 : no_images
    
        subplot(3, 3, img_ind);
        showgrey( images{i} );
        title( 'Original images' );

        img_ind = img_ind + 1;
        
        subplot(3, 3 ,img_ind);
        % The power spectrums of the first image.
        powspec_phone = pow2image(images{i}, threshold); 
        showgrey(powspec_phone);
        title('Phases preserved');
 
        img_ind = img_ind + 1;
        
        subplot(3, 3 ,img_ind);
        % Apply the function randphaseimage that keeps the magnitude of the Fourier 
        % transform, but replaces the phase information with a random distribution.
        powspec_phone_rand = randphaseimage(images{i}); 
        showgrey(powspec_phone_rand);
        title('Magnitudes preserved');
        
        img_ind = img_ind + 1;
end
