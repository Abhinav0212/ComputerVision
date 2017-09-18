% Abhinav Mahalingam
% CSE5524 - HW4
% 9/16/2017

% HW4.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1
Im = double(imread('input/boxIm1.bmp'))/255;
colormap('gray');
imagesc(Im);
st = regionprops('table',Im,'Area','Centroid','BoundingBox');
objectRegions = find(st.Area > 0);
hold on;
% Get the area, boundary and centroid for all regions in the image
for i=1:size(objectRegions)
    objReg = st(objectRegions(i),:);
    plot(objReg.Centroid(1),objReg.Centroid(2),'r.');
    rectangle('Position',[objReg.BoundingBox(1),objReg.BoundingBox(2),objReg.BoundingBox(3),objReg.BoundingBox(4)],'EdgeColor','r','LineWidth',2 );
    text(objReg.BoundingBox(1)+1,objReg.BoundingBox(2)+5,sprintf('Area: %g',objReg.Area));
    text(objReg.Centroid(1)+1,objReg.Centroid(2)+5,sprintf('Centroid: (%g,%g)',objReg.Centroid(1),objReg.Centroid(2)));
end
saveFrame('results/regionProperties.png');
hold off;
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2
clear; close all;
colormap('gray');
for i=1:4
    Im = double(imread(sprintf('input/boxIm%d.bmp',i)))/255;
    simMoments = similitudeMoments(Im);
    imagesc(Im);
    title(sprintf('boxIm%d.bmp',i));
    text(10,10,sprintf('Similitude moments: %s',mat2str(simMoments,2)),'Color','Yellow');
    saveFrame(sprintf('results/SimilBoxIm%d.png',i));
    fprintf('boxIm%d.bmp',i);
    disp(simMoments);
    pause;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 3
% Load the data
clear; close all;
load eigdata.txt;
X = eigdata; 
subplot(2,1,1); 
plot(X(:,1),X(:,2),'b.'); 
axis('equal');

% mean-subtract data
m = mean(X);
Y = X - ones(size(X,1),1)*m; 
subplot(2,1,2); 
plot(Y(:,1),Y(:,2),'r.'); 
axis('equal');
saveFrame('results/dataPlot.png');
pause;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 4
close all;
covariance = cov(Y);
[eigen_vec,eigen_val] = eig(covariance);
[eigen_vec,eigen_val] = sortDescending(eigen_vec,eigen_val);
C=9;
maj_axis_len = sqrt(C*eigen_val(1,1));
scaled_maj_axis = eigen_vec(:,1)* maj_axis_len;
min_axis_len = sqrt(C*eigen_val(2,2));
scaled_min_axis = eigen_vec(:,2)* min_axis_len;
plot(Y(:,1),Y(:,2),'r.');
hold on;
plot(scaled_maj_axis(1,1),scaled_maj_axis(2,1),'b+','MarkerSize',20);
plot(scaled_min_axis(1,1),scaled_min_axis(2,1),'b+','MarkerSize',20);
line([ 0;scaled_maj_axis(1,1)],[ 0;scaled_maj_axis(2,1)],'LineWidth',5);
line([ 0;scaled_min_axis(1,1)],[ 0;scaled_min_axis(2,1)],'LineWidth',5);
saveFrame('results/ellipseAxis.png');
hold off;
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 5
rotate_val = (eigen_vec*Y')';
plot(rotate_val(:,1),rotate_val(:,2),'r.');
axis('equal');
saveFrame('results/rotatedellipseAxis.png');