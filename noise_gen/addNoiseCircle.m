function [noiIm, noise] = addNoiseCircle(im)
    noiIm = double(im);
    noise = zeros(size(im));
    [w, h] = size(im);

    for i = 1:w
        for j = 1:h
            if ((i-w/2)^2 + (j-h/2)^2 > (min(w, h)/8)^2 && (i-w/2)^2 + (j-h/2)^2 < (min(w, h)/3)^2)
                noise(i, j) = 25*randn(1, 1);
                noiIm(i, j) = noiIm(i, j)+noise(i, j);
            end
        end
    end
