function new_dim = calculateNewDimesnsion(dim,level)
    const = 2^(level-1);
    new_dim = zeros(size(dim));
    for i = 1:2
        if mod(dim(i),const)==0
            new_dim(i)=dim(i)-const+1;
        else
            new_dim(i)=(floor(dim(i)/const)*const)+1;
        end
    end
end