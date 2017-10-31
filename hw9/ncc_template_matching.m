function [result] = ncc_template_matching(Im, template)
    [temp_height, temp_width, ~] = size(template);
    [Im_height, Im_width, ~] = size(Im);
    temp_width_half_span = floor(temp_width/2);
    temp_height_half_span = floor(temp_height/2);
    temp_center_x = ceil(temp_width/2);
    temp_center_y = ceil(temp_height/2);
    ncc_values = zeros(Im_height, Im_width);
    
    for x=temp_center_x:(Im_width-temp_width_half_span)
        for y=temp_center_y:(Im_height-temp_height_half_span)
            window = Im(y-temp_height_half_span:y+temp_height_half_span, x-temp_width_half_span:x+temp_width_half_span, :);
            for j=1:size(template, 3)
                template_color = template(:, :, j);
                template_avg = mean(template_color(:));
                window_color = window(:, :, j);
                window_avg = mean(window_color(:));
                ncc_values(y,x) = ncc_values(y,x) + sum(sum((window_color - window_avg).*(template_color - template_avg)/(std(window_color(:))*std(template_color(:)))))/(temp_height*temp_width - 1);
            end
        end
    end
    ncc_wo_edges = ncc_values(temp_center_y:(Im_height-temp_height_half_span), temp_center_x:(Im_width-temp_width_half_span));
    [sorted_values, sorted_index] = sort(ncc_wo_edges(:), 'descend');
    [y, x] = ind2sub(size(ncc_wo_edges), sorted_index);
    result = [x y sorted_values];
end