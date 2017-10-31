% Abhinav Mahalingam
% CSE5524 - HW 9
% 10/28/2017

% HW9.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1

matches = [1 2 5 10 100 500];
Im = double(imread('input/search.png'));
template = double(imread('input/template.png'));
[temp_height, temp_width, ~] = size(template);
[ncc_result] = ncc_template_matching(Im, template);
for n=matches
    match = ncc_result(n, :);
    x =  match(1, 1);
    y =  match(1, 2);
    patch = Im(y:y+temp_height-1, x:x+temp_width-1, :);
    figure;
    imagesc(patch/255); 
    title(sprintf('%d closest match, NCC score: %g', n, match(1, 3)));
    saveFrame(sprintf('results/ncc_%d_closest.png', n));
end
figure;
plot(ncc_result(:, 3));
xlabel('k');
ylabel('NCC');
title('NCC score for kth closest match');
saveFrame('results/ncc_plot.png');
pause;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2
clear; close all; clc;
left_image = double(imread('input/left.png'));
right_image = double(imread('input/right.png'));
disparity_map = get_disparity_map(left_image, right_image, 11, 11);
figure;
imagesc(disparity_map, [0 50]); 
axis equal;
colormap gray; 
title('Disparity map'); 
saveFrame('results/disparity_map.png');
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 3
clear; clc; close all;
training_data = load ('input/train.txt');
test_data = load ('input/test.txt');
train_coords = training_data(:, 1:2);
test_coords = test_data(:, 1:2);
test_label = test_data(:, 3);
k_values = [1, 5, 11, 15];
for k=k_values
    [idx, D] = knnsearch(train_coords, test_coords, 'K', k);
    k_labels = zeros(size(test_coords, 1), k);
    for i=1:k
        k_labels(:, i) = training_data(idx(:,i), 3);
    end
    if k ~= 1
        classified_labels = mode(k_labels,2);
    else 
        classified_labels = k_labels;
    end
    misclassification = test_data(test_label ~= classified_labels, 1:2);
    accuracy = (size(test_data,1) - size(misclassification,1))/ size(test_data,1);
    class_1_matches = test_data(classified_labels == 1, 1:2);
    class_2_matches = test_data(classified_labels == 2, 1:2);
    figure;
    hold on;
    title({sprintf('k-Nearest Neighbors classification k=%d', k), sprintf('Accuracy: %d', accuracy)});
    plot(class_1_matches(:, 1), class_1_matches(:, 2), 'r.');
    plot(class_2_matches(:, 1), class_2_matches(:, 2), 'b.');
    plot(misclassification(:, 1), misclassification(:, 2), 'ko');
    hold off;
    saveFrame(sprintf('results/k_%d_plot.png',k));
    disp(accuracy);
end
pause;
close all