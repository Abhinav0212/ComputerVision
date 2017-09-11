% Abhinav Mahalingam
% CSE5524 - HW3
% 9/10/2017

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1
Im = double(imread('input/RandM.jpg'))/255;
grayIm = rgb2gray(Im);
colormap('gray');
level = 4;
[gaussianPyramid,laplacianPyramid] = createLaplacianPyramid(grayIm,level);
imshow(gaussianPyramid);
imwrite(gaussianPyramid, 'results/gaussianPyramid.jpg');
pause;
imshow(laplacianPyramid);
imwrite(laplacianPyramid, 'results/laplacianPyramid.jpg');
pause;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2
Im = double(imread('input/walk.bmp'));
bgIm = double(imread('input/bg000.bmp'));
simple_backgroud_subtraction(Im,bgIm);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 3
bsIm = statistical_backgroud_subtraction(Im);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 4
d_bsIm = bwmorph(bsIm, 'dilate');
imagesc(d_bsIm);
imwrite(d_bsIm, 'results/dilatedIm.jpg');
pause;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 5
[L, num] = bwlabel(d_bsIm, 8);
hist_counts = histcounts(L,1:num);
max_count = max(hist_counts);
largest_comp = bwareaopen(L,max_count,8);
imagesc(largest_comp);
imwrite(largest_comp, 'results/largestComp.jpg');