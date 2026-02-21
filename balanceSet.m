function [balancedFiles, balancedLabels] = balanceSet(imdsOrig, targetSamples, uniqueLabels)
balancedFiles = {}; balancedLabels = [];
for i = 1:length(uniqueLabels)
    label = uniqueLabels{i};
    idx = imdsOrig.Labels == label;
    files = imdsOrig.Files(idx);
    if length(files) >= targetSamples
        randIdx = randperm(length(files), targetSamples);
        selected = files(randIdx);
    else
        numRepeats = ceil(targetSamples/length(files));
        repeated = repmat(files,numRepeats,1);
        randIdx = randperm(length(repeated), targetSamples);
        selected = repeated(randIdx);
    end
    balancedFiles = [balancedFiles; selected];
    balancedLabels = [balancedLabels; repmat(categorical(cellstr(label)), targetSamples, 1)];
end
end

