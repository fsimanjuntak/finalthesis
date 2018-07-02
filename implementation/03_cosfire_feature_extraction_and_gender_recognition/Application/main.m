tic
COSFIREFilters = 120
faceDetection = 0
imageSize = 128
% GENDER-FERET dataset is validated using training and testing set
%datasource = 'C:\Users\Newbie\Desktop\FinalMasterThesis\finalthesis\implementation\datasource\processedrawdata\GENDER-FERET\'
%[data,datacnn,datacnncosfire] = Gender_recognition_with_CNN_and_COSFIRE(COSFIREFilters, datasource, faceDetection, imageSize);
% LFW dataset is validated using 5 fold cross validation
datasource = 'C:\Users\Newbie\Desktop\FinalMasterThesis\finalthesis\implementation\datasource\processedrawdata\LFW\'
[data,datacnn,datacnncosfire] = Gender_recognition_with_CNN_and_COSFIRE_CROSSVALIDATION(COSFIREFilters, datasource, faceDetection, imageSize);
toc