close all;
clear;

%% Create an image.
F = [zeros(60, 128); ones(8, 128); zeros(60, 128)].*[zeros(128, 48) ones(128, 32) zeros(128, 48)];

figure;
sgtitle('Rotating an image 30\circ');

subplot(2,3,1);
showgrey(F);
title('Image F');

%% Fourier spectrum of image.
subplot(2,3,2);
showfs(fft2(F));
title('Fourier Spectrum F');

%% Fourier spectrum of image and the effects of rotating 30 degrees.

subplot(2,3,3);
G = rot(F, 30);
showgrey(G);
title('F rotated 30\circ');

subplot(2,3,4);
Ghat = fft2(G);
showfs(Ghat);
title('Fourier Spectrum F rotated 30\circ');

subplot(2,3,5);
Hhat = rot(fftshift(Ghat), -30);
showgrey(log(1+abs(Hhat)));  
title('Fourier Spectrum F rotated back 30\circ');

%% Fourier spectrum of image and the effects of rotating X degrees.
figure;
rotations = [30, 45, 60, 90];
img_ind = 1;

sgtitle('Rotation in one domain gives an equal rotation in the other domain');

for     i = 1 : length(rotations)

        subplot(2, 4, img_ind);
        rot_img = rot(F, rotations(i) );
        showgrey(rot_img);
        title(['Image Rotated: ' num2str(rotations(i)) '\circ' ]);
        
        img_ind = img_ind + 1;
        
        subplot(2 ,4, img_ind);
        showfs(fft2(rot_img));
        title([ num2str(rotations(i)) '\circ - Fourier Spectrum']);
        
        img_ind = img_ind + 1;
end