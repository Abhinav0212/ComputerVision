function [transformed_coords, T] = similarity_transform(coords)
    mean_x = mean(coords(:, 1));
    mean_y = mean(coords(:, 2));
    s = sqrt(2) / mean(sqrt(((coords(:, 1) - mean_x).^2 + (coords(:, 2) - mean_y).^2)));
    T = [s 0 -s*mean_x; 0 s -s*mean_y; 0 0 1];
    transformed_coords = T * [coords'; ones(1, size(coords, 1))];
end