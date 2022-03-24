function [new_c, new_h] = LSTMcell(x, h, c, wh1, wx1, b1, wh2, wx2, b2, wh3, wx3, b3, wh4, wx4, b4)
new_c = c .* sig(h * wh1 + x * wx1 + b1) + sig(h * wh2 + x * wx2 + b2) .* tanh(h * wh3 + x * wx3 + b3);
new_h = tanh(new_c) .* sig(h * wh4 + x * wx4 + b4);
end
