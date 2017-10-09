% Abhinav Mahalingam
% CSE5524 - HW7
% 10/7/2017

% HW7.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1
Im = double(imread('input/checker.png'));
sigD = 0.7;
sigI = 1;
alpha = 0.05;
[cornerPoints, R] = harris_detector(Im, sigD, sigI, alpha);
imagesc(R);
title(sprintf('Harris detector - Thresholded R before non max suppression\nNumber of interest points: %d',size(R(R>0),1)));
colormap('gray');
pause;

imagesc(Im);
hold on;
plot(cornerPoints(:,1),cornerPoints(:,2),'rx','MarkerSize',3);
hold off;
title(sprintf('Harris detector - Actual corner points after non max suppression\nNumber of interest points: %d',size(cornerPoints,1)));
pause;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2
Im = double(imread('input/tower.png'));
thresholds = [10 20 30 50];
nStar = 12;
for threshold = thresholds
    featurePoints = fast_detector(Im, threshold, nStar);
    imagesc(Im);
    colormap('gray');
    hold on;
    plot(featurePoints(:,1),featurePoints(:,2),'rx');
    hold off;
    title(sprintf('FAST feature point detector - T: %d n*: %d\n Number of feature points: %d',threshold,nStar,size(featurePoints,1)));
    pause;
end

