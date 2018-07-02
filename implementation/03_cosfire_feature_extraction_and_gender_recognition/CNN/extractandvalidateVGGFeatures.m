function [accuracy,datacnn,CNNTrainingScore,CNNTestingScore] = extractandvalidateVGGFeatures(dirList,CNNdir,noperators)
% Load vggface training features
load(strcat(CNNdir,'/vggfacefeatures.mat'));
datacnn.training.features = vggfacefeatures.trainingFeatures;
datacnn.training.labels = categorical(vggfacefeatures.trainingLabels)';
datacnn.testing.features = vggfacefeatures.testFeatures;
datacnn.testing.labels = categorical(vggfacefeatures.testLabels)';

% Normalization
% Normalize features between 0 and 1
datacnn.training.normalizedfeatures = datacnn.training.features - min(datacnn.training.features(:));
datacnn.training.normalizedfeatures = double(datacnn.training.normalizedfeatures ./ max(datacnn.training.normalizedfeatures(:)));
datacnn.testing.normalizedfeatures = datacnn.testing.features - min(datacnn.testing.features(:));
datacnn.testing.normalizedfeatures = double(datacnn.testing.normalizedfeatures ./ max(datacnn.testing.normalizedfeatures(:)));

% =============== Train and Validate VGGFace with SVM ECOC =============
SVMCOSFIREClassifier = fitcecoc(datacnn.training.normalizedfeatures,datacnn.training.labels);
%SVMCOSFIREClassifier = fitcsvm(datacnn.training.normalizedfeatures,datacnn.training.labels);
[~,CNNTrainingScore] = predict(SVMCOSFIREClassifier,datacnn.training.normalizedfeatures);
[predictedLabels,CNNTestingScore] = predict(SVMCOSFIREClassifier,datacnn.testing.normalizedfeatures);
accuracy = mean(predictedLabels == datacnn.testing.labels);
fprintf('Recognition Rate CNN: %2.6f\n',accuracy);
