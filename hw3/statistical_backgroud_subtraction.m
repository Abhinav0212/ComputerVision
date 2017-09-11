function [bestBg] = statistical_backgroud_subtraction(Im)
    bgIm = zeros(240,320,30);
    for n=1:29
        bgIm(:,:,n) = double(imread(sprintf('input/bg%03d.bmp',n)));
    end
    avg_bg = mean(bgIm,3);
    std_bg = std(bgIm,1,3);
    diff = ((Im-avg_bg)./std_bg).^2;
    for T = 2:0.3:4
        result = diff>T^2;
        imagesc(result);
        fname = sprintf('results/stat_bg_sub%03f.jpg', T);
        imwrite(result, fname);
        pause;
    end
    bestBg = diff>2.6^2;
end