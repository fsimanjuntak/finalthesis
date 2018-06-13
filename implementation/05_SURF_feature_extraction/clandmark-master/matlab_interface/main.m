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
%datasource = 'GENDER-FERET'
%subdatasource = ''
datasource = 'LFW'
subdatasource = '\7433grayscale\2345'
displayImg = 0;
numOfFeatures = 6528;
input_path = strcat('C:\Users\Newbie\Desktop\FinalMasterThesis\implementasi\datasource\processedrawdata\',datasource,subdatasource);
output_path = strcat('C:\Users\Newbie\Desktop\FinalMasterThesis\implementasi\datasource\processedrawdata\',datasource,subdatasource,filesep,'results',filesep,'surffeatures');
extractSURFDescriptors(input_path,output_path,numOfFeatures,displayImg)




