function grad_mag = calculate_gradient_magnitude(dx_img, dy_img)
% Calculate the gradient magnitude of the x and y wise derivative.

grad_mag = sqrt(dx_img .^2 + dy_img .^2);

end

