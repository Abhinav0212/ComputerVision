% Consider original image as level 1
function [gaussianPyramid,laplacianPyramid] = createLaplacianPyramid(grayIm,level)
    new_dim = calculateNewDimesnsion(size(grayIm),level);
    actualIm = grayIm(1:new_dim(1),1:new_dim(2));
    gaussianPyramid = zeros(ceil(1.5*new_dim(1)),new_dim(2));
    laplacianPyramid = zeros(ceil(1.5*new_dim(1)),new_dim(2));
    
    gaussianPyramid(1:new_dim(1),1:new_dim(2)) = actualIm;
    g_row_offset = new_dim(1);
    g_col_offset = 0;
    l_row_offset = new_dim(1);
    l_col_offset = 0;
    for i = 2:level
        act_dim = size(actualIm);
        reducedIm = blurAndSample(actualIm);
        approxIm = imresize(reducedIm,act_dim,'bilinear');
        errorIm = actualIm-approxIm;
        
        red_dim = size(reducedIm);
        gaussianPyramid(g_row_offset+1:g_row_offset+red_dim(1),g_col_offset+1:g_col_offset+red_dim(2)) = reducedIm;
        g_col_offset = g_col_offset + red_dim(2);
        
        if i==2
            laplacianPyramid(1:act_dim(1),1:act_dim(2)) = errorIm;
        else
            laplacianPyramid(l_row_offset+1:l_row_offset+act_dim(1),l_col_offset+1:l_col_offset+act_dim(2)) = errorIm;
            l_col_offset=l_col_offset+act_dim(2);
        end
        
        actualIm = reducedIm;
    end
    laplacianPyramid(l_row_offset+1:l_row_offset+red_dim(1),l_col_offset+1:l_col_offset+red_dim(2)) = gaussianPyramid(l_row_offset+1:l_row_offset+red_dim(1),l_col_offset+1:l_col_offset+red_dim(2));
end