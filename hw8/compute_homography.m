function [homography] = compute_homography (Im_1, Im_2) 
    [transformed_coords_1, T_1] = similarity_transform(Im_1);
    [transformed_coords_2, T_2] = similarity_transform(Im_2);
    H_1 = compute_camera_matrix(transformed_coords_1(1:2, :)', transformed_coords_2(1:2, :)');
    homography = (T_2\H_1) * T_1;
end