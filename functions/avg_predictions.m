function [avg_win, pred_wins, n_pred_wins] = avg_predictions(pred_win, pred_wins, n_pred_wins, stride, part_lims)

nparts = size(pred_wins,1);

pred_wins = circshift(pred_wins,1,1);
pred_wins(1,:) = pred_win;
n_pred_wins = n_pred_wins + 1;
avg_win = zeros(numel(pred_win),1);
height = 0;
for j = nparts:-1:1
    height = height + 1;
    parts = nan(nparts,stride);
    for k = 1:min(n_pred_wins, height)
        parts = circshift(parts,1,1);
        parts(1,:) = pred_wins(k,part_lims(j+k-1)+1:part_lims(j+k));
    end
    avg_win(part_lims(j)+1:part_lims(j+1)) = nanmean(parts,1);
end
end
