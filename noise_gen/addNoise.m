function addNoise(name, func)

    [testIm, imagemap] = imread(name);

    testIm = double(rgb2ycbcr(testIm));
    
    im=testIm(:,:,1);

    if (func == 1)
        [noiIm, noise] = addNoiseStripes(im);
    elseif(func == 2)
        [noiIm, noise] = addNoiseSquares(im);
    elseif(func == 3)
        [noiIm, noise] = addNoiseCircle(im);

    elseif(func == 4)
        [w, h] = size(im)
        [noiIm, noise] = addNoiseRectangle(im, 4*w/20, 4*h/20, w, h, 100);
    end
    
    
    %noiIm = max(0, noiIm);
    figure((func-1)*4+1)
    imshow(uint8(im), imagemap);
    figure((func-1)*4+2)
    imshow(uint8(noiIm));
    figure((func-1)*4+3)
    imshow(noise);
    
    testIm(:,:,1) = uint8(noiIm);
    sigmas = logic(testIm);
    figure((func-1)*4+4)
    sqr=sqrt(sigmas);
    imshow(sqr);
    
    



