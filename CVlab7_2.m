a = imread('157055.jpg');
a = im2double(rgb2gray(a));
b = imcrop(a,[273.510000000000,1.51000000000000,207.980000000000,319.980000000000]);
apoints = detectHarrisFeatures(a);
bpoints = detectHarrisFeatures(b);

[featurea,valid_apoints] = extractFeatures(a,apoints);
[featureb,valid_bpoints] = extractFeatures(b,bpoints);

pairs = matchFeatures(featurea,featureb);

matchedPointsa = valid_apoints(pairs(:,1),:);
matchedPointsb = valid_bpoints(pairs(:,2),:);

figure, showMatchedFeatures(a,b,matchedPointsa,matchedPointsb);

I = checkerboard;
BW = edge(I,'canny');
figure,subplot(121),imshow(I);subplot(122),imshow(BW);
[H,theta,rho] = hough(BW);
figure
imshow(imadjust(rescale(H)),[],...
       'XData',theta,...
       'YData',rho,...
       'InitialMagnification','fit');
xlabel('\theta (degrees)')
ylabel('\rho')
axis on
axis normal 
hold on
colormap(gca,hot)
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','black');

lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);
figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');