clear all;
clc;
%importing image 
obj = imread(uigetfile('.jpg'));
imshow(obj);
%% ---------- segmentation of the image--------------
%dividing image based on color components
red = obj(:,:,1);
green = obj(:,:,2);
blue = obj(:,:,3);

figure(1)
subplot(2,2,1);
imshow(obj);
title('Original image');

subplot(2,2,2);
imshow(red);
title('Red component');

subplot(2,2,3);
imshow(green);
title('Green component');

subplot(2,2,4);
imshow(blue);
title('Blue component');

%Thersholding blue component result due to high contrast
figure(2)
level = 0.16;   %can be different for different images
bw_obj = im2bw(blue,level);
subplot(2,2,1);
imshow(bw_obj);
title('blue component threshold');

%% -----------------removing noise-----------------

%filling holes
fill = imfill(bw_obj,'holes');
subplot(2,2,2);
imshow(fill);
title('Holes filled');

%removing blobs on border of the image
clean = imclearborder(fill);
subplot(2,2,3);
imshow(clean);
title('Cleaned image')

%removing blobs that are smaller than 7 pixels
se = strel('disk',7);
open = imopen(fill,se);
subplot(2,2,4);
imshow(open);
title('Cleaner image');

%% measuring object diameter

diameter = regionprops(open,'MajorAxisLength')

%results
figure(3)
imshow(obj)
d = imdistline; %includes a line to physically measure



