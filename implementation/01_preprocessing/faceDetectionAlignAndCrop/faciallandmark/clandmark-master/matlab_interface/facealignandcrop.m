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
datasource = 'LFW'
subdatasource = '\7433grayscalebalancedout\2345\'
displayImg = 0;
input_path = strcat('C:\Users\Newbie\Desktop\FinalMasterThesis\implementasi\datasource\rawdata\',datasource,subdatasource);
output_path = strcat('C:\Users\Newbie\Desktop\FinalMasterThesis\implementasi\datasource\processedrawdata\',datasource,subdatasource);
alignDataset(input_path,output_path,displayImg)




