function ht = LSTMf(xt, ht, c, t, whf, wxf, bf, whi, wxi, bi, whl, wxl, bl, who, wxo, bo)
h = ht(t,:);
for i = 1:t
    [c, h] = LSTMcell(xt(i,:), h, c, whf, wxf, bf, whi, wxi, bi, whl, wxl, bl, who, wxo, bo);
    ht(i,:) = h;
end
end
