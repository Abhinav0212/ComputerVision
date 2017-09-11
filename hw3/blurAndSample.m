function reducedIm = blurAndSample(grayIm)
    Gm = createGaussianMask(0.4);
    gxIm = imfilter(grayIm, Gm, 'replicate');
    blurredIm = imfilter(gxIm', Gm, 'replicate')';
    dimen = size(blurredIm);
    reducedIm = blurredIm(1:2:dimen(1),1:2:dimen(2));
end