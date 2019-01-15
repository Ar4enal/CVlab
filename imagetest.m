numTest = length(carsTest.Files);

for i = 1:numTest %test images features detection
    testImage = readimage(carsTest,i);
    scaleTestImage = imresize(testImage,imageSize);
    featureTest(i,:) = extractHOGFeatures(scaleTestImage);
    [predictIndex,score] = predict(Classifier,featureTest);
end
CVSVMModel = crossval(Classifier); %cross validation
loss = kfoldLoss(CVSVMModel); %classification loss

[a, order] = confusionmat(testLables,predictIndex); %compute confusion matrix
cm = confusionchart(testLables,predictIndex); %create confusion matrix chart
cm.Title = 'Car Classification Using SVM';
cm.NormalizedValues;
cm.RowSummary = 'row-normalized';
cm.ColumnSummary = 'column-normalized';