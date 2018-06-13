function [accuracy,datacnn,SVMCNNScore] = extractCNNCROSSVALIDATIONFeatures(dirList,CNNdir,noperators)
% Load vggface training features
load(strcat(CNNdir,'/vggfacefeatures.mat'));
datacnn.training.features = vggfacefeatures.trainingFeatures;
datacnn.training.labels = categorical(vggfacefeatures.trainingLabels)';
datacnn.testing.features = vggfacefeatures.testFeatures;
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

% Merge features
datacnn.crossvalidation.normalizedfeatures  = [datacnn.training.normalizedfeatures;datacnn.testing.normalizedfeatures];
datacnn.crossvalidation.labels = [datacnn.training.labels;datacnn.testing.labels];

% Train SVM
template = templateSVM('KernelFunction', 'rbf',  'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', 1);
SVMCNNClassifier = fitcecoc(datacnn.crossvalidation.normalizedfeatures,datacnn.crossvalidation.labels); %, 'Learners', template, 'Coding', 'onevsone');
%SVMCNNClassifier = fitcsvm(datacnn.crossvalidation.features,datacnn.crossvalidation.labels,'Standardize',true,'ClassNames',{'1','2'});
partModel = crossval(SVMCNNClassifier, 'KFold', 5);
accuracy = 1 - kfoldLoss(partModel, 'LossFun', 'ClassifError');
[~,SVMCNNScore] = kfoldPredict(partModel);
