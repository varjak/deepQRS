function ids = remove_underrepresented(ids,thres)

[counts,vals] = hist(ids,unique(ids));
ids = vals(counts >= thres);

end