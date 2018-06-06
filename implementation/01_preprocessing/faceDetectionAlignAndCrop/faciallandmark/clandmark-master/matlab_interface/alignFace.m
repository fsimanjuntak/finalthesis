function [ aligned_img ] = alignFace( img_path,cdpm_flandmark,fdpm_flandmark, display)

    faceDetector = vision.CascadeObjectDetector;

    oriImg = imread(img_path);
    img = imread(img_path);
    fprintf('%s\n',img_path);

    if ndims(img) == 3
        img = rgb2gray(img); % convert to gray
    end

    BB = step(faceDetector,img);

    if isempty(BB)
        aligned_img = img;
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
        if(angle_diff > 5)
            aligned_img = img;
        else
            aligned_img = rotateAround(oriImg, center(2), center(1), theta, 'bilinear');
        end
        
        if (display == 1)
            figure
            imagesc(img); colormap gray; axis image; hold on;
            plot(points(18:end, 1), points(18:end, 2), 'rs', 'LineWidth', 1, 'MarkerSize', 2, 'MarkerFaceColor', 'r');
            plot(center(1), center(2), 'rs', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', 'b');
            plot(mean(points(37:42,1)), mean(points(37:42,2)), 'rs', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', 'b');
            plot(mean(points(43:48,1)), mean(points(43:48,2)), 'rs', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', 'b');
%             subplot(2,2,2)
%             imagesc(img); colormap gray; axis image; hold on;
%             plot(points(18:end, 1), points(18:end, 2), 'rs', 'LineWidth', 1, 'MarkerSize', 2, 'MarkerFaceColor', 'r');
%             plot(center(1), center(2), 'rs', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', 'b');
%             plot(mean(points(37:42,1)), mean(points(37:42,2)), 'rs', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', 'b');
%             plot(mean(points(43:48,1)), mean(points(43:48,2)), 'rs', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', 'b');

            %imagesc(aligned_img); colormap gray; axis image;
        end   
        
    
        
    end
end

