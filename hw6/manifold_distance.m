function[distance] = manifold_distance(cov_a,cov_b)
    [~,eig_val]=eig(cov_a,cov_b);
    eig_val = eig_val(eig_val~=0);
    distance = sqrt(sum(log(eig_val).^2));
end