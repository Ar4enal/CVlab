image_test = imread('vw.jpg');
image_test_plate = removeplate(image_test); %remove plate
image_test = histeq(image_test_plate); %histogram equalization
I_fil = imgproc(image_test); %image process

scaleTestImage1 = imresize(I_fil,imageSize);
featureTestimage = extractHOGFeatures(scaleTestImage1); %feature detect
[testpredictIndex,score1] = predict(Classifier,featureTestimage); %predict the car model

figure,imshow(image_test_plate),title(['Prediction:',char(testpredictIndex)]);