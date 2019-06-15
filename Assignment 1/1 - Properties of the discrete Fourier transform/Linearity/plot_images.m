function plot_images(F, G, H)
%Creates subplots of 3 images.

subplot(3, 2, 1);
showgrey(F);
title('image F')

subplot(3, 2, 2);
showgrey(G);
title('image G')

subplot(3, 2, 3);
showgrey(H);
title('image H');
end

