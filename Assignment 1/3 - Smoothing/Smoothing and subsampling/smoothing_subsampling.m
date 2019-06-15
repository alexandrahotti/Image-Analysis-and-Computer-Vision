%% The effects of smoothing after subsampling.

img = phonecalc256;

gaussian_smoothing = img; low_pass_filter_smoothing = img;

N = 5; % Number of times the image is smoothed and subsampled.
cut_off_freq = 0.5; % The cut off frequency.
var = 0.5; % The variance used in the Gaussian filter.

figure;
sgtitle('Subsampling with and without smoothing');

for i = 1 : N
    
    if i > 1
        % Smooth the unsampled image.
        img_gauss_smooth = gaussfft(img, var);
        img_ideal_smooth = ideal(img, cut_off_freq);
        
        % Subsample the image before smoothing it.
        img = rawsubsample(img);
        img_gauss_smooth = rawsubsample(img_gauss_smooth);
        img_ideal_smooth = rawsubsample(img_ideal_smooth);         
    end
    
    %Plot subsampled image without smoothing.
    subplot(3, N, i)
    showgrey(img);
    
    %Plot subsampled image with Gaussian smoothing.
    subplot(3, N, i+N)
    showgrey(img_gauss_smooth);
    
    %Plot subsampled image with ideal low pass filtering.
    subplot(3, N, i+2*N)
    showgrey(img_ideal_smooth);

end