%% Thresholding on gradient magnitudes. %%

close all;
clear;

%% Define the Difference operators.
diff_operators = cell(4, 4);

% The simple difference operators.
diff_operators{1, 1} = [-1 0 1];
diff_operators{1, 2} = [-1 0 1]';
diff_operators{1, 3} = 'Simple difference operator';
% Thresholds for this operator.
diff_operators{1, 4} = [5, 10, 20, 40, 60, 75];
 
% Central differences operators.
diff_operators{2, 1} = [-0.5 0 0.5];
diff_operators{2, 2} = [-0.5; 0; 0.5];
diff_operators{2, 3} = 'Central difference operator';
% Thresholds for this operator.
diff_operators{2, 4} = [5, 10, 20, 30, 50, 60];

%Robert’s diagonal operator http://homepages.inf.ed.ac.uk/rbf/HIPR2/roberts.htm
diff_operators{3, 1} = [1 0; 0 -1];
diff_operators{3, 2} = [0 1; -1 0];
diff_operators{3, 3} = 'Robert’s diagonal operator';
% Thresholds for this operator.
diff_operators{3, 4} = [5, 10, 20, 50, 70, 100];

% The sobel operator.
diff_operators{4, 1} = [-1 0 1; -2 0 2; -1 0 1];
diff_operators{4, 2} = [1 2 1; 0 0 0; -1 -2 -1];
diff_operators{4, 3} = 'Sobel operator';
% Thresholds for this operator.
diff_operators{4, 4} = [10, 30, 90, 150, 200, 250];

%% Thresholding the gradient magnitude of the image.

tools = godthem256; few = few256;

for diff_op = 1 : 4
    % Differentiate the image x- and y-wise.
    [dx_img, dy_img] = differentiate_image(tools, diff_operators{diff_op, 1}, diff_operators{diff_op, 2});
    % Calculate the gradient magnitude.
    grad_mag = calculate_gradient_magnitude(dx_img, dy_img);
    
    figure;
    histogram(grad_mag);
    title(['Pixel Intensity Magnitudes for the: ' diff_operators{diff_op, 3}])
    xlabel('Pixel Intensity Magnitudes')
    ylabel('Number of Pixels')
    
    figure;
    sgtitle(['Point-Wise thresholding of gradient magnitudes using the: ' diff_operators{diff_op, 3}]);
    
    thresholds = diff_operators{diff_op, 4};
    for thr = 1 : length(thresholds)
        subplot(2, 3, thr);
        % Threshold the gradient magnitude.
        thresholded_grad_magnitude = ( grad_mag - thresholds(thr) ) > 0;
        showgrey(thresholded_grad_magnitude);
        title(['Threshold: ' num2str(thresholds(thr))])
    end
end
