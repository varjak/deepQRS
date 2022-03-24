# deepQRS
An automatic QRS detection algorithm using Deep Learning in MATLAB. It uses an LSTM model to predict the positions of the R peaks in an ECG. This is an adaptation of the detect method in the file correct.py of the Python library NeuXus: https://github.com/LaSEEB/NeuXus/blob/patch-3/neuxus/nodes/correct.py.

To use it, call deepQRS as:

marks = deepQRS(ecg,W,stride=50);

- ecg: ecg vector, sampled at 250 Hz.
- W: struct with the weights and biases of the model;
- stride: number of points to jump between predictions.

As deepQRS slides a prediction window throughout the ecg, it is suitable to be used online by being called repeatedly.

Check example.m for an example on how to use it.
