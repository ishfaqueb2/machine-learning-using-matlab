
% Helper to balance one datastore into files+labels arrays with a given target
function [outFiles, outLabels] = balance_to_target(imds_in, labelsList, target)
    outFiles = {};
    outLabels = [];
    for k = 1:length(labelsList)
        lbl = labelsList{k};
        idx = imds_in.Labels == lbl;
        files_k = imds_in.Files(idx);
        n_k = numel(files_k);
        if n_k == 0
            continue;
        end
        if n_k >= target
            sel = files_k(randperm(n_k, target));
        else
            % oversample with replacement
            rep = ceil(target / n_k);
            files_rep = repmat(files_k, rep, 1);
            sel = files_rep(randperm(numel(files_rep), target));
        end
        outFiles = [outFiles; sel];
        outLabels = [outLabels; repmat(categorical(cellstr(lbl)), numel(sel), 1)];
    end
end