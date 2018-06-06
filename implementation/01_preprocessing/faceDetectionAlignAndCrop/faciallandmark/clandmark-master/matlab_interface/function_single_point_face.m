%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       flandmark_generate_graph_68Point
% This function extract the fiducial points of one image.
% Input
% imRead: The image to read
% Output 
% fiducialPoint: fiducial points 
% edges: the edges of the image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ fiducialPoint, edges ] = function_single_point_face( imRead, cdpm_model, fdpm_model)
   
    %% Add path
    addpath('./matlab_interface/');
    addpath('./matlab_interface/functions/');

    % DOUBLE PRECISION
    %rmpath('./matlab_interface/mex_single_precision/');
    addpath('./matlab_interface/mex/');


    
    %% Init flandmark

    % CDPM
    cdpm_flandmark = flandmark_class(cdpm_model);
    bw = cdpm_flandmark.getBWsize();
    cdpm_featuresPool = featuresPool_class(bw(1), bw(2));
    cdpm_featuresPool.addLBPSparseFeatures(0);
    cdpm_flandmark.setFeaturesPool(cdpm_featuresPool.getHandle());

    % FDPM
    fdpm_flandmark = flandmark_class(fdpm_model);
    bw = fdpm_flandmark.getBWsize();
    fdpm_featuresPool = featuresPool_class(bw(1), bw(2));
    fdpm_featuresPool.addLBPSparseFeatures(0);
    fdpm_flandmark.setFeaturesPool(fdpm_featuresPool.getHandle());

    edges = fdpm_flandmark.getEdges();
    landmark_names = fdpm_flandmark.getLandmarkNames();

    %% Run detector
    bbox=[0 0 128 128];

    % image output
	figure(1); clf(1);
    imshow(imRead, [], 'Border', 'tight'); hold on;
    
    for i = 1 : size(bbox, 1)
        [ P, refined_bbox, Stats ] = c2f_dpm(imRead, int32(bbox(i, :)), cdpm_flandmark, fdpm_flandmark);       
        % show landmarks 
        plot(P(1, :), P(2, :), 'rs', 'LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'r');
        text(P(1, :), P(2, :), landmark_names, 'color', 'r', 'FontSize', 12, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
        for a = 1 : numel(edges(1, :)) 
            line([P(1, edges(1, a)) P(1, edges(2, a))], [P(2, edges(1, a)) P(2, edges(2, a))], 'color', 'b'); 
        end;
    end;
    
    pause(0.3);
    fiducialPoint=P(:,1:endElem)';
 
end
