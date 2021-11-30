function [noiIm, noise] = addNoiseSquares(im)
    
    noiIm = double(im);
    noise = zeros(size(im));
    [w, h] = size(im);
    offset = 100;
    for i = offset/2 :offset:w-offset/2
        for j = offset/2 :offset:h-offset/2
            noise(i:i+offset/2-1, j:j+offset/2-1) = 25*randn(offset/2, offset/2);
            noiIm(i:i+offset/2-1, j:j+offset/2-1) = noiIm(i:i+offset/2-1, j:j+offset/2-1) + noise(i:i+offset/2-1, j:j+offset/2-1);
        end  
    end
  

%{
decIm = double(im);
count = 0;
for i = 1:46:w
    for j = 1:46:h
        
        for i1 = 1:22
            for i2 = 1:22
                if ( abs(decIm(i+i1, j+i2)) >= 0.1)
                    count = count + 1;
                end

            end
        end
    end  
end

accuracy = (count*4)/(w*h)

%ind = 
%}

