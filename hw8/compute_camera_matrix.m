function [camera_matrix] = compute_camera_matrix(world_coords, camera_coords)
num_points = size(world_coords, 1);
homo_coord_dim = size(world_coords, 2)+1;
A = zeros( 2*num_points, homo_coord_dim*3);
for n=1:2:2*num_points
    world_coord = world_coords(ceil(n/2),:);
    camera_coord = camera_coords(ceil(n/2),:);
    A(n,:) = [world_coord 1 zeros(1,homo_coord_dim) world_coord.*-camera_coord(1,1) -camera_coord(1,1)];
    A(n+1,:) = [zeros(1,homo_coord_dim) world_coord 1 world_coord.*-camera_coord(1,2) -camera_coord(1,2)];
end
[eig_vectors, eig_values] = eig(A' * A);
rasterized_camera_matrix = eig_vectors(:,diag(eig_values) == min(diag(eig_values)));
% camera matrix is already normalized by the eig call
camera_matrix = reshape(rasterized_camera_matrix,homo_coord_dim, 3);
camera_matrix = camera_matrix';
end