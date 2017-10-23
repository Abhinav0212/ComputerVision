% Abhinav Mahalingam
% CSE5524 - HW7
% 10/22/2017

% HW8.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1 & 2
world_coords = load('input/3Dpoints.txt');
camera_coords = load('input/2Dpoints.txt');
camera_matrix = compute_camera_matrix(world_coords, camera_coords);
homo_world_space_coords = [world_coords';ones(1,size(world_coords,1))];
homo_projected_camera_coords = camera_matrix * homo_world_space_coords;
projected_camera_coords = convert_to_inhomogeneous(homo_projected_camera_coords);
SSE = compute_SSE(camera_coords, projected_camera_coords);
plot(camera_coords,'r+');
hold on;
plot(projected_camera_coords,'bo');
title(sprintf('SSE: %g', SSE));
hold off;
disp(SSE);
disp(camera_matrix);
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 3, 4 & 5
input_data = load('input/homography.txt');
num_of_points = size(input_data, 1);
Im_1 = [input_data(:, 1) input_data(:, 2)];
Im_2 = [input_data(:, 3) input_data(:, 4)];
H = compute_homography(Im_1, Im_2);
homo_projected_points = H * [Im_1'; ones(1, num_of_points)];
projected_points = convert_to_inhomogeneous(homo_projected_points);
SSE = compute_SSE(Im_2, projected_points);
plot(Im_2, 'r+');
hold on;
plot(projected_points, 'bo');
title(sprintf('SSE: %g', SSE));
hold off;
disp(SSE);
disp(H);

