function[out] = non_maximal_suppression(Im)
[height,width] = size(Im);
out = zeros(height,width);
for x = 2:width-1
    for y=2:height-1
        max_in_nighborhood = max(max(Im(y-1:y+1,x-1:x+1)));
         if Im(y,x)==max_in_nighborhood
             out(y,x) = max_in_nighborhood;
         end
    end
end 
end