carsTrain = imageDatastore('E:\Coursework\trainimage',...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames');
carsTest = imageDatastore('E:\Coursework\testimage',...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames');

Train_disp = countEachLabel(carsTrain); %display training picture type labels and number count
disp(Train_disp);

imageSize = [256,256];
image1 = readimage(carsTrain,1);
scaleImage = imresize(image1,imageSize);
features = extractHOGFeatures(scaleImage);

numImages = length(carsTrain.Files);
featuresTrain = zeros(numImages,size(features,2),'single'); 
for i = 1:numImages %train images features detection
    imageTrain = readimage(carsTrain,i);
    imageTrain = imresize(imageTrain,imageSize);
    featuresTrain(i,:) = extractHOGFeatures(imageTrain);
end

trainLabels = carsTrain.Labels; %all labels
testLables = carsTest.Labels;

Classifier = fitcecoc(featuresTrain,trainLabels); %svm classifer



