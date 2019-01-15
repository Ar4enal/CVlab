I = imread('C:\Users\DELL\OneDrive - Loughborough University\Computer Vision\Lab5\testimages\car3.jpg');
I = rgb2gray(I);
B = imrotate(I,90);
[a, r, c] = Harris(I,1,0.04);
[b, r1, c1] = Harris(B,1,0.04);
subplot(131),imshow(I);subplot(132),imshow(a);subplot(133),imshow(b);