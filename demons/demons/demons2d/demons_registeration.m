close all;
clear all;
R = imread('r.png');
R = imresize(R, 0.5);

[G, gsx, gsy] = demons('r.png', 'g.png');
G = uint8(G);
%G = imresize(G, 2);

[B, bsx, bsy] = demons('r.png', 'b.png');
B = uint8(B);
%B = imresize(B, 2);

img = cat(3, R, G, B);

close all;
imshow(img);