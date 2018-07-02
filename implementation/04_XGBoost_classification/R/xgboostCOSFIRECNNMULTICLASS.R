setwd("C:/Users/Newbie/Desktop/FinalMasterThesis/finalthesis/implementation/04_XGBoost_classification/R")
require(xgboost)

rm(list=ls())

source = "C:/Users/Newbie/Desktop/FinalMasterThesis/finalthesis/implementation/datasource/processedrawdata/GENDER-FERET/results/csvfeatures"

#IDX_DATASET= 1 (COSFIRE), IDX_DATASET = 2 (CNN), IDX_DATASET = 3 (COSFIRE+CNN)
IDX_DATASET = 3
arr_training_files = c('cosfiretrainingfeatures.csv','cnntrainingfeatures.csv','cnncosfiretrainingfeatures.csv')
arr_testing_files = c('cosfiretestingfeatures.csv','cnntestingfeatures.csv','cnncosfiretestingfeatures.csv')

dftrainingfeatures <- read.table(file = paste(source,"/",arr_training_files[IDX_DATASET], sep=""), sep =",", header = FALSE, stringsAsFactors = TRUE)
dftraininglabels <- read.table(file = paste(source,"/","trainingcosfirelabels.csv", sep=""), sep =",", header = FALSE, stringsAsFactors = TRUE)
dftestingfeatures <- read.table(file = paste(source,"/",arr_testing_files[IDX_DATASET], sep=""), sep =",", header = FALSE, stringsAsFactors = TRUE)
dftestinglabels <- read.table(file = paste(source,"/","testingcosfirelabels.csv", sep=""), sep =",", header = FALSE, stringsAsFactors = TRUE)

#Convert training and testing data to matrix
matrix_training_X = as.matrix(dftrainingfeatures)
matrix_training_Y = as.matrix(dftraininglabels)
matrix_testing_X = as.matrix(dftestingfeatures)
matrix_testing_Y = as.matrix(dftestinglabels)

#Convert training and testing to xgb.DMatrix
dtrain <-xgb.DMatrix(data = matrix_training_X, label=matrix_training_Y)
dtest <- xgb.DMatrix(data = matrix_testing_X,label = matrix_testing_Y)
label = getinfo(dtest, "label")


#binary logistic
#bst <- xgboost(data = dtrain,
#              max_depth = 6, eta = 1, nrounds = 35, 
#               objective = "binary:logistic")
#pred <- predict(bst, dtest)
#err <- mean(as.numeric(pred > 0.5) != label)
#print(paste("test-error=", err))
#print(paste("accuracy=", 1-err))



#multiclass
num_class = 2
bst <- xgboost(data = dtrain,
                max_depth = 6, eta = 0.5, nrounds = 35, subsample = 0.5,
                objective = "multi:softprob", num_class = num_class)


# predict for softmax returns num_class probability numbers per case:
pred <- predict(bst, dtest)
str(pred)
#reshape it to a num_class-columns matrix
pred <- matrix(pred, ncol=num_class, byrow=TRUE)
#convert the probabilities to softmax labels
pred_labels <- max.col(pred) - 1
#the following should result in the same error as seen in the last iteration
err = sum(pred_labels != label)/length(label)
print(paste("test-error=", err))
print(paste("test-accuracy=", 1-err))
