COSFIREFilters = 120
faceDetection = 0
imageSize = 128
classifierType = 2
datasource = 'C:\Users\Newbie\Desktop\FinalMasterThesis\implementasi\datasource\processedrawdata\GENDER-FERET\'
%datasource = 'C:\Users\Newbie\Desktop\FinalMasterThesis\implementasi\datasource\processedrawdata\LFW\7433grayscalebalancedout\2345\'
%[data,datacnn,datacnncosfire] = Gender_recognition_with_CNN_and_COSFIRE(COSFIREFilters, datasource, faceDetection, imageSize);
[data,datacnn,datacnncosfire] = Gender_recognition_with_CNN_and_COSFIRE_Stacking(COSFIREFilters, datasource, faceDetection, imageSize, classifierType);