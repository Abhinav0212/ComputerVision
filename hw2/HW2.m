% Abhinav Mahalingam
% CSE5524 - HW1
% 8/28/2017

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1
sigma_vals=[40.0,30.0,20.0,17.5,15.0,12.5,10.0,7.5,5.0,3.0,2.0];
faceIm=double(imread('stark.jpg'));
for i=1:length(sigma_vals)
    sigma=sigma_vals(i);
    G = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
    gIm = imfilter(faceIm, G, 'replicate');
    imshow(gIm/255);  % double images need range of 0-1
    fname = sprintf('results/starkFilt%d.jpg', i);
    imwrite(uint8(gIm), fname);
    pause;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2
sigma=2;
colormap('gray');
[Gx, Gy] = gaussDeriv2D(sigma);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 3
Im=(imread('CandH.png'));
grayIm = rgb2gray(Im);
gxIm = imfilter(grayIm, Gx, 'replicate');
imagesc(gxIm);
pause;
gyIm = imfilter(grayIm, Gy, 'replicate');
imagesc(gyIm);
pause;
magIm = sqrt(double(gxIm.^2 + gyIm.^2));
imagesc(magIm);
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 4
thres_vals=[16,15,10,7,4,2,1];
for i=1:length(thres_vals)
    T=thres_vals(i);
    tIm = magIm > T;
    imagesc(tIm);
    fname = sprintf('results/threshold%d.jpg', T);
    imwrite(tIm, fname);
    pause;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 5
Fx = -fspecial('sobel')';
fxIm = imfilter(grayIm,Fx);
Fy = -fspecial('sobel');
fyIm = imfilter(grayIm,Fy);
magIm = sqrt(double(fxIm.^2 + fyIm.^2));
for i=1:length(thres_vals)
    T=thres_vals(i);
    tIm = magIm > T;
    imagesc(tIm);
    fname = sprintf('results/sobelThreshold%d.jpg', T);
    imwrite(tIm, fname);
    pause;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 6
cannyImg = edge(grayIm,'canny');
imagesc(cannyImg);
imwrite(cannyImg, 'results/canny.jpg');