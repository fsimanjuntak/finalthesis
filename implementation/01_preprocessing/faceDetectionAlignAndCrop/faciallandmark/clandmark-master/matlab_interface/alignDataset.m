function alignDataset( input_path, output_path, display)

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
dirlist.trainingmaledir     = strcat(dirlist.maledir,filesep,'training_set');
dirlist.trainingfemaledir   = strcat(dirlist.femaledir,filesep,'training_set');
dirlist.testingmaledir      = strcat(dirlist.maledir,filesep,'test_set');
dirlist.testingfemaledir    = strcat(dirlist.femaledir,filesep,'test_set');

outdirlist.maledir             = strcat(output_path,filesep,'male');
outdirlist.femaledir           = strcat(output_path,filesep,'female');
outdirlist.trainingmaledir     = strcat(outdirlist.maledir,filesep,'training_set');
outdirlist.trainingfemaledir   = strcat(outdirlist.femaledir,filesep,'training_set');
outdirlist.testingmaledir      = strcat(outdirlist.maledir,filesep,'test_set');
outdirlist.testingfemaledir    = strcat(outdirlist.femaledir,filesep,'test_set');

%Check if destination folder or not. If not, create a new one
output_folders = {outdirlist.trainingmaledir,outdirlist.trainingfemaledir,outdirlist.testingmaledir,outdirlist.testingfemaledir}
for i=1:numel(output_folders)
  outputpath = output_folders{i}
  if ~exist(outputpath)
    mkdir(outputpath);
  end
end

% Align all images from the source
alignImages(dirlist.trainingmaledir,outdirlist.trainingmaledir,cdpm_flandmark,fdpm_flandmark, display);
alignImages(dirlist.trainingfemaledir,outdirlist.trainingfemaledir,cdpm_flandmark,fdpm_flandmark, display);
alignImages(dirlist.testingmaledir,outdirlist.testingmaledir,cdpm_flandmark,fdpm_flandmark, display);
alignImages(dirlist.testingfemaledir,outdirlist.testingfemaledir,cdpm_flandmark,fdpm_flandmark, display);

function alignImages(indir,outdir,cdpm_flandmark,fdpm_flandmark,display)
    d = dir(strcat(indir,filesep,'*.jpg'));
    for i = 1:numel(d)
       aligned_img = alignFace(strcat(indir,filesep,d(i).name),cdpm_flandmark,fdpm_flandmark,display);
       cropFace(aligned_img,strcat(outdir,filesep,d(i).name));
    end


