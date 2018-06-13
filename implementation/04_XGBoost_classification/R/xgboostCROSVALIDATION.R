setwd("C:/Users/Newbie/Desktop/FinalMasterThesis/finalthesis/implementation/04_XGBoost_classification/R")
require(xgboost)

rm(list=ls())

source = "C:/Users/Newbie/Desktop/FinalMasterThesis/implementasi/datasource/processedrawdata/LFW/cnnsurf/LFW/results/csvfeatures"

#IDX_DATASET= 1 (COSFIRE), IDX_DATASET = 2 (CNN), IDX_DATASET = 3 (COSFIRE+CNN)
IDX_DATASET = 2
arr_dataset_files = c('cosfirecrossvalidationfeatures.csv','cnncrossvalidationfeatures.csv','cnncosfirecrossvalidationfeatures.csv')


dffeatures <- read.table(file = paste(source,"/",arr_dataset_files[IDX_DATASET], sep=""), sep =",", header = FALSE, stringsAsFactors = TRUE)
dflabels <- read.table(file = paste(source,"/","crossvalidationlabels.csv", sep=""), sep =",", header = FALSE, stringsAsFactors = TRUE)

#Convert data frames to matrix
matrix_X = as.matrix(dffeatures)
matrix_Y = as.matrix(dflabels)

#Convert training and testing to xgb.DMatrix
dtrain <-xgb.DMatrix(data = matrix_X, label= matrix_Y)

#multiclass
cv <- xgb.cv(data = dtrain, nfold = 5,
             nrounds = 20, objective = "binary:logistic",
             early_stopping_rounds = 3, maximize = FALSE)


print(cv)
