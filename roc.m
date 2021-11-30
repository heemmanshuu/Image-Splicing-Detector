clear;
clc;
close all;

sz = [2, 4, 5];
thr = [0, 0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1, 5, 10, 100, 1000];
noise = [ 0.01, 1, 5, 10];

images = dir("4cam_auth/");

figure(1)
hold all;

for ind = 1:4
    tr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    fal = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    count = 0;
    for i = 50: 60
            count = count+1;
            image = images(i);
    
            im = imread("4cam_auth/"+image.name);
            im = double(rgb2ycbcr(im));
            im = im(:, :, 1);
            [w, h] = size(im);
    
            noiIm = addNoiseRectangle(im, 4*w/20, 4*h/20, w, h, noise(ind));
            sigmas = logic(noiIm);
            
        for thind = 1:12
            idx = sigmas(floor(w/2-4*w/20):floor(w/2+4*w/20), floor(h/2-4*h/20):floor(h/2+4*h/20))>thr(thind);
            temp_true = sum(idx, "all");
            idx = sigmas>thr(thind);
            fal_temp = sum(idx, "all") - temp_true;
            temp_sz = (floor(w/2+4*w/20)-floor(w/2-4*w/20)+1)*(floor(h/2+4*h/20)-floor(h/2-4*h/20)+1);
            tr(thind) = tr(thind) + temp_true/(temp_sz);
            fal(thind) = fal(thind) + fal_temp/(w*h - temp_sz);        
        end
    end
    tr = tr/count;
    fal = fal/count;
    plot(fal, tr);
end
hold off;


legend('0.01 noise', '1 noise', '10 noise');





figure(2)
hold all;


for ind = 1:3
    tr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    fal = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    count = 0;
    for i = 50: 60
            count = count+1;
            image = images(i);
    
            im = imread("4cam_auth/"+image.name);
            im = double(rgb2ycbcr(im));
            im = im(:, :, 1);
            [w, h] = size(im);
    
            [noiIm, noise] = addNoiseRectangle(im, sz(ind)*w/20, sz(ind)*h/20, w, h, 5);
            sigmas = logic(noiIm);
            
        for thind = 1:12
            idx = sigmas(floor(w/2-sz(ind)*w/20):floor(w/2+sz(ind)*w/20), floor(h/2-sz(ind)*h/20):floor(h/2+sz(ind)*h/20))>thr(thind);
            temp_true = sum(idx, "all");
            idx = sigmas>thr(thind);
            fal_temp = sum(idx, "all") - temp_true;
            temp_sz = (floor(w/2+sz(ind)*w/20)-floor(w/2-sz(ind)*w/20)+1)*(floor(h/2+sz(ind)*h/20)-floor(h/2-sz(ind)*h/20)+1);
            tr(thind) = tr(thind) + temp_true/(temp_sz);
            fal(thind) = fal(thind) + fal_temp/(w*h - temp_sz);        
        end
    end
    tr = tr/count;
    fal = fal/count;
    plot(fal, tr);
end
hold off;
legend('4% size', '16% size', '25% size');