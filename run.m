clear;
clc;
close all;

name = '4cam_splc/3.tif';


im = imread(name);
% decolorize the image
im = double(rgb2ycbcr(im));
sigmas = logic(im);


idx1=sigmas>=0.05;
idx2=sigmas<0.05;
sigmas(idx1)=1;
sigmas(idx2)=0;

%{
siz=size(sigmas);
a=reshape(sigmas,[1,siz(1)*siz(2)]);
sigmas=kmeans(a.',2);
sigmas=reshape(sigmas,[siz(1),siz(2)])-1;
%} 



se = strel('square',16);
sigmas1 = imdilate(sigmas,se);
figure(1);
imshow(sigmas1);


