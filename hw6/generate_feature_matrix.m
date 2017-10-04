function[feature_matrix] = generate_feature_matrix(img,origin_x,origin_y,cols,rows)
    window = img(floor(origin_y):(floor(origin_y)+rows-1),floor(origin_x):(floor(origin_x)+cols-1),:);
    feature_matrix(:,1)=repmat(1:cols,1,rows);
    row_val=repmat(1:rows,cols,1);
    feature_matrix(:,2) = row_val(:);
    feature_matrix(:,3)=reshape(window(:,:,1)',[],1);
    feature_matrix(:,4)=reshape(window(:,:,2)',[],1);
    feature_matrix(:,5)=reshape(window(:,:,3)',[],1);
end