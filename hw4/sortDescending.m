function [sorted_eigen_vec,sorted_eigen_val] = sortDescending(eigen_vec,eigen_val)
    [temp,ind_mat]=sort(diag(eigen_val),'descend');
    sorted_eigen_val=diag(temp);
    sorted_eigen_vec=eigen_vec(:,ind_mat);
end