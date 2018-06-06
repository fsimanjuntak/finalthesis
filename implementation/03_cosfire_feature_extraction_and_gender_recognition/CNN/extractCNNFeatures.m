function [accuracy,datacnn,CNNTrainingScore,CNNTestingScore] = extractCNNFeatures(dirList,CNNdir,noperators, data)
% Load Training and Test Image Sets
% [trainingSet, testSet] = getCNNDataset(dirList);

% Load vggface training features
load(strcat(CNNdir,'/vggfacefeatures.mat'));
datacnn.training.features = vggfacefeatures.trainingFeatures;
% datacnn.training.labels = trainingSet.Labels;
datacnn.training.labels = categorical(vggfacefeatures.trainingLabels)';
datacnn.testing.features = vggfacefeatures.testFeatures;
% datacnn.testing.labels = testSet.Labels;
datacnn.testing.labels = categorical(vggfacefeatures.testLabels)';

% Normalization
% fun = @(x) normr(x);
% datacnn.training.normalizedfeatures = blkproc(datacnn.training.features,[size(datacnn.training.features,1),noperators],fun);
% datacnn.testing.normalizedfeatures = blkproc(datacnn.testing.features,[size(datacnn.testing.features,1),noperators],fun);
 % Normalize features between 0 and 1
datacnn.training.normalizedfeatures = datacnn.training.features - min(datacnn.training.features(:));
datacnn.training.normalizedfeatures = double(datacnn.training.normalizedfeatures ./ max(datacnn.training.normalizedfeatures(:)));
datacnn.testing.normalizedfeatures = datacnn.testing.features - min(datacnn.testing.features(:));
datacnn.testing.normalizedfeatures = double(datacnn.testing.normalizedfeatures ./ max(datacnn.testing.normalizedfeatures(:)));


% Fit Image Classifier CNN
% t = templateSVM();
% SVMCOSFIREClassifier = fitcecoc(datacnn.training.normalizedfeatures,datacnn.training.labels,...
%                         'Learners',t,'FitPosterior',1,...
%                         'ClassNames',categorical({'1','2'}));
% [~,CNNTrainingScore,~,postProbsTraining] = predict(SVMCOSFIREClassifier,datacnn.training.normalizedfeatures);
% [predictedLabels,CNNTestingScore,~,postProbsTesting] = predict(SVMCOSFIREClassifier,datacnn.testing.normalizedfeatures);
% accuracy = mean(predictedLabels == datacnn.testing.labels);

SVMCOSFIREClassifier = fitcecoc(datacnn.training.normalizedfeatures,datacnn.training.labels);
[~,CNNTrainingScore] = predict(SVMCOSFIREClassifier,datacnn.training.normalizedfeatures);
[predictedLabels,CNNTestingScore] = predict(SVMCOSFIREClassifier,datacnn.testing.normalizedfeatures);
accuracy = mean(predictedLabels == datacnn.testing.labels);

% kernel = @(X,Y) customkernel(X,Y,noperators,1,'chi2');
% numTrain = size(datacnn.training.normalizedfeatures,1);   
% trainingKernel = [(1:numTrain)', kernel(datacnn.training.normalizedfeatures,datacnn.training.normalizedfeatures)];    
% modelPyramid = svmtrain(data.training.labels',trainingKernel,'-t 4 -c 1 -q');
% [~,~,CNNTrainingScore] = svmpredict(data.training.labels',trainingKernel, modelPyramid); 
% 
% numTest = size(datacnn.testing.normalizedfeatures,1);
% testingKernel = [(1:numTest)' , kernel(datacnn.testing.normalizedfeatures,datacnn.training.normalizedfeatures)]; 
% [pl,~,CNNTestingScore] = svmpredict(data.testing.labels',testingKernel,modelPyramid);    
% result = classperf(data.testing.labels,pl);
% accuracy = result.info.CorrectRate;



