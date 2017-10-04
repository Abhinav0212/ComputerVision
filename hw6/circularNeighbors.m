function[feature_matrix] = circularNeighbors(Im, center_x, center_y, radius)
cols = (2*radius)+1;
rows = (2*radius)+1;

relative_center_x = radius + 1 + (center_x-floor(center_x));
relative_center_y = radius + 1 + (center_y-floor(center_y));

[X, Y] = meshgrid(1:cols,1:rows);
circle_points = ((X - relative_center_x).^2 + (Y - relative_center_y).^2) < radius^2;

box_feature_matrix = generate_feature_matrix(Im, center_x-(radius+1), center_y-(radius+1), cols, rows);
transposed_circle_points = circle_points';
vectorized_circle_points = repmat(transposed_circle_points(:), 1, 5);

box_feature_matrix=box_feature_matrix.*vectorized_circle_points;
bounding_box_coords = box_feature_matrix(:,1:2);
feature_matrix = box_feature_matrix(all(bounding_box_coords, 2), :);
feature_matrix(:, 1) = feature_matrix(:, 1) + center_x - relative_center_x;
feature_matrix(:, 2) = feature_matrix(:, 2) + center_y - relative_center_y;
end
