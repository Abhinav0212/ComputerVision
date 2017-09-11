function [] = simple_backgroud_subtraction(Im,bgIm)
    diff = abs(Im-bgIm);
    for T = 60:10:100
        result = diff>T;
        imagesc(result);
        fname = sprintf('results/simp_bg_sub%d.jpg', T);
        imwrite(result, fname);
        pause;
    end
end
    