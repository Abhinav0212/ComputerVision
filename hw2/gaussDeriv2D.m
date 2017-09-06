function [Gx, Gy] = gaussDeriv2D(sigma)
    maskSize = 2*ceil(3*sigma)+1;
    Gx = zeros(maskSize,maskSize);
    xo = 1 + ceil(3*sigma);yo = xo;
    const1 = (2*pi*sigma^4);
    const2 = (2*sigma^2);
    for x=1:maskSize;
        for y=1:maskSize;
            Gx(y,x) = -((x - xo)/const1)*exp(-((x-xo)^2 + (y-yo)^2)/const2);
        end
    end
    Gy = Gx';
    surf(Gx);
    pause;
    imagesc(Gx);
    pause;
    surf(Gy);
    pause;
    imagesc(Gy);
    pause;
end