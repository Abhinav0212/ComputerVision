function[cornerPoints,R]=harris_detector(Im, sigD,sigI, alpha)
[Gx,Gy] = gaussDeriv2D(sigD);
Ix = imfilter(Im,Gx,'replicate');
Iy = imfilter(Im,Gy,'replicate');
g_filter = fspecial('gaussian',2*ceil(3*sigI)+1,sigI);
g_Ix2 = imfilter(Ix.^2, g_filter,'replicate');
g_Iy2 = imfilter(Iy.^2, g_filter,'replicate');
g_IxIy = imfilter(Ix.*Iy, g_filter,'replicate');
R = (g_Ix2.*g_Iy2) - (g_IxIy.^2) - alpha.*((g_Ix2+g_Iy2).^2);
R(R<1e6) = 0;
newIm = non_maximal_suppression(R);
[y,x] = find(newIm > 0);
cornerPoints = [x y];
end