close all;
clear;

diff_operators = cell(4, 3);

%% Defining the difference operators.

%% The simple difference operators.

% Simple difference operator in x direction.
diff_operators{1, 1} = [-1 0 1];
% Simple difference operator in y direction.
diff_operators{1, 2} = [-1 0 1]';

diff_operators{1, 3} = 'Simple difference operator';

%% The central difference operators.

% Central difference operator in x direction.
diff_operators{2, 1} = [-0.5 0 0.5];
% Central difference operator in y direction.
diff_operators{2, 2} = [-0.5; 0; 0.5];

diff_operators{2, 3} = 'Central difference operator';

%% The Robert’s diagonal operator.

% The Robert’s diagonal operator in x dir.
diff_operators{3, 1} = [1 0; 0 -1];
% The Robert’s diagonal operator in y dir.
diff_operators{3, 2} = [0 1; -1 0];

diff_operators{3, 3} = 'Robert’s diagonal operator';

%% The Sobel operators.

% The Sobel operators in x direction.
diff_operators{4, 1} =  [-1 0 1; -2 0 2; -1 0 1];
% The Sobel operators in y direction.
diff_operators{4, 2} =  [1 2 1; 0 0 0; -1 -2 -1];

diff_operators{4, 3} = 'Sobel operator';

%% The image used for differentiation.
tools_img = few256;

[x_tools_sz, y_tools_sz] = size(tools_img);
disp(['Size Image: ' num2str(x_tools_sz) 'x' num2str(y_tools_sz)]);

figure;
sgtitle('Differentiating an image with difference operators.');

img_ind = 1;
for diff_op = 1 : 4
    
    % Convolve the image with the difference operators in the x and y
    % direction.
    dx_img = conv2(tools_img, diff_operators{diff_op, 1}, 'valid');
    dy_img = conv2(tools_img, diff_operators{diff_op, 2}, 'valid');
    
    
    subplot(2, 4, img_ind);
    showgrey(dx_img);
    title([diff_operators{diff_op, 3} ' X dir']);
    
    img_ind = img_ind + 1; 
    
    subplot(2, 4, img_ind)
    showgrey(dy_img);
    title([diff_operators{diff_op, 3} ' Y dir']);
    
    img_ind = img_ind + 1; 
    
    % The size of the differentiated image.
    [x_sz, ~] = size(dx_img);
    [~, y_sz] = size(dy_img);
    
    disp(['Size Image Differentiated via ' diff_operators{diff_op, 3} ': ' num2str(x_sz) 'x' num2str(y_sz)]);
end