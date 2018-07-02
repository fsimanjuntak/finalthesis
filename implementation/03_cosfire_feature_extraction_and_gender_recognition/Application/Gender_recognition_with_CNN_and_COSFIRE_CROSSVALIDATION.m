% Gender recognition from face images with trainable COSFIRE filters
% 
% VERSION 18/08/2016
% CREATED BY: George Azzopardi, University of Malta, 
% 			Antonio Greco and Mario Vento, University of Salerno
% 
% ENHANCED BY : Frans Simanjuntak, University of Groningen
% If you use this script please cite the following papers:
% 
%[1] George Azzopardi, Antonio Greco and Mario Vento, "Gender recognition from
%    face images with trainable COSFIRE filters", IEEE Advanced Video and 
%    Signal-based Surveillance (AVSS) 2016, in print
% 
%[2] George Azzopardi and Nicolai Petkov, "Trainable COSFIRE filters for
%    keypoint detection and pattern recognition", IEEE Transactions on Pattern 
%    Analysis and Machine Intelligence, vol. 35(2), pp. 490-503, 2013.
% 
% We use COSFIRE filters [2] to form a face descriptor and use it for gender 
% recognition. COSFIRE filters are trainable shape detectors. The term trainable 
% refers to the ability of determining their selectivity in an automatic 
% configuration process that analyses a given prototype pattern of interest 
% in terms of its dominant orientations and their mutual spatial arrangement. 
% Our hypothesis is that by configuring multiple COSFIRE filters, that are 
% selective for different parts of the faces, we can capture the subtle 
% differences that distinguish the faces of men and women. 
%
% The steps for the recognition of the gender are the following:
% - First we apply the Viola-Jones algorithm to the image and resize the 
%   detected face to a fixed size of 128 by 128 pixels.
% - Then we apply a set of COSFIRE filters that we learned from training 
%   images and use their responses to compute a descriptor of the face. For 
%   more details about the configuration procedure and the response computation 
%   we refer the reader to [1].
% - Finally we recognize the gender of a person using an SVM classification 
%   model with a Chi-squared kernel, that is more appropriate than other types 
%   of kernel since we are dealing with histograms.
%
% We demonstrate the effectiveness of the proposed approach on 
% the GENDER-FERET dataset and achieve an accuracy rate of ~94%. 
% 
% Example 1: 
%   result = Gender_recognition_with_COSFIRE(90, './GENDER-FERET/', 1, 128); 
%
% The above code runs an experiment to recognize the gender of the people in the test set
% of the GENDER-FERET dataset. The 180 filters (90 from female images and 90 from male 
% images) are configured and selected using the training set of the GENDER-FERET dataset. 
% For more details we refer the reader to [1]. 
%
% Input parameters:
% - noperatorspergender: number of COSFIRE filters to use for each gender type. 
% - dataFolder: path of the dataset folder. If you don't want to modify the
%   code, you have to preserve the organization of the folder, with the
%   sub-folders 'male' and 'female' in the first level and the sub-folders
%   'training' and 'test' in the second level.
% - doFaceDetection: if 1, it performs face detection using the Viola-Jones
%   algorithm. Otherwise, it considers the full image as a face.
% - resizeWidth: If resizeWidth is set NaN then the face images are not resized, otherwise they are resized to
%   [resizeWidth, resizeWidth].
%
function [data,datacnn,datacnncosfire] = Gender_recognition_with_CNN_and_COSFIRE_CROSSVALIDATION(noperatorspergender, dataFolder, doFaceDetection, resizeWidth)
%Initialize outputs
data = [];
datacnn = [];
datacnncosfire = [];

% Update the Matlab path with the following
addpath('../COSFIRE/');
addpath('../Gabor/');
addpath('../Gender_recognition/');
addpath('../libsvm_3_21/matlab/');
addpath('../CNN/');

% Configure the image paths. If you want to organize your folder in a
% different way, please modify these lines.
dirlist.maledir             = strcat(dataFolder,filesep,'male');
dirlist.femaledir           = strcat(dataFolder,filesep,'female');
dirlist.trainingmaledir     = strcat(dirlist.maledir,filesep,'training_set');
dirlist.trainingfemaledir   = strcat(dirlist.femaledir,filesep,'training_set');
dirlist.testingmaledir      = strcat(dirlist.maledir,filesep,'test_set');
dirlist.testingfemaledir    = strcat(dirlist.femaledir,filesep,'test_set');

% Create the folder for the results. The results of all the experiments will 
% be saved in this folder.
outdir = [dataFolder,sprintf('/results/noperatorspergender=%d',noperatorspergender)];
CNNdir = strcat(dataFolder,'results/cnnfeatures');
CSVdir = strcat(dataFolder,'results/csvfeatures');
if ~exist(outdir)
    mkdir(outdir);
end

if ~exist(CNNdir)
    mkdir(CNNdir);
    fprintf('CNN features do not exist. Please extract the features and run this program again!\n');
    return
elseif exist(CNNdir) && ~exist(strcat(CNNdir,'/vggfacefeatures.mat')) 
    fprintf('CNN features do not exist. Please extract the features and run this program again!\n');
    return
end

if ~exist(CSVdir)
    mkdir(CSVdir);
end

% Load the dataset and, if needed, perform face detection and resize. If
% the faces are already available, they are loaded from the file 'dataset.mat'. 
dataset = getDataset(dataFolder,dirlist,doFaceDetection,resizeWidth);

