load ionosphere;

trainx = X(1:250,:);trainy = Y(1:250,:);
testx = X(251:351,:);testy = Y(251:351);

SVMModel = fitcsvm(trainx,trainy);

CVSVMModel = crossval(SVMModel);

[Ind,score] = predict(SVMModel,testx);

[a, order] = confusionmat(testy,Ind);

