function [outputArg1] = removeplate(inputArg1)
%   remove the plate of the car
image = inputArg1;
image_gray = rgb2gray(image);

se1 = [1;1;1];
se2 = strel('rectangle',[25,25]);
image_result = edge(image_gray,'roberts');%edge detect
im = imerode(image_result,se1);
im2 = imclose(im,se2);

I_final = bwareaopen(im2,3000);%remove small areas

[y,x]=size(I_final);
i6=double(I_final);
Y1=zeros(y,1);
for ii=1:y %Count the number of pixels in each row with a value of 1.
    for jj=1:x
        if(i6(ii,jj,1)==1)
            Y1(ii,1)=Y1(ii,1)+1;
        end
    end
end
[temp,MaxY]=max(Y1); %Temp is the maximum value of Y1, and MaxY is the number of rows in which it is located.

PY1=MaxY;
while((Y1(PY1,1)>=50)&&(PY1>1)) %upper boundary
    PY1=PY1-1;
end
PY2=MaxY;
while((Y1(PY2,1)>=50)&&(PY2<y)) %lower boundary
    PY2=PY2+1;
end

X1=zeros(1,x);
for jj=1:x %Count the number of pixels in each column with a value of 1.
    for ii=PY1:PY2
        if(i6(ii,jj,1)==1)
            X1(1,jj)=X1(1,jj)+1;
        end
    end
end

PX1=1;
while((X1(1,PX1)<15)&&(PX1<x)) %left border
    PX1=PX1+1;
end
PX2=x;
while((X1(1,PX2)<15)&&(PX2>PX1)) %right border
    PX2=PX2-1;
end
PX1=PX1-1;
PX2=PX2+1;

dw=image(PY1:PY2,PX1:PX2,:); %plate area
outputArg1 = image;
platex = PX1:PX2;
platey = PY1:PY2;
outputArg1(platey,platex,:) = nan; %remove plate area
% figure,imshow(dw);
% figure,imshow(image_car);
end

