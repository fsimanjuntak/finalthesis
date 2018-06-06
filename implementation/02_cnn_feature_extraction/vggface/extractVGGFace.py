from keras.engine import  Model
from keras_vggface.vggface import VGGFace
from keras.preprocessing import image
import numpy as np
from keras_vggface import utils
import scipy.io
import glob
import os

# Layer Features
model = 'vgg16'
layer_name = 'fc7'
vgg_model = VGGFace(model=model)
out = vgg_model.get_layer(layer_name).output
vgg_model_new = Model(vgg_model.input, out)

#rootdir = "C:/Users/Newbie/Desktop/MasterThesis/images/LFW/result/lfw/"
arrsource = ["1235","1245","1345","2345"] #["1234"]
# arrsource = ["GENDER-FERET"]
# subfolder = "/"

for source in arrsource:
    rootdir = "C:/Users/Newbie/Desktop/FinalMasterThesis/implementasi/datasource/processedrawdata/LFW/7433grayscalebalancedout/"
    print("================================"+source+"========================================")
    rootdir = rootdir + source
    trainingfemale_directory = rootdir+"/female/training_set/*.jpg"
    trainingmale_directory = rootdir+"/male/training_set/*.jpg"
    testfemale_directory = rootdir+"/female/test_set/*.jpg"
    testmale_directory = rootdir+"/male/test_set/*.jpg"
    output_directory = rootdir+"/results/cnnfeatures"

    #Create Ouput directory if not exist
    if not os.path.exists(output_directory):
        os.makedirs(output_directory)

    #Load image
    FEMALE_LABEL = 1
    MALE_LABEL = 2
    trainingfeaturelist = []
    testfeaturelist = []
    traininglabelslist = []
    testlabelslist = []

    def extractFeatures(featurelist,labels,directory,gender):
        for filename in sorted(glob.glob(directory)):
            img = image.load_img(filename, target_size=(224, 224))
            x = image.img_to_array(img)
            x = np.expand_dims(x, axis=0)
            x = utils.preprocess_input(x, version=1)
            preds = vgg_model_new.predict(x)
            featurelist.append(preds[0])
            labels.append(gender)
        return featurelist,labels;

    # Extract training features
    print("Extracting training features")
    trainingfeaturelist,traininglabelslist = extractFeatures(trainingfeaturelist,traininglabelslist,trainingfemale_directory,FEMALE_LABEL);
    trainingfeaturelist,traininglabelslist = extractFeatures(trainingfeaturelist,traininglabelslist,trainingmale_directory,MALE_LABEL);

    # Extract testing features
    print("Extracting test features")
    testfeaturelist,testlabelslist = extractFeatures(testfeaturelist,testlabelslist,testfemale_directory,FEMALE_LABEL);
    testfeaturelist,testlabelslist = extractFeatures(testfeaturelist,testlabelslist,testmale_directory,MALE_LABEL);

    # Save features to matlab file for further processing
    structfeatures = {}
    structfeatures['trainingFeatures']=trainingfeaturelist
    structfeatures['testFeatures']= testfeaturelist
    structfeatures['trainingLabels']= traininglabelslist
    structfeatures['testLabels']= testlabelslist

    scipy.io.savemat(output_directory+'/vggfacefeatures.mat', {'vggfacefeatures': structfeatures})
    print('==================== Extracting VGGFace features done=====================================')