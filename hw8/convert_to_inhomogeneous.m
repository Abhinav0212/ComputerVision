function[inhomogeneous_coords] = convert_to_inhomogeneous(homogeneous_coords)
inhomogeneous_coords(1,:) = homogeneous_coords(1, :) ./ homogeneous_coords(3,:);
inhomogeneous_coords(2,:) = homogeneous_coords(2, :) ./ homogeneous_coords(3,:);
inhomogeneous_coords = inhomogeneous_coords';
end