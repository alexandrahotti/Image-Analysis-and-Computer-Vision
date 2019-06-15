function plot_fourierspectras(Fhat, Ghat, Hhat, F_title, G_title, H_title )
%Creates subplots of 3 images.

%fourier spectras
figure;
subplot(3, 2, 1);
showgrey( log(1 + abs(Fhat)) );
title(F_title);

subplot(3, 2, 2);
showgrey( log(1 + abs(Ghat)) );
title(G_title);

subplot(3, 2, 3);
showgrey( log(1 + abs(Hhat)) );
title(H_title);
end

