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
subdatasource = ''
displayImg = 1;
input_path = strcat('C:\Users\Newbie\Desktop\FinalMasterThesis\implementasi\datasource\processedrawdata\',datasource,subdatasource);
extractFeatures(input_path,displayImg)




