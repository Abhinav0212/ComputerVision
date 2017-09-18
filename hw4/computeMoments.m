function [m] = computeMoments(Img,x,y,p,q)
   m=0;
   for r = 1:size(Img,1)
      for c = 1:size(Img,2)
          m = m + (Img(r,c)*((c-x)^p)*((r-y)^q));
      end
   end 
end