function[featurePoints] = fast_detector(Im, threshold, nStar)
circle = [0 -3; 1 -3; 2 -2; 3 -1; 3 0; 3 1; 2 2; 1 3; 0 3; -1 3; -2 2; -3 1; -3 0; -3 -1; -2 -2; -1 -3];
featurePoints = [];
[height, width] = size(Im);
radius = 3;
for x = radius+1:width-radius-1
    for y = radius+1:height-radius-1
        intensity_circle = zeros(1, size(circle, 1));
        current_pixel_value = Im(y,x);
        for n=1:size(circle,1)
            intensity_circle(1,n) = Im(y+circle(n,2),x+circle(n,1));
        end
        aboveT = intensity_circle > current_pixel_value + threshold;
        longestSeqAboveT = longest_non_zero_seq(aboveT);
        belowT = intensity_circle < current_pixel_value - threshold;
        longestSeqBelowT = longest_non_zero_seq(belowT);
        if longestSeqAboveT >=nStar || longestSeqBelowT >= nStar
            featurePoints = cat(1,featurePoints, [x y]);
        end
    end
end     
end