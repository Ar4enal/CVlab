I = imread('E:\Ӧ�ñ���Ƭ����\qiaoshan.jpg');
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
        %ͨ����hͨ����ɫֵ�ض���Χ�ڱ��Ͷ���Ϊ0��������Χ����ɫֵ
        if 0.33 < h || h < 0.167
            I_h(i,j,2)=0;
        end
    end
end
figure,imshow(I_h);