% Configure the COSFIRE operators. If the operators are already available, 
% they are loaded from the file 'operatorlist.mat'. 
operatorlist = getCOSFIREoperators(outdir,dataset,noperatorspergender);
% viewCOSFIREstructure(operatorlist{1,1});
% viewCOSFIREstructure(operatorlist{1,2});

% COSFIRE descriptors
% Get training and test descriptors. If the descriptors are already available, 
% they are loaded from the file 'COSFIREdescriptor.mat'.
[data.training.desc,data.testing.desc] = getCOSFIREdescriptors(outdir,dataset,operatorlist);
% Set training and test labels
data.training.labels = [ones(1,size(dataset.training.males,3)),ones(1,size(dataset.training.females,3))*2];
data.testing.labels = [ones(1,size(dataset.testing.males,3)),ones(1,size(dataset.testing.females,3))*2];
% Normalize training and test data
data = normalizeData(data,numel(operatorlist));
% Merge training and testing features for cross validation
data.crossvalidation.desc = [data.training.desc;data.testing.desc];
data.crossvalidation.labels = categorical([data.training.labels';data.testing.labels']);

%======================== COSFIRE ================================
% Train and Validate COSFIRE with SVM ECOC 
trainedCOSFIRESVMClassifier = fitcecoc(data.crossvalidation.desc,data.crossvalidation.labels);
%trainedCOSFIRESVMClassifier = fitcsvm(data.crossvalidation.desc,data.crossvalidation.labels); %, 'Learners', SVMTemplate, 'Coding', 'onevsone');
partModelCOSFIRESVM = crossval(trainedCOSFIRESVMClassifier, 'KFold', 5);
AccuracyCOSFIRESVM = 1 - kfoldLoss(partModelCOSFIRESVM, 'LossFun', 'classiferror');
[COSFIREValidationPredictions, COSFIRESVMScores] = kfoldPredict(partModelCOSFIRESVM);
confusionmat(data.crossvalidation.labels,COSFIREValidationPredictions); 
fprintf('Recognition Rate COSFIRE: %2.6f\n',AccuracyCOSFIRESVM);

%======================== CNN VGGFACE ================================
% Extract and Validate VGGFace features
[CNNaccuracy,datacnn,CNNSVMScore] = extractandvalidateVGGFeaturesCrossValidation(dirlist,CNNdir,numel(operatorlist));

%========================Merge Features =============================
% Merge CNN and COSFIRE features
datacnncosfire.training.features = [datacnn.crossvalidation.normalizedfeatures';data.crossvalidation.desc'];
datacnncosfire.training.features = datacnncosfire.training.features';
% Merge CNN and COSFIRE scores
datacnncosfire.training.scores = [CNNSVMScore';COSFIRESVMScores'];
datacnncosfire.training.scores = datacnncosfire.training.scores';

%======================== Concatenation Approach ==========================
% Train and Validate Fusion of VGGFace and COSFIRE
CNNCOSFIRESVM = fitcecoc(datacnncosfire.training.features,data.crossvalidation.labels);
%CNNCOSFIRESVM = fitcsvm(datacnncosfire.training.features,data.crossvalidation.labels);
partModelCNNCOSFIRESVM = crossval(CNNCOSFIRESVM, 'KFold', 5);
AccuracyCNNCOSFIRESVM = 1 - kfoldLoss(partModelCNNCOSFIRESVM, 'LossFun', 'ClassifError');
[CNNCOSFIREvalidationPredictions, CNNCOSFIRESVMScore] = kfoldPredict(partModelCNNCOSFIRESVM);
fprintf('Recognition Rate CNN+COSFIRE: %2.6f\n',AccuracyCNNCOSFIRESVM);

%======================== Stacking Approach ==========================
% Train and Validate Fusion of VGGFace and COSFIRE
CNNCOSFIRESVMStacked = fitcecoc(datacnncosfire.training.scores,data.crossvalidation.labels);
partModelCNNCOSFIRESVMStacked = crossval(CNNCOSFIRESVMStacked, 'KFold', 5);
AccuracyCNNCOSFIREStackedSVM = 1 - kfoldLoss(partModelCNNCOSFIRESVMStacked, 'LossFun', 'ClassifError');
[CNNCOSFIREStackedvalidationPredictions, CNNCOSFIREStackedSVMScore] = kfoldPredict(partModelCNNCOSFIRESVMStacked);
fprintf('Recognition Rate CNN+COSFIRE Stacked: %2.6f\n',AccuracyCNNCOSFIREStackedSVM);


% =====================  Write features to CSV =======================
fusion.crossvalidation.labels = double(data.crossvalidation.labels);
fusion.crossvalidation.labels(fusion.crossvalidation.labels==1)=0;
fusion.crossvalidation.labels(fusion.crossvalidation.labels==2)=1;
csvwrite(strcat(CSVdir,'/crossvalidationlabels.csv'),fusion.crossvalidation.labels);

%1.COSFIRE
fusion.cosfire.crossvalidation.features = data.crossvalidation.desc;
csvwrite(strcat(CSVdir,'/cosfirecrossvalidationfeatures.csv'),fusion.cosfire.crossvalidation.features);

%2.CNN
fusion.cnn.crossvalidation.features = datacnn.crossvalidation.normalizedfeatures;
csvwrite(strcat(CSVdir,'/cnncrossvalidationfeatures.csv'),fusion.cnn.crossvalidation.features);

%3.CNN+COSFIRE
fusion.cnncosfire.crossvalidation.features = datacnncosfire.training.features;
csvwrite(strcat(CSVdir,'/cnncosfirecrossvalidationfeatures.csv'),fusion.cnncosfire.crossvalidation.features);

