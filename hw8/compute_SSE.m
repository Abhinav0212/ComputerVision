function [SSE] = compute_SSE(coords_1, coords_2) 
SSE = sum(sum((coords_1 - coords_2).^2, 2));
end