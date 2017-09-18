function [centroidX,centroidY] = getCentroid(Img)
    m00 = computeMoments(Img,0,0,0,0);
    m10 = computeMoments(Img,0,0,1,0);
    m01 = computeMoments(Img,0,0,0,1);
    centroidX=m10/m00;
    centroidY=m01/m00;
end