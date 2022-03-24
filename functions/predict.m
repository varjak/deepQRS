function yt = predict(xt, W)

ht = zeros(W.t, W.u);
c = zeros(1, W.u);

% LSTM-bi 1
hf = LSTMf(xt, ht, c, W.t, W.whf1f, W.wxf1f, W.bf1f, W.whi1f, W.wxi1f, W.bi1f, W.whl1f, W.wxl1f, W.bl1f, W.who1f, W.wxo1f, W.bo1f);
hb = LSTMb(xt, ht, c, W.t, W.whf1b, W.wxf1b, W.bf1b, W.whi1b, W.wxi1b, W.bi1b, W.whl1b, W.wxl1b, W.bl1b, W.who1b, W.wxo1b, W.bo1b);
xt = [hf, hb];
% LSTM-bi 2
hf = LSTMf(xt, ht, c, W.t, W.whf2f, W.wxf2f, W.bf2f, W.whi2f, W.wxi2f, W.bi2f, W.whl2f, W.wxl2f, W.bl2f, W.who2f, W.wxo2f, W.bo2f);
hb = LSTMb(xt, ht, c, W.t, W.whf2b, W.wxf2b, W.bf2b, W.whi2b, W.wxi2b, W.bi2b, W.whl2b, W.wxl2b, W.bl2b, W.who2b, W.wxo2b, W.bo2b);
xt = [hf, hb];
% DENSE
yt = dense(xt, W.wd, W.bd);

end