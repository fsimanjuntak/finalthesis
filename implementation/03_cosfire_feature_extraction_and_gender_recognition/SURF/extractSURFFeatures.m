function [accuracy,datasurf,SURFTrainingScore,SURFTestingScore] = extractSURFFeatures(SURFdir,data)
accuracy = 0 ;
SURFTrainingScore = [];
SURFTestingScore = [];

% Load vggface training features
load(strcat(SURFdir,'/datasurf.mat'));
datasurf.training.features = datasurf.training.features;
datasurf.training.labels = categorical(data.training.labels)';
datasurf.testing.features = datasurf.testing.features;
datasurf.testing.labels = categorical(data.testing.labels)';

% cl2 = fitcsvm(datasurf.training.features,datasurf.training.labels,'KernelFunction','rbf');
% [~,scores2] = predict(cl2,datasurf.testing.features);

% Classify gender using SVM ECOC
SVMSURFClassifier = fitcecoc(datasurf.training.features,datasurf.training.labels);
[~,SURFTrainingScore] = predict(SVMSURFClassifier,datasurf.training.features);
[predictedLabels,SURFTestingScore] = predict(SVMSURFClassifier,datasurf.testing.features);
accuracy = mean(predictedLabels == datasurf.testing.labels);

