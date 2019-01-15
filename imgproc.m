function [outputArg1] = imgproc(inputArg1)
%  sharpening image(high pass filtering) using fft2
I_fft_gray = im2double(rgb2gray(inputArg1));
h = fspecial('log',100); %choose a filter
I_fft = fft2(I_fft_gray,1024,1024); 
fil_fft = fft2(h,1024,1024);
I_log_fft = I_fft.*fil_fft;
I_fft_result = ifft2(I_log_fft);
% I_fft_result=I_fft_result(1:size(I_fft_gray,1),1:size(I_fft_gray,2));
outputArg1 = I_fft_result;
end

