# deepQRS
An automatic QRS detection algorithm using Deep Learning in MATLAB. It uses an LSTM model to predict the positions of the R peaks in an ECG. This is an adaptation of the detect method in the file correct.py of the Python library NeuXus: https://github.com/LaSEEB/NeuXus/blob/patch-3/neuxus/nodes/correct.py.

To use it, call deepQRS as:

marks = deepQRS(ecg,W,stride);

- ecg: ecg vector, sampled at 250 Hz.
- W: struct with the weights and biases of the model;
- stride: number of points to jump between predictions.

As deepQRS slides a prediction window throughout the ecg, it is suitable to be used online by being called repeatedly.

E.g.: (present in main_deepQRS.m)

%% Load

load('data/data.mat','EEG'); ecg = EEG.data(ismember(upper({EEG.chanlocs(:).labels}),{'ECG','EKG'}),:); W = load('/model/model.mat');

%% Detect

marks = deepQRS(ecg,W,50);

%% Plot

figure, plot(ecg), hold on, plot(marks,ecg(marks),'*r')
