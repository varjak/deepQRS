function shifted_peak_ids = snap(win,peak_ids)

search_radius = 5;
win_len = numel(win);
shift_ids = zeros(numel(peak_ids),1);


for i = 1:numel(peak_ids)
    ind = peak_ids(i);
    nhood = win(max(1, ind - search_radius):min(ind + search_radius, win_len));
    [~,I] = max(nhood);
    shift_ids(i) = I;
end

for i = 1:numel(peak_ids)
    if peak_ids(i) < search_radius
       shift_ids(i) = shift_ids(i) + (search_radius - peak_ids(i)) + 1;
    end
end
shifted_peak_ids = peak_ids + shift_ids - search_radius -1;
end