function [disp_map] = get_disparity_map(left_image, right_image, window_width, window_height)
    [height, width] = size(left_image);
    win_half_width = floor(window_width/2);
    win_half_height = floor(window_height/2);
    disp_map = zeros(height, width);
    for x=ceil(window_width/2):(width - win_half_width)
        for y=ceil(window_height/2):(height - win_half_height)
            template = left_image(y-win_half_height:y+win_half_height, x-win_half_width:x+win_half_width);
            search_Im = right_image(y-win_half_height:y+win_half_height, max(1,x-win_half_width-50):x+win_half_width);
            [ncc_result] = ncc_template_matching(search_Im, template);
            match_x = ncc_result(1, 1) + max(win_half_width,x-51);
            disp_map(y,x) = (x-match_x);
        end
    end
end