function [SURF_reshapedFeatures] = extractDescriptors( img_path,cdpm_flandmark,fdpm_flandmark,numOfFeatures,display)
    faceDetector = vision.CascadeObjectDetector;
    oriImg = imread(img_path);
    img = imread(img_path);
    fprintf('%s\n',img_path);

    if ndims(img) == 3
        img = rgb2gray(img); % convert to gray
    end

    BB = step(faceDetector,img);

    if isempty(BB)
        SURF_points = detectSURFFeatures(img);

        % If the number of SURF points are greater than 51 then, remove
        % consider only 51 points
        if (numel(SURF_points.Location) > 51)
            [~, valid_points] = extractFeatures(img, SURF_points,'Method','SURF','FeatureSize',128);
            SURF_points = valid_points.selectStrongest(51);
        end
    else
        if size(BB,1) > 1
            [~,idx] = max(BB(:,3));
            rect = BB(idx,:);
        else
            rect = BB;
        end

        [ P, refined_bbox, Stats ] = c2f_dpm(img, [rect(1),rect(2),rect(1)+rect(3),rect(2)+rect(4)], cdpm_flandmark, fdpm_flandmark);
        points = P';
        p1 = mean(points(37:42,:));
        p2 = mean(points(43:48,:));
        dy = p1(2)-p2(2);
        dx = p1(1)-p2(1);
        if dx == 0
            dx = eps;
        end
        m = dy/dx;
        theta = atan(m)*180/pi;
        center = mean([p1;p2]);
        p1 = points(49,:);
        p2 = points(55,:);
        dy = p1(2)-p2(2);
        dx = p1(1)-p2(1);
        if dx == 0
            dx = eps;
        end
        m = dy/dx;
        theta2 = atan(m)*180/pi;
        angle_diff = abs(theta-theta2);
        fiduciallocations =abs([points(18:end, 1) points(18:end, 2)]);
        SURF_points = SURFPoints(fiduciallocations);        

        if (display == 1)
            figure
            imagesc(img); colormap gray; axis image; hold on;
            plot(points(18:end, 1), points(18:end, 2), 'rs', 'LineWidth', 1, 'MarkerSize', 2, 'MarkerFaceColor', 'r');
            plot(center(1), center(2), 'rs', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', 'b');
            plot(mean(points(37:42,1)), mean(points(37:42,2)), 'rs', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', 'b');
            plot(mean(points(43:48,1)), mean(points(43:48,2)), 'rs', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', 'b');
        end   
    end
    % create new vectors to hold 51 fiducial points
    [SURF_features, ~] = extractFeatures(img, SURF_points,'Method','SURF','FeatureSize',128); 
     % 'FeatureSize', 128);
    numOfSURFfeatures = numel(SURF_features);
    SURF_reshapedFeatures = reshape(SURF_features,1,numOfSURFfeatures);
    if (numOfFeatures > numOfSURFfeatures)
        zeroFeatures = single(zeros(1, numOfFeatures-numOfSURFfeatures));
        SURF_reshapedFeatures = [SURF_reshapedFeatures';zeroFeatures'];
        SURF_reshapedFeatures = SURF_reshapedFeatures';
    end
end

