% Abhinav Mahalingam
% CSE5524 - HW5
% 9/23/2017

% HW5.m
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1
colormap('gray');
img_width = 240;
img_height = 320;
num_images = 22;
Im = zeros(img_height,img_width,num_images);
Im_diff = zeros(img_height,img_width,num_images-1);
Thresh_Im_diff = zeros(img_height,img_width,num_images-1);
for i = 1:num_images
    Im(:,:,i)=medfilt2(double(imread(sprintf('input/aerobic-%03d.bmp',i))));
    if i > 1
        Im_diff(:,:,i-1) = abs(Im(:,:,i)- Im(:,:,i-1));
    end
end
for t = 1:2:15
    for i = 1:(num_images-1)
        imagesc(imdilate(bwareaopen(Im_diff(:,:,i)>t,5),strel('disk',1)));
        title(sprintf('Threshold: %d, Difference between Im %d and %d',t,i,i+1));
        if i==16
            saveFrame(sprintf('results/t%d.jpg',t));
        end
        pause(0.01);
    end
end
% t=11 gives the best threshold for the aerobic sequence
t = 11;
for i = 1:(num_images-1)
        Thresh_Im_diff(:,:,i) = imdilate(bwareaopen(Im_diff(:,:,i)>t,5),strel('disk',1));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2
motion_history = zeros(img_height,img_width,num_images-1);
duration = num_images;
for i =1:duration-1
    cur_frame_history = Thresh_Im_diff(:,:,i).*(duration);
    if i>1
        for r = 1:size(cur_frame_history,1)
            for c = 1:size(cur_frame_history,2)
                if cur_frame_history(r,c)==0
                    cur_frame_history(r,c) = max(0,motion_history(r,c,i-1)-1);
                end
            end
        end
    end
    motion_history(:,:,i) = cur_frame_history;
end
MHI = motion_history(:,:,duration-1)./duration;
MEI = MHI > 0;
imagesc(MEI);
title('MEI');
saveFrame('results/MEI.jpg');
pause;
imagesc(MHI);
title('MHI');
saveFrame('results/MHI.jpg');
pause;
mei_sim_moments = similitudeMoments(MEI);
disp(mei_sim_moments);
mhi_sim_moments = similitudeMoments(MHI);
disp(mhi_sim_moments);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 3
colormap('gray');
base_image = zeros(101,101);
base_image(40:60,6:26) = ones(21,21);
shifted_image = zeros(101,101);
shifted_image(41:61,7:27) = ones(21,21);
fx_filter = [-1 0 1; -2 0 2; -1 0 1]./8;
fy_filter = [-1 -2 -1; 0 0 0; 1 2 1]./8;
fx = imfilter(shifted_image,fx_filter,'replicate');
fy = imfilter(shifted_image,fy_filter,'replicate');
ft = shifted_image - base_image;
imagesc(fx);
title('After fx filter');
pause;
imagesc(fy);
title('After fy filter');
pause;
imagesc(ft);
title('After ft filter');
pause;

normal_flow_vectors = zeros(2,168);
normal_flow_start_points = zeros(2,168);
num_of_vectors=0;
for x=1:size(fx,2)
    for y=1:size(fx,1)
        if fx(y,x)==0 && fy(y,x)==0
            continue
        end
        num_of_vectors =num_of_vectors + 1;
        c = sqrt(fx(y,x)^2 + fy(y,x)^2);
        magnitude = -ft(y,x)./c;
        normal_flow_vectors(1,num_of_vectors) = magnitude * fx(y,x)./c;
        normal_flow_vectors(2,num_of_vectors) = magnitude * fy(y,x)./c;
        normal_flow_start_points(1,num_of_vectors) = x;
        normal_flow_start_points(2,num_of_vectors) = y;
    end
end
imagesc(base_image);
hold on;
quiver(normal_flow_start_points(1,:),normal_flow_start_points(2,:),normal_flow_vectors(1,:),normal_flow_vectors(2,:));
title('Normal flow vectors');
hold off;
