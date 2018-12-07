I = imread('C:\Users\DELL\OneDrive - Loughborough University\Attachments\qiaoshan.jpg');
I = im2double(rgb2gray(I));
h1 = fspecial('average',100);
h2 = fspecial('gaussian',100,2);
h3 = fspecial('log',100);
I2 = conv2(I,h2);
% Blurring an image
fftsize = 1024;
I_fft = fft2(I,fftsize,fftsize);
fil_fft = fft2(h2,fftsize,fftsize);
I_gau_fft = I_fft.*fil_fft;
I_fil = ifft2(I_gau_fft);
I_fil = I_fil(1+50:size(I,1)+50, 1+50:size(I, 2)+50);
figure,subplot(2,2,1),imshow(I),title('Gray original');subplot(2,2,2),imshow(I2),title('Gaussian');
subplot(2,2,3),imagesc(log(abs(fftshift(I_fft)))), axis image, colormap jet;subplot(2,2,4),imshow(I_fil),title('blurring image(low pass filtering)');

% Sharpening an image
I3 = conv2(I,h3);
I3_fft = fft2(I,fftsize,fftsize);
fil3_fft = fft2(h3,fftsize,fftsize);
I_log_fft = I3_fft.*fil3_fft;
I3_fil = ifft2(I_log_fft);
I3_fil = I3_fil(1+50:size(I,1)+50, 1+50:size(I, 2)+50);
figure,subplot(2,2,1),imshow(I),title('Gray original');subplot(2,2,2),imshow(I3),title('LoG');
subplot(2,2,3),imagesc(log(abs(fftshift(I3_fft)))), axis image, colormap jet;subplot(2,2,4),imshow(I3_fil),title('sharpening image(high pass filtering)');

% Sub-sampling and up-sampling
b1 = imresize(I,0.5,'nearest','Antialiasing',false);
b2 = imresize(I,0.5,'bilinear');
b3 = imresize(I,0.5,'bicubic');
figure,subplot(1,4,1),imshow(I),title('original');subplot(1,4,2),imshow(b1),title('nearest');subplot(1,4,3),imshow(b2),title('bilinear');subplot(1,4,4),imshow(b3),title('bicubic');

