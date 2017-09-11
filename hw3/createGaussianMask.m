function Gm = createGaussianMask(a)
    Gm = [0.25-(0.5*a),0.25,a,0.25,0.25-(0.5*a)];
end