function outcurves = linear_parametrization_hough_lines(line_pairs, D)

for i = 1 : size(line_pairs, 2)

x0 = line_pairs(1,i) * cos( line_pairs(2,i) );
y0 = line_pairs(1,i) * sin( line_pairs(2,i) );

dx = D^2 * ( -sin( line_pairs(2,i) ) );
dy = D^2 * ( cos( line_pairs(2,i) ) );  


outcurves(1, 4*(i-1) + 1) = 0; % level, not significant
outcurves(2, 4*(i-1) + 1) = 3; % number of points in the curve

outcurves(2, 4*(i-1) + 2) = x0 - dx;
outcurves(1, 4*(i-1) + 2) = y0 - dy;

outcurves(2, 4*(i-1) + 3) = x0;
outcurves(1, 4*(i-1) + 3) = y0;

outcurves(2, 4*(i-1) + 4) = x0 + dx;
outcurves(1, 4*(i-1) + 4) = y0 + dy; 
end

end