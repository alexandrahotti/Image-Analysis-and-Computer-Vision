function display_linepairs (line_pairs)
% Displays corresponding line pairs.

for line_index = 1:size(line_pairs,2)
    
    rho = line_pairs(1, line_index);
    theta = line_pairs(2, line_index);
    
    disp(['The parameters of extracted line ' num2str(line_index) ', rho: ' num2str(rho) ', theta: ' num2str(radtodeg(theta)), char(176)]);
    
end
end

