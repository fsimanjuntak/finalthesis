function cropFace(img,outputdir)
    % ViolaJones Face detector
    faceDetector = vision.CascadeObjectDetector;
    BB = step(faceDetector,img); % Detect faces

    if isempty(BB)
        face = img;
    elseif size(BB,1) > 1
        [~,idx] = max(BB(:,3));
        face = img(BB(idx,2):BB(idx,2)+BB(idx,4)-1,BB(idx,1):BB(idx,1)+BB(idx,3)-1);
    else
        face = img(BB(2):BB(2)+BB(4)-1,BB(1):BB(1)+BB(3)-1);
    end
        
    % Save cropped image
    imwrite(face, outputdir);
