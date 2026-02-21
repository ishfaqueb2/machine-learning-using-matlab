
%% Preprocessing Function
function processedImg = applyPreprocessing(inputData)
    % Extract image from input data
    if isstruct(inputData)
        img = inputData.input;
    else
        img = inputData;
    end
    
    % Convert to grayscale if RGB
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Apply contrast enhancement
    img = imadjust(img);
    
    % Apply median filter to reduce noise
    img = medfilt2(img, [3 3]);
    
    % Edge enhancement using unsharp masking
    img = imsharpen(img, 'Amount', 1.5);
    
    % Convert back to RGB for network input
    processedImg = cat(3, img, img, img);
    
    % Normalize to [0, 1]
    processedImg = im2double(processedImg);
end

