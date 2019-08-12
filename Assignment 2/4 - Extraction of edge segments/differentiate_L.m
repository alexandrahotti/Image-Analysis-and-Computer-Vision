function L_differentiated = differentiate_L(img, scale, L_deriv)

L_differentiated =  L_deriv( discgaussfft(img, scale), 'same' );

end

