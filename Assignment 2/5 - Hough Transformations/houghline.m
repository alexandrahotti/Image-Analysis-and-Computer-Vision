function [line_pararameters, acc] = houghline(curves, magnitude, nrho, ntheta, threshold, no_lines, monotonic_accumulator_increment)
% The function houghline uses the Hough transform to determine linear 
% approximations of a given number of curves, based on parameterizations 
%of the type rho = xcos(theta)+ysin(theta), i.e. polygons.

% INPUT
% nrho: the number of accumulators in the rho direction.
% ntheta: the number of accumulators in the theta direction.
% nrho: is the number of accumulators in the rho direction,
% ntheta: is the number of accumulators in the theta direction.
% threshold: is the lowest value allowed for the given magnitude.
% no_lines: is the number of lines to be extracted.

% OUTPUT
% line_pararameters: corresponding theta and rho values identified as line parameters. 
% acc: The computed accumulator space containing votes. 


%% Define the accumulator space.
% Define a coordinate system in the accumulator space in 
%accordance with: p.756 R. Gonzalez and R. Woods: “Digital Image Processing”, Prentice Hall, 2008.

% Allocate space for the Accumulator Space (ptheta space).
acc = zeros(nrho, ntheta);

%% Define matrices to store rho and theta values for the found lines.

%D is the maximum distance bewteen opposite corners in the image.
D = sqrt( size( magnitude, 1 )^2 + size( magnitude , 2)^2 ); 
rho_space = linspace(-D, D, nrho); 

theta_max = pi/2;
theta_space = linspace( -theta_max, theta_max, ntheta ); 

%% Looping over all the input polygons in the image.

% Number of curves.
no_curves = size( curves, 2 );

% The current polygon index being investigated to find lines.
current_curve  = 1;

% A pointer to a point on the current curve that could potentially be an
% edge part of a line.
potential_edge_line_pointer = 0;

while current_curve  <= no_curves
    
    potential_edge_line_pointer = potential_edge_line_pointer + 1;
    curve_length = curves( 2, current_curve );
    current_curve  = current_curve  + 1;

    % For each point on each curve compute the x and y coordinates in the
    % expression: rho = xcos(theta)+ ysin(theta).
    for curve_segment = 1 : curve_length
        x = curves(2, current_curve );
        y = curves(1, current_curve );
        
        current_curve = current_curve + 1;

        % Threshold the point to make sure that it is strong enough of an
        % maximum point, i.e. a potential edge segment part of a line. 
        % Otherwise move on to the next point on the current curve.
        grad_magnitude = magnitude( round(x), round(y) );
        if (  grad_magnitude > threshold )
            
            % Loop over all accumulators in the theta direction for the current point.
            for theta_index = 1 : ntheta

                % Compute rho for the current theta value using the following 
                % expression: rho = xcos(theta)+ ysin(theta).
                theta = theta_space( theta_index ); 
                rho = x*cos( theta ) + y*sin( theta );

                % Above rho can take on an infinite number of values in a
                % given interval. However, our defined accumulator space
                % for rho and theta is definite. Therefore, we find the
                % index of the closest rho value in the predefined space.
                % This is in accordance with accordance with: p.756 R. Gonzalez and R. Woods: 
                % “Digital Image Processing”, Prentice Hall, 2008.
                [ ~, rho_accumulator_index ] = min( abs( rho_space - rho ) );
                


                % Update the accumulator increment. Either 1 is used as
                % a step size or a monotonicall increasing step size 
                % proportional to a function of the gradient magnitude can
                % be used. The purpose of using a monotonicall increasing
                % function is that stronger line segments get a stronger
                % vote below.
            
                if monotonic_accumulator_increment
                     accumulator_increment = 1;
                else 
                    accumulator_increment = log( grad_magnitude ); 
                end

                % In the current point in the accumulator space add a vote
                % from an edge segment that this point should correspnd to a 
                % line in the x-, y-space.
                acc( rho_accumulator_index, theta_index ) = acc( rho_accumulator_index, theta_index ) + accumulator_increment;
            end
        end
    end
end


%% In order to remove to many inaccurate multiple responses the histogram of the accumulator space is smoothed before local maximas are detected.
% binsepsmoothiter convolves a given image K times by a (separable)
% binomial smoothing filter.

% variance = 0.2;
% K_convolutions = 10;
% acc = binsepsmoothiter( acc, variance , K_convolutions);

%% Extract local maximas, i.e. lines from the accumulator space by counting votes.
[ position, votes ] = locmax8( acc );
[ ~, sorted_indicies_maximas ] = sort(votes);
no_maximas = size(votes, 1);

line_pararameters = zeros(2, no_lines);

% Compute a line for a number of lines given by no_lines of the strongest
%  responses in the accumulator space for a predefined number of lines.

for line_index = 1 : no_lines
    
    rho_idx = position( sorted_indicies_maximas( no_maximas - line_index + 1), 1);
    theta_idx = position( sorted_indicies_maximas( no_maximas - line_index + 1), 2);
    
    rho = rho_space( rho_idx ); 
    theta = theta_space( theta_idx );
    
    % To avoid giving theta a value of zero, it is instead set to a
    % arbitary small number.
    if theta == 0
      theta = 1e-7;
    end
    
   % The parameters of the found line is stored.
   line_pararameters(:, line_index) = [rho; theta];
end
end