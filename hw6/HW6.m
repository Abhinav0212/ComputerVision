% Abhinav Mahalingam
% CSE5524 - HW6
% 10/1/2017

% HW6.m
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Problem 1
Im = double(imread('input/target.jpg'));
image_size = size(Im);
covariance_model = [47.917 0 -146.636 -141.572 -123.269; 0 408.250 68.487 69.828 53.479; -146.636 68.487 2654.285 2621.672 2440.381; -141.572 69.828 2621.672 2597.818 2435.368; -123.269 53.479 2440.381 2435.368 2404.923];
window_size = [70 24];
final_row = image_size(1) - window_size(1) + 1;
final_col = image_size(2) - window_size(2) + 1;
cov_diff_mat = zeros(final_row,final_col);
for x=1:final_col
    for y=1:final_row
        feature_matrix = generate_feature_matrix(Im,x,y,window_size(2),window_size(1));
        covariance_candidate=cov(feature_matrix,1);
        cov_diff_mat(y,x) = manifold_distance(covariance_model,covariance_candidate);
    end
end
[min_num,min_idx] = min(cov_diff_mat(:));
[min_row,min_col] = ind2sub(size(cov_diff_mat),min_idx);
imagesc(cov_diff_mat);
pause;
imagesc(Im/255);
hold on;
rectangle('Position',[min_col min_row window_size(2) window_size(1)],'EdgeColor','Red','LineWidth',2);
text(min_col-5,min_row-5,sprintf('Origin:(%g,%g)',min_col,min_row),'Color','Yellow');
hold off;
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2
clc;close all;
img = double(imread('input/target.jpg'));
center_x = 300;
center_y = 30;
radius = 15;
feature_matrix = circularNeighbors(img, center_x, center_y, radius);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 3
clc;close all;
h=20;
bins = 16;
hist_cube = colorHistogram(feature_matrix, bins, center_x, center_y, h);

q_model = hist_cube;
p_test = hist_cube;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 4
weights = meanShiftWeights(feature_matrix, q_model, p_test);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 5
clc; clear; close all;
img1 = double(imread('input/img1.jpg'));
img2 = double(imread('input/img2.jpg'));
radius = 25;
h = 25;
center_x = 150.0;
center_y = 175.0;
bins = 16;
number_of_iterations = 25;
original_feature_matrix = circularNeighbors(img1, center_x, center_y, radius);
q_model = colorHistogram(original_feature_matrix,bins,center_x, center_y, h);
imagesc(img1/255);
hold on;
viscircles([center_x center_y],radius);
plot(center_x, center_y, 'y+', 'MarkerSize', 5);
hold off;
x = center_x;
y = center_y;
coordinates = [x y];
for n=1:number_of_iterations
    feature_matrix = circularNeighbors(img2, x, y, radius);
    p_test = colorHistogram(feature_matrix,bins,x,y,h);
    weights = meanShiftWeights(feature_matrix, q_model, p_test);
    sum_of_weights = sum(weights);
    new_coordinate = sum([feature_matrix(:,1).*weights',feature_matrix(:,2).*weights'],1)./sum_of_weights;
    x = new_coordinate(1);
    y = new_coordinate(2);
    coordinates = [coordinates; x y];
    fprintf('New coordinate: (%g, %g)\n',x,y);
end
for n=1:size(coordinates,1)
    imagesc(img2/255);
    hold on;
    viscircles([coordinates(n,1) coordinates(n,2)], radius);
    plot(coordinates(n,1),coordinates(n,2),'yellow+','MarkerSize',5);
    if n>1
        dis = sqrt((coordinates(n,1) - coordinates(n-1,1)).^2 + (coordinates(n,2) - coordinates(n-1,2)).^2);
        title(sprintf('Iteration: %d, Distance between last 2 points: %0.5g \n Point:(%g,%g)',n,dis,coordinates(n,1),coordinates(n,2)));
    end
    hold off;
    pause();
end