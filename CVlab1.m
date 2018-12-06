I = imread('E:\应用宝照片备份\qiaoshan.jpg');
I = im2double(I);
I_h = rgb2hsv(I);
[hue,S,V] = rgb2hsv(I);
% subplot(1,4,1),imshow(I);
% subplot(1,4,2),imshow(hue);
% subplot(1,4,3),imshow(S);
% subplot(1,4,4),imshow(V);
[height,width,c]=size(I);
for i=1:height
    for j=1:width
        h=I_h(i,j,1);
        s=I_h(i,j,2);
        v=I_h(i,j,3);
        %通过将h通道颜色值特定范围内饱和度设为0，保留范围外颜色值
        if 0.33 < h || h < 0.167
            I_h(i,j,2)=0;
        end
    end
end
figure,imshow(I_h);