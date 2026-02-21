%% ===== HELPER FUNCTIONS =====
function [balancedFiles, balancedLabels] = balanceDataset(imds, uniqueLabels, targetSamples)
    balancedFiles = {};
    balancedLabels = [];
    
    for i = 1:length(uniqueLabels)
        label = uniqueLabels{i};
        labelIdx = imds.Labels == label;
        labelFiles = imds.Files(labelIdx);
        
        if length(labelFiles) >= targetSamples
            randIdx = randperm(length(labelFiles), targetSamples);
            selectedFiles = labelFiles(randIdx);
        else
            numRepeats = ceil(targetSamples / length(labelFiles));
            repeatedFiles = repmat(labelFiles, numRepeats, 1);
            randIdx = randperm(length(repeatedFiles), targetSamples);
            selectedFiles = repeatedFiles(randIdx);
        end
        
        balancedFiles = [balancedFiles; selectedFiles];
        balancedLabels = [balancedLabels; repmat(categorical(cellstr(label)), targetSamples, 1)];
    end
end
