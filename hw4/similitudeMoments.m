function[N] = similitudeMoments(Img)
    [centroidX,centroidY] = getCentroid(Img);
    m00 = computeMoments(Img,0,0,0,0);
    moments = [0 2; 0 3; 1 1; 1 2; 2 0; 2 1; 3 0];
    N = zeros(1,size(moments,1));
    for r=1:size(moments,1)
        p = moments(r,1);
        q = moments(r,2);
        momentVal = computeMoments(Img,centroidX,centroidY,p,q);
        N(1,r) = momentVal/(m00^(((p+q)/2)+1));
    end
end