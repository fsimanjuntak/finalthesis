function extractSURFDescriptors(input_path,output_path,numOfFeatures,display)

addpath('../clandmark-master/matlab_interface/');
addpath('../clandmark-master/matlab_interface/functions/');
addpath('../clandmark-master/matlab_interface/mex/');

% Initialize CLandmark
cdpm_model = './CDPM.xml';
cdpm_flandmark = flandmark_class(cdpm_model);
bw = cdpm_flandmark.getBWsize();
cdpm_featuresPool = featuresPool_class(bw(1), bw(2));
cdpm_featuresPool.addLBPSparseFeatures(0);
cdpm_flandmark.setFeaturesPool(cdpm_featuresPool.getHandle());
fdpm_model = './FDPM.xml';
fdpm_flandmark = flandmark_class(fdpm_model);
bw = fdpm_flandmark.getBWsize();
fdpm_featuresPool = featuresPool_class(bw(1), bw(2));
fdpm_featuresPool.addLBPSparseFeatures(0);
fdpm_flandmark.setFeaturesPool(fdpm_featuresPool.getHandle());

dirlist.maledir             = strcat(input_path,filesep,'male');
dirlist.femaledir           = strcat(input_path,filesep,'female');
dirlist.training.maledir     = strcat(dirlist.maledir,filesep,'training_set');
dirlist.training.femaledir   = strcat(dirlist.femaledir,filesep,'training_set');
dirlist.testing.maledir      = strcat(dirlist.maledir,filesep,'test_set');
dirlist.testing.femaledir    = strcat(dirlist.femaledir,filesep,'test_set');

% Align all images from the source
datasurf.training.features = extractDescriptorsFromDataset(dirlist.training,cdpm_flandmark,fdpm_flandmark,numOfFeatures,display);
datasurf.testing.features = extractDescriptorsFromDataset(dirlist.testing,cdpm_flandmark,fdpm_flandmark,numOfFeatures,display);

% Normalize features between 0 and 1
datasurf.training.features = datasurf.training.features - min(datasurf.training.features);
datasurf.training.features = double(datasurf.training.features ./ max(datasurf.training.features(:)));

datasurf.testing.features = datasurf.testing.features - min(datasurf.testing.features);
datasurf.testing.features = double(datasurf.testing.features ./ max(datasurf.testing.features(:)));

%Check if destination folder or not. If not, create a new one
if ~exist(output_path)
    mkdir(output_path);
end

% Save Descriptors
save([output_path,filesep,'datasurf.mat'],'datasurf');

function [arrDescriptors] = extractDescriptorsFromDataset(indir,cdpm_flandmark,fdpm_flandmark,numOfFeatures,display)
    arrFeatures = []
    idxFeature = 1;
    % Extract features from male directory
    maledirectory = dir(strcat(indir.maledir,filesep,'*.jpg'));
    for i = 1:numel(maledirectory)
       surf_descriptors = extractDescriptors(strcat(maledirectory(i).folder,filesep,maledirectory(i).name),cdpm_flandmark,fdpm_flandmark,numOfFeatures,display);
       %surf_descriptors = extractDescriptors(strcat(maledirectory(i).folder,filesep,'1423.jpg'),cdpm_flandmark,fdpm_flandmark,display);
       arrDescriptors(idxFeature,:) = surf_descriptors;
       idxFeature = idxFeature + 1;
    end
    
    % Extract features from female directory
    femaledirectory = dir(strcat(indir.femaledir,filesep,'*.jpg'));
    for i = 1:numel(femaledirectory)
       surf_descriptors = extractDescriptors(strcat(femaledirectory(i).folder,filesep,femaledirectory(i).name),cdpm_flandmark,fdpm_flandmark,numOfFeatures,display);
       arrDescriptors(idxFeature,:) = surf_descriptors;
       idxFeature = idxFeature + 1;
    end
    


