function[hist] = colorHistogram(feature_matrix, bins, center_x, center_y, h)
min_x = min(feature_matrix(:,1));
min_y = min(feature_matrix(:,2));
max_x = max(feature_matrix(:,1));
max_y = max(feature_matrix(:,2));

% Epanechnikov kernel
[X, Y] = meshgrid(min_x:max_x,min_y:max_y);
kernel = 1 - (sqrt((X-center_x).^2 + (Y-center_y).^2)./h).^2;
kernel(kernel < 0) = 0;
kernel_vectors = [];

for col = 1:size(X,2)
    kernel_vectors = [kernel_vectors; X(:, col) Y(:,col) kernel(:,col)];
end
sorted_feature_matrix = sortrows(feature_matrix, [1 2]);

filtered_kernel = kernel_vectors(ismember(kernel_vectors(:, 1:2),sorted_feature_matrix(:,1:2),'rows'),:);
filtered_feature_matrix = sorted_feature_matrix(ismember(sorted_feature_matrix(:,1:2), filtered_kernel(:,1:2), 'rows'),:);

weighted_hist_vector(:, 1) = floor(filtered_feature_matrix(:,3)*bins/256) + 1;
weighted_hist_vector(:, 2) = floor(filtered_feature_matrix(:,4)*bins/256) + 1;
weighted_hist_vector(:, 3) = floor(filtered_feature_matrix(:,5)*bins/256) + 1;
weighted_hist_vector(:, 4) = filtered_kernel(:,3);

all_cube_indices(:,1) = repmat((1:bins)', bins*bins, 1);
all_cube_indices(:,2) = repmat(for_each(1:bins,bins)', bins, 1);
all_cube_indices(:,3) = for_each(1:bins,bins*bins)';
all_cube_indices(:,4) = zeros(bins*bins*bins, 1);

weighted_hist_vector = sortrows(weighted_hist_vector,[3 2 1]);
[unique_hist_rows,~,groupings] = unique(weighted_hist_vector(:, 1:3),'rows', 'stable');
summed_hist_vector = [unique_hist_rows, accumarray(groupings, weighted_hist_vector(:,4))];
cubes_indices_present = ismember(all_cube_indices(:,1:3), summed_hist_vector(:,1:3),'rows');
all_cube_indices(cubes_indices_present,4) = summed_hist_vector(:,4);
hist_cube = reshape(all_cube_indices(:,4),bins,bins,bins);

hist = hist_cube./sum(sum(sum(hist_cube,3),2),1);
end