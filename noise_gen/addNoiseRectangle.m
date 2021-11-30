function [noiIm, noise] = addNoiseRectangle(im, sz1, sz2, w, h, var)
    noiIm = double(im);
    noise = var*randn(floor(w/2+sz1)-floor(w/2-sz1)+1, floor(h/2+sz2)-floor(h/2-sz2)+1);
    noiIm(floor(w/2-sz1):floor(w/2+sz1), floor(h/2-sz2):floor(h/2+sz2)) = noiIm(floor(w/2-sz1):floor(w/2+sz1), floor(h/2-sz2):floor(h/2+sz2))+noise; 
    

