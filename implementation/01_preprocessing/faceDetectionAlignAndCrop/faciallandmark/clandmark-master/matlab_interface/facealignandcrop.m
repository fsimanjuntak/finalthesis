clc; 
clearvars; close all;

%% Add path
addpath('../learning/flandmark/code/functions/');
 
% DOUBLE PRECISION
rmpath('./mex_single_precision/');
addpath('./mex/');

% SINGLE PRECISION
% rmpath('./mex/');
% addpath('./mex_single_precision/');

addpath('./functions/');
datasource = 'GENDER-FERET'
displayImg = 0;
input_path = strcat('C:\Users\Newbie\Desktop\FinalMasterThesis\finalthesis\implementation\datasource\rawdata\',datasource);
output_path = strcat('C:\Users\Newbie\Desktop\FinalMasterThesis\finalthesis\implementation\datasource\processedrawdata\',datasource);
alignDataset(input_path,output_path,displayImg)


