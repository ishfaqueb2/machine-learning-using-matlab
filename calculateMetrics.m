
% Function to calculate detailed metrics
function metrics = calculateMetrics(YTrue, YPred, classes)
    cm = confusionmat(YTrue, YPred);
    
    metrics = struct();
    metrics.confusion_matrix = cm;
    metrics.accuracy = sum(YPred == YTrue) / numel(YTrue);
    
    % Per-class metrics
    for i = 1:length(classes)
        class_name = char(classes(i));
        
        % True positives, false positives, false negatives
        tp = cm(i, i);
        fp = sum(cm(:, i)) - tp;
        fn = sum(cm(i, :)) - tp;
        
        % Precision, Recall, F1-Score
        precision = tp / (tp + fp);
        recall = tp / (tp + fn);
        f1 = 2 * (precision * recall) / (precision + recall);
        
        metrics.(class_name).precision = precision;
        metrics.(class_name).recall = recall;
        metrics.(class_name).f1_score = f1;
    end
end