function peak_ids = deepQRS(ecg,W,stride)
% ecg:          vector of points, sampled at 250 Hz
% W:            struct with weights and biases of the LSTM model
% stride:       scalar, meaning the number of points to jump between detections (each occurs in a window with length defined by the model)
%
% Eg.:  1 - add deepQRS folder/subfolders to path
%       2 - load('EEG.mat'); ecg = EEG.data(ismember(upper({EEG.chanlocs(:).labels}),{'ECG','EKG'}),:); W = load('weights.mat');
%       3 - deepQRS(ecg,W,stride)

ecg = ecg(:);  % Convert to column
win_len = W.t;  % 500

part_lims = 0:stride:win_len;
nparts = numel(part_lims)-1;
pred_wins = zeros(nparts, win_len);
n_pred_wins = 0;

thres = 0.05;
min_hc_len = 100;
peak_ids = [];

for i = 1:stride:numel(ecg)-win_len+1
    %% Get window
    win = ecg(i:i+win_len-1);
    
    %% Normalize
    norm_win = -1 + 2.*(win - min(win))./(max(win) - min(win));
    
    %% Predict
    pred_win = predict(norm_win, W);
    
    %% Average
    [avg_win, pred_wins, n_pred_wins] = avg_predictions(pred_win, pred_wins, n_pred_wins, stride, part_lims);
    
    %% Threshold
    thres_ids = find(avg_win > thres);
    
    %% Snap detections to local maxima
    snap_ids = snap(win,thres_ids);
    
    %% Filter maxima (consider just those w/ 5 snaps or more)
    strong_ids = remove_underrepresented(snap_ids,5);
    
    %% Remove close maxima
    filt_ids = remove_close(win, strong_ids, min_hc_len);
    
    %% Store
    if i < numel(ecg)-win_len+1
        fix_ids = filt_ids(filt_ids<=stride);
    else
        fix_ids = filt_ids;
    end
    if ~isempty(fix_ids)
        peak_ids = [peak_ids, fix_ids+i-1];
    end
end
end
