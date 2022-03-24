function ht = LSTMb(xt, ht, c, t, whf, wxf, bf, whi, wxi, bi, whl, wxl, bl, who, wxo, bo)
h = ht(1,:);
for i = t:-1:1
    [c, h] = LSTMcell(xt(i,:), h, c, whf, wxf, bf, whi, wxi, bi, whl, wxl, bl, who, wxo, bo);
    ht(i,:) = h;
end
end
