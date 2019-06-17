function [dx_img, dy_img] = differentiate_image(img, difference_operator_x, difference_operator_y )
% Differentiates an image in the x and y direction using a given difference
% operator.

dx_img = conv2(img, difference_operator_x, 'same');
dy_img = conv2(img, difference_operator_y, 'same');

end

