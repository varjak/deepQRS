function ids = remove_close(win, ids, min_hc_len)

dist = 0;
if numel(ids) > 0
    close_ids = ids(1);
    dist_scores = true(1,numel(ids));
    for i = 2:numel(ids)
        dist = dist + ids(i) - ids(i-1);
        if dist < min_hc_len
            close_ids = [close_ids, ids(i)];
        end
        if dist >= min_hc_len
            [~,max_id] = max(win(close_ids));
            for j = 1:numel(close_ids)
                if j ~= max_id
                    dist_scores(i-numel(close_ids)+j-1) = false;
                end
            end
            close_ids = ids(i);
            dist = 0;
        elseif i == numel(ids)
            [~,max_id] = max(win(close_ids));
            for j = 1:close_ids
               if j ~= max_id
                   dist_scores(i-numel(close_ids)+j+0) = false;
               end
            end
            
        end
        
    end
    ids = ids(dist_scores);
end
end
